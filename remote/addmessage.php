<?php 
	include 'global.php';
	if (isset($_GET['uid']) && isset($_GET['key']) && isset($_GET['message']) && isset($_GET['rid'])) {
		$message = preg_replace('/[^A-Za-z0-9\.\!\?\(\)\ \£\$\@\#]/','',$_GET['message']);
		$key = preg_replace('/[^A-Za-z0-9]/','',$_GET['key']);
		$uid = preg_replace('/[^0-9]/','',$_GET['uid']);
		$rid = preg_replace('/[^0-9]/','',$_GET['rid']);
		if (!empty($uid) && !empty($rid) && !empty($key) && !empty($message)) {
			//check if the user is valid
			if (VerifyUser($uid,$key)) {
				//check file exists
				$file = 'logs/'.$uid.'-'.$rid.'.txt';
				$fileo = 'logs/'.$rid.'-'.$uid.'.txt';
				if (file_exists($file)) {
					//parse message data (original creator so foo)
					$message = "Foo: ".$message.'~';
					//append to file
					$handle = fopen($file, 'a');
					fwrite($handle, $message);
					fclose($handle);
					echo "1";
				} else if (file_exists($fileo)) {
					//parse message data (recipient so bar)
					$message = "Bar: ".$message.'~';
					//append to file
					$handle = fopen($file, 'a');
					fwrite($handle, $message);
					fclose($handle);
					echo "1";
				} else {
					echo "Chat not created yet.";
				}
			} else {
				echo "Invalid credentials, please recheck.";
			}
		} else {
			echo "Invalid parameters!";
		}
	} else {
		echo "Invalid parameters!";
	}