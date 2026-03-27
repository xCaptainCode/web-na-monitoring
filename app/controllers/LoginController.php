<?php

use Phalcon\Mvc\View;

class LoginController extends \Phalcon\Mvc\Controller {

	public function indexAction() {
		$this->view->pick("login/index");
		$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

	}

	public function prosesAction() {
		//$this->view->disable();
		
		if ($this->request->isPost()) {
			$username = $this->request->getPost("txtusername");
			$password = $this->request->getPost("txtpassword");
			
			$user = BoUsersList::findFirst([
				"conditions" => "username = :username: AND password = :password: AND is_aktif = true",
				"bind" => [
					"username" => $username,
					"password" => md5($password)
				]
			]); 

			if ($user === false) {
				return $this->response->redirect('');
			} else {
				$this->session->set('bo_user_id', $user->user_id);
				$this->session->set('bo_user_namalengkap', $user->nama);
				$this->session->set('bo_user_jab_id', $user->jab_id);
				$this->session->set('bo_user_jabatan', $user->jabatan);
				$this->session->set('bo_user_dept_id', $user->dept_id);
				$this->session->set('bo_user_department', $user->department);
				$this->session->set('bo_user_parent', $user->parent);
				$this->session->set('bo_user_name', $user->username);
				$this->session->set('bo_user_level', $user->user_level);
				$this->session->set('bo_user_photo', $user->user_id.".png");
				return $this->response->redirect('');
			} 
		}
	}	

	// ini adalah komentar
	
	public function logoutAction() {
		$this->view->disable();
		$this->session->destroy();
		$this->response->redirect('');
	}
	
	public function forgotAction() {
      $this->view->pick("login/forgot");
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);		
	}
}