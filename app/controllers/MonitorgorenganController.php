<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\View;
use Phalcon\Db;

class MonitorgorenganController extends Controller {

   // ================================= PRIVATE METHODS =================================
   
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
   
   private function getPenyajiData(): array {
      $karyawan = $this->db->fetchAll(
         "SELECT username AS nik, nama_alias
         FROM users_employee
         WHERE org_department_id = '06' -- karyawan restoran
         ORDER BY nama_alias",
         Db::FETCH_ASSOC
      );

      $parttimer = $this->db->fetchAll(
         "SELECT nomor_id_card AS nik, nama_alias
         FROM pt_vpresence
         WHERE tanggal = CURRENT_DATE
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

   private function getPendingNotaData(): array {
      $sql =
         "SELECT
            j.j_kode,
            j.o_kode,
            o.o_cnama,
            COALESCE(ma.area, '-') AS area,
            o.o_jmlorg,
            to_char(j.j_jam, 'HH24:MI') AS j_jam,
            to_char(current_time::time - j . j_jam, 'HH24:MI:SS') AS tunggu,
            j.j_pengantar,
            o.o_meja,
            o.o_note
         FROM sel_jual_hariini AS j
            LEFT JOIN monitor_area_hariini AS ma USING (o_kode)
            INNER JOIN sel_orders_hariini AS o USING (o_kode)
         WHERE
            o.o_jmlorg >= 0
            AND j.j_jamsajigorengan IS NULL
            AND (EXISTS (
               SELECT 1
               FROM sel_ordersdetil_hariini AS od
               INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
               WHERE od.o_kode = j.o_kode
                  AND m.kategori = 'LAIN-LAIN'
            ) OR o.o_note ILIKE 'TAMB%')
         ORDER BY j.j_jam";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);

      foreach ($records as &$record) {
         [$notaStr] = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;
         $record['has_meja'] = trim((string) $record['o_meja']) !== '';
         if (!$record['has_meja']) {
            $record['o_meja'] = '';
         }
         $isTamb = str_starts_with(strtoupper(trim((string)$record['o_note'])), 'TAMB');
         $kategoriFilter = $isTamb 
            ? "AND kategori IN ('MAKANAN', 'MINUMAN', 'LAIN-LAIN')" 
            : "AND kategori = 'LAIN-LAIN'";

         $detailNota = $this->dbNa->fetchAll(
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
               $kategoriFilter
            ORDER BY sel_mmenu_id",
            Db::FETCH_ASSOC,
            [
               'o_kode' => $record['o_kode'],
            ]
         );

         $record['detail_nota'] = $detailNota;
         $record['detail_nota_json'] = json_encode($detailNota);
         $record['detail_nota_base64'] = base64_encode($record['detail_nota_json']);
         $record['jumlah_nota'] = count($detailNota);
      }
      unset($record);

      return json_decode(json_encode($records), false);
   }
   
   private function getOrderedNotaSummary(): array {
      $sql = "SELECT
            m.sel_mmenu_id,
            CASE
               WHEN m.olahan IS NULL THEN m.nama
               ELSE m.nama || ' ' || m.olahan
            END AS nama_olahan,
            m.satuan,
            COUNT(DISTINCT od.o_kode) AS jml_nota,
            COALESCE(SUM(od.od_qty), 0) AS total_qty,
            COUNT(DISTINCT CASE WHEN COALESCE(o.o_meja, '') = '' THEN od.o_kode END) AS jml_nota_belum_meja
         FROM sel_ordersdetil_hariini AS od
         INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
         INNER JOIN sel_jual_hariini AS j USING (o_kode)
         INNER JOIN sel_orders_hariini AS o USING (o_kode)
         WHERE 
            (m.kategori = 'LAIN-LAIN' OR (o.o_note ILIKE 'TAMB%' AND m.kategori IN ('MAKANAN', 'MINUMAN', 'LAIN-LAIN')))
            AND o.o_jmlorg >= 0
            AND j.j_jamsajigorengan IS NULL
         GROUP BY
            m.sel_mmenu_id,
            m.nama,
            m.olahan,
            m.satuan
         ORDER BY 
            m.sel_mmenu_id";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);

      return json_decode(json_encode($records), false);
   }

   private function assignViewData(): void {
      $penyaji = $this->getPenyajiData();

      $this->view->daftar_nota = $this->getPendingNotaData();
      $this->view->daftar_nota_order = $this->getOrderedNotaSummary();
      $this->view->daftar_penyaji_karyawan = $penyaji['karyawan'];
      $this->view->daftar_penyaji_parttimer = $penyaji['parttimer'];
   }
   
   // ================================= PUBLIC METHODS =================================

   public function indexAction() {
      $this->assignViewData();
   }

   public function loadAction() {
      $this->assignViewData();
      $this->view->pick('monitorgorengan/load');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }
}