<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\View;
use Phalcon\Db;

class MonitorminumanController extends Controller {

   // ==========================================================================
   //  FORMAT NOTA (BINTANG)
   // ==========================================================================
   private function formatNotaKode(int $jkode): array {

      $row = $this->dbNa->fetchOne("
         SELECT COALESCE(startwith,1) AS startwith, COALESCE(reafter,100) AS reafter
         FROM sel_formatnota
         ORDER BY tanggal DESC, jam DESC
         LIMIT 1
      ", \Phalcon\Db::FETCH_ASSOC) ?: ['startwith' => 1, 'reafter' => 100];

      $startwith = (int) $row['startwith'];
      $reafter   = (int) $row['reafter'];
      $denom     = max(1, $reafter - ($startwith - 1));

      if ($jkode <= 0) {
         $nomor   = 0;
         $bintang = 0;
      } elseif ($jkode <= $reafter) {
         $nomor   = $jkode;
         $bintang = 0;
      } else {
         $offset  = $jkode - ($reafter + 1);
         $bintang = intdiv($offset, $denom) + 1;
         $nomor   = $startwith + ($offset % $denom);
      }

      $nomor3  = str_pad((string) $nomor, 3, '0', STR_PAD_LEFT);
      $notaStr = $nomor3 . '*' . $bintang;

      return [$notaStr, $nomor, $bintang, $denom, $startwith, $reafter];
   }

   private function getPenyajiMinumanData(): array {
      $karyawan = $this->db->fetchAll(
         "SELECT username AS nik, nama_alias
         FROM users_employee
         WHERE org_department_id = '06'
            AND jab_id IN (5151, 5103, 5152)
         ORDER BY nama_alias",
         Db::FETCH_ASSOC
      );

      $parttimer = $this->db->fetchAll(
         "SELECT nomor_id_card AS nik, nama_alias
         FROM pt_vpresence
         WHERE tanggal = '2026-01-01'
            AND keterangan = 1
            AND namapos IN ('PRAMUSAJI', 'DAPUR SAJI')
         ORDER BY nama_alias",
         Db::FETCH_ASSOC
      );

      return [
         'karyawan' => json_decode(json_encode($karyawan), false),
         'parttimer' => json_decode(json_encode($parttimer), false),
      ];
   }

   private function getPenyajiNikMap(): array {
      $penyaji = $this->getPenyajiMinumanData();
      $nikMap = [];

      foreach (['karyawan', 'parttimer'] as $group) {
         foreach ($penyaji[$group] as $item) {
            $nikMap[(string) $item->nik] = (string) $item->nama_alias;
         }
      }

      return $nikMap;
   }

   private function getPendingMinumanData(): array {

      $sql =
         "SELECT
            j.j_kode,
            j.o_kode,
            o.o_cnama,
            ma.area,
            o.o_jmlorg,
            to_char(j.j_jam, 'HH24:MI') AS j_jam,
            to_char(current_time::time - j . j_jam, 'HH24:MI:SS') AS tunggu,
            j.j_pengantar,
            o.o_meja
         FROM sel_jual_hariini AS j
            INNER JOIN monitor_area_hariini AS ma USING (o_kode)
            INNER JOIN sel_orders_hariini AS o USING (o_kode)
            LEFT JOIN kurang_stocketalase AS ks USING (o_kode)
         WHERE
            o.o_meja NOT IN ('')
            AND o.o_jmlorg >= 1
            AND j.j_jamsajiminum IS NULL
            AND ks.jam_kurang IS NULL
            AND EXISTS (
               SELECT 1
               FROM sel_ordersdetil_hariini AS od
               INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
               WHERE od.o_kode = j.o_kode
                  AND m.kategori = 'MINUMAN'
            )
         ORDER BY j.j_jam";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);

      foreach ($records as &$record) {
         [$notaStr] = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;

         $detailMinuman = $this->dbNa->fetchAll(
            "SELECT
               o_kode,
               sel_mmenu_id,
               CASE
                  WHEN olahan IS NULL THEN nama
                  ELSE nama || ' ' || olahan
               END AS nama_olahan,
               od_qty,
               satuan,
               od_hrg,
               od_disc,
               od_jmlhrg
            FROM sel_ordersdetil_hariini
            INNER JOIN sel_mmenu USING (sel_mmenu_id)
            WHERE o_kode = :o_kode
               AND kategori = 'MINUMAN'
            ORDER BY sel_mmenu_id",
            Db::FETCH_ASSOC,
            [
               'o_kode' => $record['o_kode'],
            ]
         );

         $record['detail_minuman'] = $detailMinuman;
         $record['detail_minuman_json'] = json_encode($detailMinuman);
         $record['detail_minuman_base64'] = base64_encode($record['detail_minuman_json']);
         $record['jumlah_minuman'] = count($detailMinuman);
      }
      unset($record);

      return json_decode(json_encode($records), false);
   }

   private function getOrderedMinumanSummary(): array {
      $sql = "SELECT
            m.sel_mmenu_id,
            CASE
               WHEN m.olahan IS NULL THEN m.nama
               ELSE m.nama || ' ' || m.olahan
            END AS nama_olahan,
            m.satuan,
            COUNT(DISTINCT od.o_kode) AS jml_nota,
            COALESCE(SUM(od.od_qty), 0) AS total_qty
         FROM sel_ordersdetil_hariini AS od
         INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
         INNER JOIN sel_jual_hariini AS j USING (o_kode)
         INNER JOIN sel_orders_hariini AS o USING (o_kode)
         INNER JOIN monitor_area_hariini AS ma USING (o_kode)
         LEFT JOIN kurang_stocketalase AS ks USING (o_kode)
         WHERE m.kategori = 'MINUMAN'
            AND o.o_meja NOT IN ('')
            AND o.o_jmlorg >= 1
            AND j.j_jamsajiminum IS NULL
            AND ks.jam_kurang IS NULL
         GROUP BY
            m.sel_mmenu_id,
            m.nama,
            m.olahan,
            m.satuan
         ORDER BY m.sel_mmenu_id";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);

      return json_decode(json_encode($records), false);
   }

   private function assignViewData(): void {
      $penyaji = $this->getPenyajiMinumanData();

      $this->view->daftar_nota = $this->getPendingMinumanData();
      $this->view->daftar_minuman_order = $this->getOrderedMinumanSummary();
      $this->view->daftar_penyaji_karyawan = $penyaji['karyawan'];
      $this->view->daftar_penyaji_parttimer = $penyaji['parttimer'];
   }

   public function indexAction() {
      $this->assignViewData();
   }

   public function loadAction() {
      $this->assignViewData();
      $this->view->pick('monitorminuman/load');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

   public function scan_notaAction() {
      $this->view->disable();

      if (!$this->request->isPost()) {
         return $this->response->redirect('monitorminuman/index');
      }

      $oKode = trim((string) $this->request->getPost('o_kode', 'string'));
      $nik = trim((string) $this->request->getPost('nik_penyaji', 'string'));

      if ($oKode === '' || $nik === '') {
         $this->flashSession->error('Data nota atau penyaji minuman belum lengkap.');
         return $this->response->redirect('monitorminuman/index');
      }

      $nikMap = $this->getPenyajiNikMap();
      if (!isset($nikMap[$nik])) {
         $this->flashSession->error('Penyaji minuman tidak valid.');
         return $this->response->redirect('monitorminuman/index');
      }

      $success = $this->dbNa->execute(
         "UPDATE sel_jual_hariini
         SET
            j_jamsajiminum = CURRENT_TIME,
            j_penyajiminum = :nik
         WHERE o_kode = :o_kode
            AND j_jamsajiminum IS NULL",
         [
            'nik' => $nik,
            'o_kode' => $oKode,
         ]
      );

      if ($success && $this->dbNa->affectedRows() > 0) {
         $this->flashSession->success('Status minuman tersaji berhasil disimpan.');
      } else {
         $this->flashSession->warning('Nota tidak ditemukan atau minumannya sudah tersaji.');
      }

      return $this->response->redirect('monitorminuman/index');
   }
   
}
