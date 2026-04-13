<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\View;
use Phalcon\Db;

class MonitormakananController extends Controller {

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
				p.j_kode, 
				j_jam, 
				p.o_kode, 
				p.j_kode, 
				o_cnama, 
				o_meja, 
				rak, 
				substring(o_note, 1, 45) as catatan, 
				is_adaikan,
         CASE
            WHEN waktu_sesek IS NULL THEN '0'
            ELSE waktu_sesek - j_jam
         END AS sesek,
         CASE
            WHEN waktu_goreng IS NULL THEN '0'
            ELSE waktu_goreng - j_jam
         END AS goreng,
         CASE
            WHEN waktu_dapurkerja IS NULL THEN '0'
            ELSE waktu_dapurkerja - j_jam
         END AS bakar,
         to_char((current_time::time - j_jam), 'HH24:MI') as waktu_saji,
         FLOOR(EXTRACT(EPOCH FROM (current_timestamp - j_jam)) / 60) AS menit_saji
         FROM sel_orders_hariini 
				INNER JOIN sel_jual_hariini as p using (o_kode) 
				LEFT JOIN sel_dapurkerja_hariini using (j_kode)
         WHERE 
            j_jamsaji IS NULL
            AND j_jamdibungkus IS NULL
         ORDER BY j_kode";
      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);
      // Tambahkan nota_format ke setiap record
      foreach ($records as &$record) {
         [$notaStr]             = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;

         $detailMakanan = $this->dbNa->fetchAll(
            "SELECT
               od.o_kode,
               od.sel_mmenu_id,
               CASE
                  WHEN m.olahan IS NULL THEN m.nama
                  ELSE m.nama || ' ' || m.olahan
               END AS nama_olahan,
               od.od_qty,
               m.satuan
            FROM sel_ordersdetil_hariini AS od
            INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
            WHERE od.o_kode = :o_kode
               -- AND m.kategori = 'MAKANAN'
            ORDER BY od.sel_mmenu_id",
            Db::FETCH_ASSOC,
            [
               'o_kode' => $record['o_kode'],
            ]
         );

         $record['detail_makanan'] = $detailMakanan;
         $record['detail_makanan_json'] = json_encode($detailMakanan);
         $record['detail_makanan_base64'] = base64_encode($record['detail_makanan_json']);
      }
      unset($record); // Putus referensi foreach

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
            m.kategori = 'MAKANAN'
            AND o.o_jmlorg >= 0
            AND j.j_jamsaji IS NULL
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

	// ==========================================================================
   //  SCAN NOTA
   // ==========================================================================

   public function scan_notaAction() {

      $o_kode      = $this->request->getPost('o_kode');
      $j_penyaji   = $this->request->getPost('j_penyaji');

      try {
         $sql    = "UPDATE sel_jual_hariini set j_jamsaji = current_timestamp, j_penyaji = :j_penyaji where o_kode = :o_kode";
         $this->dbNa->execute($sql, [
            'o_kode' => $o_kode,
            'j_penyaji' => $j_penyaji
         ]);

         $this->flashSession->notice('Nota berhasil di scan');
         $this->response->redirect('dapursaji');
      } catch (\Throwable $th) {
         $this->flashSession->error('Nota gagal di scan. error: ' . $th->getMessage());
         $this->response->redirect('dapursaji');
      }
   
   }

	public function indexAction() {
		$this->assignViewData();
		
	}

	public function loadAction() {
      $this->assignViewData();
      $this->view->pick('monitormakanan/load');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

}
