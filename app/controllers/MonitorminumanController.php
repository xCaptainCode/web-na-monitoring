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

   private function getPenyajiAliasMap(): array {
      $aliasMap = [];

      $karyawan = $this->db->fetchAll(
         "SELECT username AS nik, nama_alias
         FROM users_employee",
         Db::FETCH_ASSOC
      );

      $parttimer = $this->db->fetchAll(
         "SELECT nomor_id_card AS nik, nama_alias
         FROM pt_vpresence
         WHERE tanggal = CURRENT_DATE
            AND keterangan = 1",
         Db::FETCH_ASSOC
      );

      foreach ($karyawan as $item) {
         $aliasMap[(string) $item['nik']] = (string) $item['nama_alias'];
      }

      foreach ($parttimer as $item) {
         $aliasMap[(string) $item['nik']] = (string) $item['nama_alias'];
      }

      return $aliasMap;
   }

   private function resolvePenyajiName(?string $nik, array $aliasMap = []): string {
      $nik = trim((string) $nik);

      if ($nik === '') {
         return '-';
      }

      if (isset($aliasMap[$nik]) && $aliasMap[$nik] !== '') {
         return (string) $aliasMap[$nik];
      }

      return $nik;
   }

   private function hasPenjagaEtalaseToday(): bool {
      $row = $this->db->fetchOne(
         "SELECT COUNT(*) AS total
          FROM penjaga_etalase
          WHERE tanggal = current_date",
         Db::FETCH_ASSOC
      );

      return ((int) ($row['total'] ?? 0)) > 0;
   }

   private function isAreaPancing(?string $area): bool {
      return strtoupper(trim((string) $area)) === 'AREA PANCING';
   }

   private function getEtalaseQtyByNota(string $oKode, int $jmlorg): array {
      $qtyData = $this->dbNa->fetchOne(
         "SELECT
            MAX(CASE WHEN m.is_sajiprg = 't' THEN 1 ELSE 0 END) AS ada_prg,
            MAX(CASE WHEN m.is_sajigls = 't' THEN 1 ELSE 0 END) AS ada_gls,
            MAX(CASE WHEN m.satuan = 'TKO' THEN 1 ELSE 0 END) AS ada_teko,
            COALESCE(SUM(od.od_qty * COALESCE(m.min_prg, 0)), 0) AS ttl_min_prg,
            COALESCE(SUM(od.od_qty * COALESCE(m.min_gls, 0)), 0) AS ttl_min_gls
         FROM sel_ordersdetil_hariini AS od
         INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
         WHERE od.o_kode = :o_kode",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      ) ?: [
         'ada_prg' => 0,
         'ada_gls' => 0,
         'ada_teko' => 0,
         'ttl_min_prg' => 0,
         'ttl_min_gls' => 0,
      ];

      $adaPrg = (int) $qtyData['ada_prg'] === 1;
      $adaGls = (int) $qtyData['ada_gls'] === 1;
      $adaTeko = (int) $qtyData['ada_teko'] >= 1;
      $minPrg = (int) $qtyData['ttl_min_prg'];
      $minGls = (int) $qtyData['ttl_min_gls'];

      $qtyPiring = $adaPrg ? max(0, $jmlorg - $minPrg) : 0;
      $qtyGelas = 0;

      if ($adaGls) {
         $qtyGelas = $adaTeko ? $jmlorg : max(0, $jmlorg - $minGls);
      }

      return [
         'qty_piring' => $qtyPiring,
         'qty_gelas' => $qtyGelas,
      ];
   }

   private function getPendingMinumanData(): array {

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
            LEFT JOIN kurang_stocketalase AS ks USING (o_kode)
         WHERE
            o.o_jmlorg >= 0
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
         $record['has_meja'] = trim((string) $record['o_meja']) !== '';
         if (!$record['has_meja']) {
            $record['o_meja'] = '';
         }

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
            COALESCE(SUM(od.od_qty), 0) AS total_qty,
            COUNT(DISTINCT CASE WHEN COALESCE(o.o_meja, '') = '' THEN od.o_kode END) AS jml_nota_belum_meja
         FROM sel_ordersdetil_hariini AS od
         INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
         INNER JOIN sel_jual_hariini AS j USING (o_kode)
         INNER JOIN sel_orders_hariini AS o USING (o_kode)
         LEFT JOIN monitor_area_hariini AS ma USING (o_kode)
         LEFT JOIN kurang_stocketalase AS ks USING (o_kode)
         WHERE m.kategori = 'MINUMAN'
            AND o.o_jmlorg >= 0
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

   private function getRiwayatMinumanData(): array {
      $sql = "SELECT
            j.j_kode,
            j.o_kode,
            o.o_cnama,
            o.o_meja,
            TO_CHAR(j.j_jamsajiminum, 'HH24:MI') AS jam_saji,
            TO_CHAR(j.j_jamsajiminum::time - j.j_jam, 'HH24:MI:SS') AS proses,
            j.j_penyajiminum
         FROM sel_jual_hariini AS j
         INNER JOIN sel_orders_hariini AS o USING (o_kode)
         WHERE
            j.j_jamsajiminum IS NOT NULL
            AND EXISTS (
               SELECT 1
               FROM sel_ordersdetil_hariini AS od
               INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
               WHERE od.o_kode = j.o_kode
                  AND m.kategori = 'MINUMAN'
            )
         ORDER BY j.j_kode DESC";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);
      $aliasMap = $this->getPenyajiAliasMap();

      foreach ($records as &$record) {
         [$notaStr] = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;
         $nik = (string) $record['j_penyajiminum'];
         $record['pramusaji'] = $aliasMap[$nik] ?? $nik;
      }
      unset($record);

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

   public function riwayatAction() {
      $this->view->riwayat_nota = $this->getRiwayatMinumanData();
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

      $nota = $this->dbNa->fetchOne(
         "SELECT
            COALESCE(o.o_meja, '') AS o_meja,
            o.o_jmlorg,
            COALESCE(ma.area, '') AS area
         FROM sel_orders_hariini AS o
         LEFT JOIN monitor_area_hariini AS ma USING (o_kode)
         WHERE o_kode = :o_kode",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      if (!$nota || trim((string) $nota['o_meja']) === '') {
         $this->flashSession->warning('Nota belum mendapat meja, jadi belum bisa di-scan.');
         return $this->response->redirect('monitorminuman/index');
      }

      $nikMap = $this->getPenyajiNikMap();
      if (!isset($nikMap[$nik])) {
         $this->flashSession->error('Penyaji minuman tidak valid.');
         return $this->response->redirect('monitorminuman/index');
      }

      $hasPenjagaToday = $this->hasPenjagaEtalaseToday();
      $areaPancing = $this->isAreaPancing($nota['area'] ?? '');
      $shouldKurangEtalase = $hasPenjagaToday ? $areaPancing : true;

      $stockEtalaseSaved = true;
      if ($shouldKurangEtalase) {
         $jmlorg = (int) ($nota['o_jmlorg'] ?? 0);
         $qty = $this->getEtalaseQtyByNota($oKode, $jmlorg);

         if ($qty['qty_piring'] > 0 || $qty['qty_gelas'] > 0) {
            $existingKurang = $this->dbNa->fetchOne(
               "SELECT 1
                FROM kurang_stocketalase
                WHERE o_kode = :o_kode
                LIMIT 1",
               Db::FETCH_ASSOC,
               [
                  'o_kode' => $oKode,
               ]
            );

            if (!$existingKurang) {
               $stockEtalaseSaved = $this->dbNa->execute(
                  "INSERT INTO kurang_stocketalase (id_area, qty_piring, qty_gelas, o_kode, pengantar)
                   VALUES (1, :qty_piring, :qty_gelas, :o_kode, :pengantar)",
                  [
                     'qty_piring' => $qty['qty_piring'],
                     'qty_gelas' => $qty['qty_gelas'],
                     'o_kode' => $oKode,
                     'pengantar' => $nikMap[$nik] ?? $nik,
                  ]
               );
            }
         }
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

      if ($success && $this->dbNa->affectedRows() > 0 && $stockEtalaseSaved) {
         $this->flashSession->success('Status minuman tersaji berhasil disimpan.');
      } elseif ($success && $this->dbNa->affectedRows() > 0) {
         $this->flashSession->warning('Status minuman tersaji tersimpan, tetapi pengurangan stock etalase gagal.');
      } else {
         $this->flashSession->warning('Nota tidak ditemukan atau minumannya sudah tersaji.');
      }

      return $this->response->redirect('monitorminuman/index');
   }
   
   // ==========================================================================
   //  DETAIL NOTA
   // ==========================================================================
   public function detail_notaAction($o_kode) {
      $oKode = trim((string) $o_kode);

      $notaData = $this->dbNa->fetchOne(
         "SELECT
            j_jam,
            p.o_kode,
            p.j_kode,
            o_cnama,
            o_meja,
            rak,
            CASE
               WHEN j_jamsaji IS NOT NULL THEN j_jamsaji - j_jam
               WHEN j_jamsaji IS NULL AND j_jamdibungkus IS NULL THEN '0'
               WHEN o_note LIKE '%BUNG%' THEN j_jamdibungkus - j_jam
            END AS waktusaji,
            CASE
               WHEN waktu_sesek IS NULL THEN '0'
               WHEN waktu_dapurkerja IS NULL THEN '0'
               ELSE waktu_dapurkerja - waktu_sesek
            END AS bakaran,
            CASE
               WHEN waktu_sesek IS NULL THEN '0'
               ELSE waktu_sesek - j_jam
            END AS sesek,
            CASE
               WHEN waktu_sesek IS NULL THEN '0'
               WHEN waktu_goreng IS NULL THEN '0'
               ELSE waktu_goreng - waktu_sesek
            END AS goreng,
            CASE
               WHEN waktu_dapurkerja IS NULL THEN '0'
               WHEN j_jamsaji IS NULL THEN '0'
               WHEN o_note LIKE '%BUNG%' THEN j_jamdibungkus - waktu_dapurkerja
               WHEN waktu_dapurkerja > j_jamsaji THEN '0'
               WHEN waktu_sesek > j_jamsaji THEN '0'
               ELSE j_jamsaji - waktu_dapurkerja
            END AS proses_saji,
            SUBSTRING(o_note, 1, 45) AS catatan,
            o_jmlorg
         FROM sel_orders_hariini
         INNER JOIN sel_jual_hariini AS p USING (o_kode)
         LEFT JOIN sel_dapurkerja_hariini USING (j_kode)
         WHERE p.o_kode = :o_kode
         ORDER BY j_kode",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      if (!$notaData) {
         $this->flashSession->error('Nota tidak ditemukan.');
         return $this->response->redirect('monitorminuman/riwayat');
      }

      [$notaStr] = $this->formatNotaKode((int) $notaData['j_kode']);
      $notaData['nota_format'] = $notaStr;

      $transaksiData = $this->dbNa->fetchOne(
         "SELECT
            j_kode,
            o_kode,
            j_jam,
            j_tgl,
            j_pajaknom,
            j_penyaji,
            j_penyajiminum,
            j_penyajigorengan,
            j_jmltotal,
            j_discash,
            j_discashnom,
            j_cash,
            j_kembali,
            j_namakasir,
            j_penerimasusuk,
            j_pengantar,
            j_jamsajiminum,
            j_jamsajigorengan,
            j_jamsaji,
            p.username,
            SUBSTRING(o_note, 1, 45) AS catatan
         FROM sel_jual_hariini
         INNER JOIN sel_orders_hariini AS p USING (o_kode)
         WHERE o_kode = :o_kode",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      $menuRingkas = $this->dbNa->fetchAll(
         "SELECT
            od_qty,
            satuan,
            od_ekor,
            CASE
               WHEN olahan IS NULL THEN nama
               ELSE nama || ' ' || olahan
            END AS nama_olahan
         FROM sel_ordersdetil_hariini
         INNER JOIN sel_mmenu USING (sel_mmenu_id)
         WHERE o_kode = :o_kode",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      $ikanData = $this->dbNa->fetchAll(
         "SELECT
            nama,
            SUM(oi_qty) AS oi_qty,
            SUM(ts_kelas * oi_qty) AS total
         FROM sel_ordersikan_hariini
         INNER JOIN wh_mikan USING (wh_mikan_id)
         WHERE o_kode = :o_kode
         GROUP BY nama",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      $menuDetail = $this->dbNa->fetchAll(
         "SELECT
            o_kode,
            sel_mmenu_id,
            CASE
               WHEN olahan IS NULL THEN nama
               ELSE nama || ' ' || olahan
            END AS nama_olahan,
            od_qty,
            satuan,
            od_ekor,
            od_hrg,
            od_disc,
            od_jmlhrg
         FROM sel_ordersdetil_hariini
         INNER JOIN sel_mmenu USING (sel_mmenu_id)
         WHERE o_kode = :o_kode
         ORDER BY sel_mmenu_id, od_ekor DESC",
         Db::FETCH_ASSOC,
         [
            'o_kode' => $oKode,
         ]
      );

      $aliasMap = $this->getPenyajiAliasMap();

      $this->view->data = json_decode(json_encode($notaData), false);
      $this->view->data1 = json_decode(json_encode($transaksiData), false);
      $this->view->data2 = json_decode(json_encode($menuRingkas), false);
      $this->view->data3 = json_decode(json_encode($ikanData), false);
      $this->view->data4 = json_decode(json_encode($menuDetail), false);
      $this->view->penyaji = $this->resolvePenyajiName($transaksiData['j_penyaji'] ?? '', $aliasMap);
      $this->view->penyaji_minum = $this->resolvePenyajiName($transaksiData['j_penyajiminum'] ?? '', $aliasMap);
      $this->view->penyaji_gorengan = $this->resolvePenyajiName($transaksiData['j_penyajigorengan'] ?? '', $aliasMap);
   }
   
}
