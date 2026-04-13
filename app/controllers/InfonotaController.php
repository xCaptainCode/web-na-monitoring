<?php

use Phalcon\Db;
use Phalcon\Mvc\Controller;

class InfonotaController extends Controller {

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

   private function getRiwayatNotaData(): array {
      $sql = "SELECT
				j.j_kode,
				j.o_kode,
				o.o_cnama,
				o.o_meja,
				TO_CHAR(j.j_jamsajiminum, 'HH24:MI') AS jam_saji,
				TO_CHAR(j.j_jamsajiminum::time - j.j_jam, 'HH24:MI:SS') AS proses,
				j.j_penyaji,
				j.j_penyajiminum,
				j.j_penyajigorengan
         FROM
				sel_jual_hariini AS j
				INNER JOIN sel_orders_hariini AS o USING (o_kode)
         WHERE
				o_meja NOT IN ('', ' ') OR o_meja IS NULL
         ORDER BY j.j_kode DESC";

      $records  = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);
      $aliasMap = $this->getPenyajiAliasMap();

      foreach ($records as &$record) {
         [$notaStr]                  = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format']      = $notaStr;
         $nikMinuman                 = (string) $record['j_penyajiminum'];
         $nikGorengan                = (string) $record['j_penyajigorengan'];
         $nikMakanan                 = (string) $record['j_penyaji'];
         $record['penyaji_minuman']  = $aliasMap[$nikMinuman] ?? $nikMinuman;
         $record['penyaji_gorengan'] = $aliasMap[$nikGorengan] ?? $nikGorengan;
         $record['penyaji_makanan']  = $aliasMap[$nikMakanan] ?? $nikMakanan;

      }
      unset($record);

      return json_decode(json_encode($records), false);
   }

   public function indexAction() {
		$this->view->riwayat_nota = $this->getRiwayatNotaData();
   }

   public function riwayatAction() {
      $this->view->riwayat_nota = $this->getRiwayatNotaData();
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

      if (! $notaData) {
         $this->flashSession->error('Nota tidak ditemukan.');
         return $this->response->redirect('monitorminuman/riwayat');
      }

      [$notaStr]               = $this->formatNotaKode((int) $notaData['j_kode']);
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

      $this->view->data             = json_decode(json_encode($notaData), false);
      $this->view->data1            = json_decode(json_encode($transaksiData), false);
      $this->view->data2            = json_decode(json_encode($menuRingkas), false);
      $this->view->data3            = json_decode(json_encode($ikanData), false);
      $this->view->data4            = json_decode(json_encode($menuDetail), false);
      $this->view->penyaji          = $this->resolvePenyajiName($transaksiData['j_penyaji'] ?? '', $aliasMap);
      $this->view->penyaji_minum    = $this->resolvePenyajiName($transaksiData['j_penyajiminum'] ?? '', $aliasMap);
      $this->view->penyaji_gorengan = $this->resolvePenyajiName($transaksiData['j_penyajigorengan'] ?? '', $aliasMap);
   }
}