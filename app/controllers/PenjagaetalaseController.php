<?php

use Phalcon\Db;
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\View;

class PenjagaetalaseController extends Controller {

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

   private function getAreaRedirectPath(int $idArea): string {
      switch ($idArea) {
      case 1:
         return 'penjagaetalase/pancing';
      case 2:
         return 'penjagaetalase/taman_dino';
      case 3:
         return 'penjagaetalase/aula_dino';
      case 4:
         return 'penjagaetalase/outbound';
      default:
         return 'penjagaetalase/pancing';
      }
   }

   private function getAreaConfig(int $idArea): array {
      $configs = [
         1 => [
            'id_area' => 1,
            'slug'    => 'pancing',
            'label'   => 'Pancing',
            'db_area' => 'AREA PANCING',
         ],
         2 => [
            'id_area' => 2,
            'slug'    => 'taman_dino',
            'label'   => 'Taman Dino',
            'db_area' => 'AREA TAMAN DINO',
         ],
         3 => [
            'id_area' => 3,
            'slug'    => 'aula_dino',
            'label'   => 'Aula Dino',
            'db_area' => 'AREA AULA DINO',
         ],
         4 => [
            'id_area' => 4,
            'slug'    => 'outbound',
            'label'   => 'Outbound',
            'db_area' => 'AREA OUTBOUND',
         ],
      ];

      return $configs[$idArea] ?? $configs[1];
   }

   private function getAreaData(int $idArea): array {
      $config = $this->getAreaConfig($idArea);
      $dbArea = $config['db_area'];

      $sql =
         "SELECT
            j_kode,
            o_kode,
            o_cnama,
            area,
            :id_area AS id_area,
            o.o_jmlorg,
            to_char(j.j_jam, 'HH24:MI') AS j_jam,
            to_char((j_jamdptmeja - j.j_jam), 'HH24:MI:SS') AS tunggu,
            j_pengantar,
            o.o_meja
         FROM
            sel_jual_hariini AS j
            INNER JOIN monitor_area_hariini USING (o_kode)
            INNER JOIN sel_orders_hariini AS o USING (o_kode)
            LEFT JOIN kurang_stocketalase USING (o_kode)
         WHERE
            j_jamdptmeja IS NOT NULL
            AND o.o_jmlorg >= 1
            AND jam_kurang IS NULL
            AND area = :db_area
            AND (SELECT COUNT(*) FROM kurang_stocketalase WHERE o_kode = j.o_kode) = 0
         ORDER BY j.j_jam;";
      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC, [
         'id_area' => $idArea,
         'db_area' => $dbArea,
      ]);

      $qtyMap  = [];
      $qtyRows = $this->dbNa->fetchAll(
         "SELECT
            od.o_kode,
            MAX(CASE WHEN m.is_sajiprg = 't' THEN 1 ELSE 0 END) AS ada_prg,
            MAX(CASE WHEN m.is_sajigls = 't' THEN 1 ELSE 0 END) AS ada_gls,
            MAX(CASE WHEN m.satuan = 'TKO' THEN 1 ELSE 0 END) AS ada_teko,
            COALESCE(SUM(od.od_qty * COALESCE(m.min_prg, 0)), 0) AS ttl_min_prg,
            COALESCE(SUM(od.od_qty * COALESCE(m.min_gls, 0)), 0) AS ttl_min_gls
         FROM sel_ordersdetil_hariini AS od
         INNER JOIN sel_mmenu AS m USING (sel_mmenu_id)
         GROUP BY od.o_kode
      ", Db::FETCH_ASSOC);

      foreach ($qtyRows as $qtyRow) {
         $qtyMap[$qtyRow['o_kode']] = $qtyRow;
      }

      foreach ($records as &$record) {
         [$notaStr]             = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;

         $oKode   = $record['o_kode'];
         $jmlorg  = (int) $record['o_jmlorg'];
         $qtyData = $qtyMap[$oKode] ?? [
            'ada_prg'     => 0,
            'ada_gls'     => 0,
            'ada_teko'    => 0,
            'ttl_min_prg' => 0,
            'ttl_min_gls' => 0,
         ];

         $adaPrg  = (int) $qtyData['ada_prg'] === 1;
         $adaGls  = (int) $qtyData['ada_gls'] === 1;
         $adaTeko = (int) $qtyData['ada_teko'] >= 1;
         $minPrg  = (int) $qtyData['ttl_min_prg'];
         $minGls  = (int) $qtyData['ttl_min_gls'];

         $qtyPrg = $adaPrg ? max(0, $jmlorg - $minPrg) : 0;
         $qtyGls = 0;

         if ($adaGls) {
            $qtyGls = $adaTeko ? $jmlorg : max(0, $jmlorg - $minGls);
         }

         $record['qty_prg']    = $qtyPrg;
         $record['qty_piring'] = $qtyPrg;
         $record['qty_gls']    = $qtyGls;
      }
      unset($record);

      return json_decode(json_encode($records), FALSE);
   }

   private function assignAreaViewData(int $idArea): void {
      $config = $this->getAreaConfig($idArea);

      $this->view->daftar_nota  = $this->getAreaData($idArea);
      $this->view->penjaga_area = json_decode(json_encode($this->db->fetchAll(
         "SELECT pe.penjaga AS penjaga_id, pt.nama_alias
          FROM penjaga_etalase pe
          INNER JOIN pt_mparttimer pt ON pe.penjaga = pt.pt_mparttimer_id
          WHERE pe.tanggal = current_date AND pe.id_area = :id_area
          ORDER BY pt.nama_alias",
         Db::FETCH_ASSOC,
         ['id_area' => $idArea]
      )), FALSE);
      $this->view->area_id    = $config['id_area'];
      $this->view->area_slug  = $config['slug'];
      $this->view->area_label = $config['label'];
   }
   // =========================== END OF PRIVATE METHODS =======================

   public function penjagaAction() {
      $penjagaEtalase = $this->db->fetchAll(
         "SELECT
               pe.id,
               pe.tanggal,
               pe.id_area,
               ae.area_etalase,
               pe.penjaga,
               pt.nama_alias
            FROM penjaga_etalase pe
               INNER JOIN pt_mparttimer pt ON pe.penjaga = pt.pt_mparttimer_id
               INNER JOIN stock_etalase ae ON pe.id_area = ae.id_area
            WHERE tanggal = current_date
            ORDER BY id_area"
         , Db::FETCH_ASSOC);
      $this->view->penjaga_etalase = json_decode(json_encode($penjagaEtalase), FALSE);

      // daftar parttimer Gudang Peralatan untuk dropdown
      $parttimerGBR = $this->db->fetchAll(
         "SELECT pt_mparttimer_id, nama_alias
          FROM pt_vpresence
          WHERE pt_mpk_no = 10 AND tanggal = '2026-01-01'
          ORDER BY nama_alias",
         Db::FETCH_ASSOC
      );
      $this->view->parttimer_gudang_peralatan = json_decode(json_encode($parttimerGBR), FALSE);

      $areaEtalase = $this->db->fetchAll(
         "SELECT DISTINCT id_area, area_etalase
          FROM stock_etalase
          WHERE id_area != 1
          ORDER BY id_area",
         Db::FETCH_ASSOC
      );
      $this->view->area_etalase = json_decode(json_encode($areaEtalase), FALSE);

   }

   public function tambah_penjagaAction() {
      $this->view->disable();

      if (! $this->request->isPost()) {
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $penjaga = (int) $this->request->getPost('penjaga', 'int');
      $idArea  = (int) $this->request->getPost('id_area', 'int');

      if ($penjaga <= 0 || $idArea <= 0) {
         $this->flashSession->error('Data penjaga etalase tidak valid.');
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $sql     = "INSERT INTO penjaga_etalase (penjaga, id_area) VALUES (:penjaga, :id_area)";
      $isSaved = $this->db->execute(
         $sql,
         [
            'penjaga' => $penjaga,
            'id_area' => $idArea,
         ]
      );

      if ($isSaved) {
         $this->flashSession->success('Penjaga etalase berhasil ditambahkan.');
      } else {
         $this->flashSession->error('Penjaga etalase gagal ditambahkan.');
      }

      return $this->response->redirect('penjagaetalase/penjaga');
   }

   public function edit_penjagaAction() {
      $this->view->disable();

      if (! $this->request->isPost()) {
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $id      = (int) $this->request->getPost('id', 'int');
      $penjaga = (int) $this->request->getPost('penjaga', 'int');
      $idArea  = (int) $this->request->getPost('id_area', 'int');

      if ($id <= 0 || $penjaga <= 0 || $idArea <= 0) {
         $this->flashSession->error('Data edit penjaga etalase tidak valid.');
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $record = $this->db->fetchOne(
         "SELECT id
          FROM penjaga_etalase
          WHERE id = :id AND tanggal = current_date
          LIMIT 1",
         Db::FETCH_ASSOC,
         ['id' => $id]
      );

      if (! $record) {
         $this->flashSession->warning('Data penjaga etalase tidak ditemukan untuk hari ini.');
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $duplicate = $this->db->fetchOne(
         "SELECT id
          FROM penjaga_etalase
          WHERE tanggal = current_date
            AND id_area = :id_area
            AND id <> :id
          LIMIT 1",
         Db::FETCH_ASSOC,
         [
            'id_area' => $idArea,
            'id'      => $id,
         ]
      );

      if ($duplicate) {
         $this->flashSession->warning('Area etalase tersebut sudah dipakai data lain hari ini.');
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $isUpdated = $this->db->execute(
         "UPDATE penjaga_etalase
          SET penjaga = :penjaga, id_area = :id_area, updated_at = CURRENT_TIMESTAMP
          WHERE id = :id AND tanggal = current_date",
         [
            'penjaga' => $penjaga,
            'id_area' => $idArea,
            'id'      => $id,
         ]
      );

      if ($isUpdated) {
         $this->flashSession->success('Data penjaga etalase berhasil diperbarui.');
      } else {
         $this->flashSession->error('Data penjaga etalase gagal diperbarui.');
      }

      return $this->response->redirect('penjagaetalase/penjaga');
   }

   public function hapus_penjagaAction() {
      $this->view->disable();

      if (! $this->request->isPost()) {
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $id = (int) $this->request->getPost('id', 'int');

      if ($id <= 0) {
         $this->flashSession->error('Data penjaga etalase tidak valid.');
         return $this->response->redirect('penjagaetalase/penjaga');
      }

      $isDeleted = $this->db->execute(
         "DELETE FROM penjaga_etalase
          WHERE id = :id AND tanggal = current_date",
         ['id' => $id]
      );

      if ($isDeleted) {
         $this->flashSession->success('Data penjaga etalase berhasil dihapus.');
      } else {
         $this->flashSession->error('Data penjaga etalase gagal dihapus.');
      }

      return $this->response->redirect('penjagaetalase/penjaga');
   }

   public function pancingAction() {
      $this->assignAreaViewData(1);
   }

   public function load_pancingAction() {
      $this->assignAreaViewData(1);
      $this->view->pick('penjagaetalase/pancingLoad');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

   public function taman_dinoAction() {
      $this->assignAreaViewData(2);
   }

   public function load_taman_dinoAction() {
      $this->assignAreaViewData(2);
      $this->view->pick('penjagaetalase/tamanDinoLoad');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

   public function aula_dinoAction() {
      $this->assignAreaViewData(3);
   }

   public function load_aula_dinoAction() {
      $this->assignAreaViewData(3);
      $this->view->pick('penjagaetalase/aulaDinoLoad');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

   public function outboundAction() {
      $this->assignAreaViewData(4);
   }

   public function load_outboundAction() {
      $this->assignAreaViewData(4);
      $this->view->pick('penjagaetalase/outboundLoad');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
   }

   public function scan_notaAction() {
      $this->view->disable();

      if (! $this->request->isPost()) {
         return $this->response->redirect('penjagaetalase/pancing');
      }

      $idArea      = (int) $this->request->getPost('id_area', 'int');
      $qtyPiring   = (int) $this->request->getPost('qty_piring', 'int');
      $qtyGelas    = (int) $this->request->getPost('qty_gelas', 'int');
      $oKode       = trim((string) $this->request->getPost('o_kode', 'string'));
      $pengantarId = (int) $this->request->getPost('pengantar', 'int');

      $redirectPath = $this->getAreaRedirectPath($idArea);

      if ($idArea <= 0 || $oKode === '') {
         $this->flashSession->error('Data nota tidak valid.');
         return $this->response->redirect($redirectPath);
      }

      if ($qtyPiring <= 0 && $qtyGelas <= 0) {
         $this->flashSession->warning('Tidak ada peralatan yang perlu disimpan.');
         return $this->response->redirect($redirectPath);
      }

      if ($pengantarId <= 0) {
         $this->flashSession->error('Pengantar belum dipilih.');
         return $this->response->redirect($redirectPath);
      }

      $pengantarRow = $this->db->fetchOne(
         "SELECT pt.nama_alias
          FROM penjaga_etalase pe
          INNER JOIN pt_mparttimer pt ON pe.penjaga = pt.pt_mparttimer_id
          WHERE pe.tanggal = current_date
            AND pe.id_area = :id_area
            AND pe.penjaga = :penjaga
          LIMIT 1",
         Db::FETCH_ASSOC,
         [
            'id_area' => $idArea,
            'penjaga' => $pengantarId,
         ]
      );

      if (! $pengantarRow) {
         $this->flashSession->error('Pengantar tidak sesuai dengan penjaga area ini.');
         return $this->response->redirect($redirectPath);
      }

      $pengantar = (string) $pengantarRow['nama_alias'];

      $sql = "INSERT INTO kurang_stocketalase (id_area, qty_piring, qty_gelas, o_kode, pengantar)
         VALUES (:id_area, :qty_piring, :qty_gelas, :o_kode, :pengantar)";

      $success = $this->dbNa->execute(
         $sql, [
            'id_area'    => $idArea,
            'qty_piring' => $qtyPiring,
            'qty_gelas'  => $qtyGelas,
            'o_kode'     => $oKode,
            'pengantar'  => $pengantar,
         ]
      );

      if ($success) {
         $this->flashSession->success('Data peralatan antar berhasil disimpan.');
      } else {
         $this->flashSession->error('Data peralatan antar gagal disimpan.');
      }

      return $this->response->redirect($redirectPath);
   }

}
