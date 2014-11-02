<?php 
	include 'global.php';
	if (isset($_GET['uid']) && isset($_GET['key'])) {
		$key = preg_replace('/[^A-Za-z0-9]/','',$_GET['key']);
		$uid = preg_replace('/[^0-9]/','',$_GET['uid']);
		if ((!empty($key)) && (!empty($uid))) {
			if (VerifyUser($uid, $key)) 
				echo '1';
			else 
				echo '0';
		} else {
			echo "Invalid parameters!";
		}
	} else {
		echo "Invalid parameters!";
	}

