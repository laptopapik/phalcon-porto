<?php

class UserController extends \Phalcon\Mvc\Controller
{

    public function indexAction()
    {
    	$data_user = User::find();
    	$this->view->data_user = $data_user;
    }

    public function addUserAction()
    {
    	$user = new User();

    	if ($this->request->isPost()) {
			$username = $this->request->getPost('username');
			$password = $this->request->getPost('password');
			$type = $this->request->getPost('type');

		$user->assign(array(
		'username' => $username,
		'password' => $password,
		'type' => $type,
	));
		// $user->save();

		if ($user->save()) {
			$notif['title']= 'Sukses';
			$notif['text']= 'Data berhasil disimpan';
			$notif['title']= 'success';
		}
		else{
			$pesan_eror = $user->getMessages();
			$data_pesan_eror= '';
			foreach ($pesan_eror as $pesanError) {
				$data_pesan_eror="$pesanError";
			}

			$notif['title']= 'Error';
			$notif['text']= 'Data tidak berhasil disimpan';
			$notif['title']= 'error';

		}
		echo json_encode($notif);
		die();

		}

    }

}
// add this to addUser method
