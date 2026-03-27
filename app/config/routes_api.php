<?php
/**
 * Routing API khusus tanpa session web 
 * namun tetap menggunakan controller yang sama dengan web untuk memudahkan akses database dan logic bisnis yang sudah ada
 * autentikasi menggunakan JWT dengan secret key
 */

// ================= ROUTES NA SELF ORDER ================= //

$router->addPost('/api/login', [
    'controller' => 'apiselforder',
    'action'     => 'login'
]);

$router->addGet('/api/printer', [
    'controller' => 'apiselforder',
    'action'     => 'getPrinter'
]);

$router->addPost('/api/printer/test', [
    'controller' => 'apiselforder',
    'action'     => 'testPrint'
]);

$router->addGet('/api/menu/ideal', [
    'controller' => 'apiselforder',
    'action'     => 'menuIdeal'
]);

$router->addGet('/api/menu/daftar', [
    'controller' => 'apiselforder',
    'action'     => 'menuDaftar'
]);

$router->addGet('/api/menu/jenis-ikan', [
    'controller' => 'apiselforder',
    'action'     => 'jenisIkan'
]);

$router->addPost('/api/menu/stock-tandon', [
    'controller' => 'apiselforder',
    'action'     => 'stockTandon'
]);

$router->addPost('/api/menu/update-stock-menu', [
    'controller' => 'apiselforder',
    'action'     => 'updateStockMenu'
]);

$router->addPost('/api/menu/update-stock-ikan', [
    'controller' => 'apiselforder',
    'action'     => 'updateStockIkan'
]);

$router->addPost('/api/checkout', [
    'controller' => 'apiselforder',
    'action'     => 'checkout'
]);


// ================= ROUTES NA TICKETS ================= //

$router->addPost('/apitickets/login', [    
    'controller' => 'apitickets',
    'action'     => 'login'
]);

$router->addGet('/apitickets/printer', [
    'controller' => 'apitickets',
    'action'     => 'getPrinter'
]);

$router->addPost('/apitickets/printer/test', [
    'controller' => 'apitickets',
    'action'     => 'testPrint'
]);

$router->addGet('/apitickets/tiket-masuk', [
    'controller' => 'apitickets',
    'action'     => 'tiketMasuk'
]);

$router->addGet('/apitickets/tiket-wahana', [
    'controller' => 'apitickets',
    'action'     => 'tiketWahana'
]);

$router->addPost('/apitickets/checkout', [
    'controller' => 'apitickets',
    'action'     => 'checkout'
]);



// ================= ROUTES NA CASHIER ================= //

$router->addPost('/apicashier/login', [
   'controller' => 'apicashier',
   'action'     => 'login',
]);

$router->addGet('/apicashier/dashboard', [
   'controller' => 'apicashier',
   'action'     => 'dashboard',
]);

$router->addGet('/apicashier/get-format-nota', [
   'controller' => 'apicashier',
   'action'     => 'getFormatNota',
]);

$router->addPost('/apicashier/set-format-nota', [
   'controller' => 'apicashier',
   'action'     => 'setFormatNota',
]);

$router->addGet('/apicashier/get-ketetapan-member', [
   'controller' => 'apicashier',
   'action'     => 'getKetetapanMember',
]);

$router->addPost('/apicashier/set-ketetapan-member', [
   'controller' => 'apicashier',
   'action'     => 'setKetetapanMember',
]);

$router->addGet('/apicashier/get-list-printer', [
   'controller' => 'apicashier',
   'action'     => 'getListPrinter',
]);

$router->addGet('/apicashier/get-pos-printer', [
   'controller' => 'apicashier',
   'action'     => 'getPosPrinter',
]);

$router->addPost('/apicashier/set-pos-printer', [
   'controller' => 'apicashier',
   'action'     => 'setPosPrinter',
]);

$router->addPost('/apicashier/test-printer', [
   'controller' => 'apicashier',
   'action'     => 'testPrint',
]);

$router->addGet('/apicashier/get-daftar-nota', [
   'controller' => 'apicashier',
   'action'     => 'getDaftarNota',
]);

$router->addPost('/apicashier/get-detail-nota', [
   'controller' => 'apicashier',
   'action'     => 'getDetailNota',
]);

$router->addGet('/apicashier/daftar-member', [
   'controller' => 'apicashier',
   'action'     => 'daftarMember',
]);

$router->addPost('/apicashier/transaksi-restoran', [
   'controller' => 'apicashier',
   'action'     => 'transaksiResto',
]);