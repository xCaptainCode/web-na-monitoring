<?php

require_once __DIR__."/../vendor/autoload.php";

use Fahriztx\Zksoapphp\Src\Fingerprint;

// $machine = Fingerprint::connect('192.168.1.175', '80', '123456');
$machine = Fingerprint::connect('192.168.1.201', '4370', '0');
echo "Machine Status : ".$machine->getStatus().PHP_EOL;
// print_r($machine->getAttendance('all', '2022-05-24'));
print_r($machine->getAttendance('all'));
print_r($machine->getUserInfo());