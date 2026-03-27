<?php
define('LEVEL', isset($_SESSION['bo_user_level']) ? $_SESSION['bo_user_level'] : null);
//echo($_SESSION['ujhdtr_user_name']);
//die();

// Load API routes
require __DIR__ . '/routes_api.php';

if (isset($_SESSION['bo_user_name'])) {
    // Logged in ...

	$router->add('/:controller',
		[
			'controller' => 1,
			'action'     => "index"
		]
	);

	$router->add('/:controller/:action/:params',
		[
			'controller' => 1,
			'action'     => 2,
			'params'     => 3,
		]
	);

} else {
    // Not logged in. Redirect or do something...
	$router->setDefaults(
		[
			"controller" => "login",
			"action"     => "index",
		]
	);	

	$router->add("/",
        [
            "controller" => "login",
            "action"     => "index",
        ]
    );
	
    $router->add("/login/proses",
        [
            "controller" => "login",
            "action"     => "proses",
        ]
    );
	
	$router->add("/login/forgot",
        [
            "controller" => "login",
            "action"     => "forgot",
        ]
    );	
}
return $router;

/* Redirect juga bisa dengan Dispatcher pada Controller 
https://www.tutorialspoint.com/phalcon/phalcon_security_features.htm

return $this->dispatcher->forward(array( 
    'controller' => 'posts', 
    'action' => 'index' 
)); 
*/
