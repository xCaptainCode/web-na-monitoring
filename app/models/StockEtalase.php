<?php

use Phalcon\Mvc\Model;

class StockEtalase extends Model {

   public $id_area;
   public $area_etalase;
   public $stock_piring;
   public $stock_gelas;

   public function initialize() {
      $this->setSchema('public');
      
      $this->setSource('stock_etalase');
   }
   
   public function getSource() {
      return 'stock_etalase';
   }
}