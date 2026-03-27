<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerDirs(
    [
        $config->application->controllersDir,
        $config->application->modelsDir,
		$config->application->libraryDir,
		$config->application->helperDir
    ]
)->register();

$loader->registerNamespaces([
    'Middleware' => APP_PATH . '/middleware/',
    'Fahriztx\Zksoapphp' => $config->application->libraryDir,
    'Mike42\Escpos' => $config->application->libraryDir,

])->register();
