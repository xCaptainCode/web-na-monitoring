<?php

use Phalcon\Db;
use Phalcon\Mvc\Controller;

class MonitoretalaseController extends Controller {

   public function indexAction() {

      $stocksQuery = 
         "SELECT
            se.id_area,
            se.area_etalase,
            COALESCE(tambah.stock_awal_piring, 0) AS stock_awal_piring,
            COALESCE(tambah.stock_awal_gelas, 0) AS stock_awal_gelas,
            COALESCE(kurang.terpakai_piring, 0) AS terpakai_piring,
            COALESCE(kurang.terpakai_gelas, 0) AS terpakai_gelas,
            COALESCE(se.stock_piring, 0) AS stock_sisa_piring,
            COALESCE(se.stock_gelas, 0) AS stock_sisa_gelas
         FROM stock_etalase se
         LEFT JOIN (
            SELECT
               id_area,
               SUM(qty_piring) AS stock_awal_piring,
               SUM(qty_gelas) AS stock_awal_gelas
            FROM tambah_stocketalase
            WHERE tgl_tambah = current_date
            GROUP BY id_area
         ) tambah ON tambah.id_area = se.id_area
         LEFT JOIN (
            SELECT
               id_area,
               SUM(qty_piring) AS terpakai_piring,
               SUM(qty_gelas) AS terpakai_gelas
            FROM kurang_stocketalase
            WHERE tgl_kurang = current_date
            GROUP BY id_area
         ) kurang ON kurang.id_area = se.id_area
         ORDER BY se.id_area
      ";

      $records = $this->dbNa->fetchAll($stocksQuery, Db::FETCH_ASSOC);

      $totals = array(
         'stock_awal_piring' => 0,
         'stock_awal_gelas' => 0,
         'terpakai_piring' => 0,
         'terpakai_gelas' => 0,
         'stock_sisa_piring' => 0,
         'stock_sisa_gelas' => 0,
      );

      foreach ($records as $stock) {
         $totals['stock_awal_piring'] += (int) $stock['stock_awal_piring'];
         $totals['stock_awal_gelas'] += (int) $stock['stock_awal_gelas'];
         $totals['terpakai_piring'] += (int) $stock['terpakai_piring'];
         $totals['terpakai_gelas'] += (int) $stock['terpakai_gelas'];
         $totals['stock_sisa_piring'] += (int) $stock['stock_sisa_piring'];
         $totals['stock_sisa_gelas'] += (int) $stock['stock_sisa_gelas'];
      }

      $stocks = json_decode(json_encode($records), false);
      
      $this->view->stocks = $stocks;
      $this->view->totals = $totals;
   }

   public function simpan_tambah_stockAction() {
      $this->view->disable();

      if (!$this->request->isPost()) {
         return $this->response->redirect('monitoretalase');
      }

      $idAreas = $this->request->getPost('id_area');
      $qtyPirings = $this->request->getPost('qty_piring');
      $qtyGelas = $this->request->getPost('qty_gelas');
      $pengantar = $this->session->get('bo_user_name');

      if (!is_array($idAreas) || !is_array($qtyPirings) || !is_array($qtyGelas) || empty($pengantar)) {
         $this->flashSession->error('Data stock peralatan tidak valid.');
         return $this->response->redirect('monitoretalase');
      }

      $sql = "INSERT INTO tambah_stocketalase (id_area, qty_piring, qty_gelas, pengantar) VALUES (:id_area, :qty_piring, :qty_gelas, :pengantar)";
      $insertedRows = 0;

      foreach ($idAreas as $index => $idArea) {
         $idArea = (int) $idArea;
         $qtyPiring = isset($qtyPirings[$index]) ? (int) $qtyPirings[$index] : 0;
         $qtyGel = isset($qtyGelas[$index]) ? (int) $qtyGelas[$index] : 0;

         if ($idArea <= 0) {
            continue;
         }

         if ($qtyPiring <= 0 && $qtyGel <= 0) {
            continue;
         }

         $this->dbNa->execute(
            $sql,
            array(
               'id_area' => $idArea,
               'qty_piring' => $qtyPiring,
               'qty_gelas' => $qtyGel,
               'pengantar' => $pengantar,
            )
         );

         $insertedRows++;
      }

      if ($insertedRows > 0) {
         $this->flashSession->success('Tambah stock peralatan berhasil disimpan.');
      } else {
         $this->flashSession->warning('Tidak ada data stock peralatan yang disimpan.');
      }

      return $this->response->redirect('monitoretalase');
   }

   public function reset_stockAction() {
      $this->view->disable();

      if (!$this->request->isPost()) {
         return $this->response->redirect('monitoretalase');
      }

      $sql = "UPDATE stock_etalase SET stock_piring = 0, stock_gelas = 0";
      $isUpdated = $this->dbNa->execute($sql);

      if ($isUpdated) {
         $this->flashSession->success('Stock peralatan berhasil direset.');
      } else {
         $this->flashSession->error('Reset stock peralatan gagal diproses.');
      }

      return $this->response->redirect('monitoretalase');
   }

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

   public function riwayatAction() {
      $sql = "SELECT
            j.j_kode,
            o.o_cnama,
            o.o_meja,
            k.qty_piring,
            k.qty_gelas,
            k.pengantar
         FROM kurang_stocketalase k
         INNER JOIN sel_orders_hariini o ON k.o_kode = o.o_kode
         INNER JOIN sel_jual_hariini j ON k.o_kode = j.o_kode
         WHERE k.tgl_kurang = current_date
         ORDER BY k.jam_kurang DESC";

      $records = $this->dbNa->fetchAll($sql, Db::FETCH_ASSOC);

      foreach ($records as &$record) {
         [$notaStr]             = $this->formatNotaKode((int) $record['j_kode']);
         $record['nota_format'] = $notaStr;
      }
      unset($record);

      $this->view->riwayat_nota = json_decode(json_encode($records), FALSE);
   }
}
