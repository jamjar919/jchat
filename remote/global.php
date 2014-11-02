<?php
	
	function logError($error) {
		$file = "errorlog.txt";
		$handle = fopen($file, 'a');
		fwrite($handle, $error);
		fclose($handle);
	}

	function VerifyUser($uid, $secretKey) {
		try {
			$db = new PDO('mysql:host=localhost;dbname=DB_DBNAME;charset=utf8', 'DB_USERNAME', 'DB_PASSWORD');
			$stmt = $db->prepare('SELECT SecretKey FROM jusers WHERE UserID=:uid');
			$stmt->bindValue(':uid',$uid, PDO::PARAM_STR);
			$stmt->execute();
			$rows = $stmt->fetch(PDO::FETCH_ASSOC);
			if ($rows['SecretKey'] == $secretKey) 
				return True;
			else 
				return false;
		} catch(PDOException $ex) {
			echo "Database error!";
			logError($ex->getMessage());
		}
	}
?>