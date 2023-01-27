<?php
	header("Content-Type: text/x-shellscript");
	header("Content-Disposition: attachment; filename=\"shup.sh\"");

	$scripts_available = [];
	foreach(scandir('./scripts') as $filename) {
		if (!is_dir('./scripts/' . $filename)) {
			array_push($scripts_available, substr($filename, 0, -3));
		}
	}
	$scripts_to_run = [];
	$abort = false;

	foreach($_GET as $key => $val) {
		if (!in_array($key, $scripts_available)) {
			echo 'echo "Unexpected script ' . $key . ' passed. Available scripts are ' . implode(', ', $scripts_available) . '."';
			echo "\r\n";
			$abort = true;
			break;
		}
		
		if (in_array($key, $scripts_to_run)) {
			echo 'echo "Script ' . $key . ' passed more than once, aborting."';
			echo "\r\n";
			$abort = true;
			break;
		}

		if ($key == 'pubkeys') {
			if (empty($val)) {
				echo 'echo "pubkeys script requires a GitHub username to be passed."';
				echo "\r\n";
				$abort = true;
				break;
			}
			echo 'GH_USER=' . $val;
		}

		array_push($scripts_to_run, $key);
		echo '$scripts_to_run';
	}

	if ($abort) {
		echo 'echo "No action taken."';
		echo "\r\n";
	} else if (count($scripts_to_run) == 0) {
		echo 'echo "No scripts passed! Available scripts are ' . implode(', ', $scripts_available) . '."';
		echo "\r\n";
	} else {

		foreach($scripts_to_run as $script) {
			echo file_get_contents('./scripts/' . $scripts_to_run . '.sh');
			echo "\r\n";
		}
	}
?>
