<?php
	header("Content-Type: text/x-shellscript");

	$scripts_available = array_map(fn($filename): string => substr($filename, 0, -3), scandir('./scripts'));
	$scripts_to_run = [];
	$abort = false;

	foreach($_GET as $key => $val) {
		if (!in_array($param, $scripts_available)) {
			echo 'echo "Unexpected script ' . $key . ' passed. Available scripts are ' . implode(', ', $scripts_available) . '."';
			$abort = true;
			break;
		}
		
		if (in_array($param, $scripts_to_run)) {
			echo 'echo "Script ' . $key . ' passed more than once, aborting."';
			$abort = true;
			break;
		}

		if ($key == 'pubkeys') {
			if (empty($val)) {
				echo 'echo "pubkeys script requires a GitHub username to be passed."';
				$abort = true;
				break;
			}
			echo 'GH_USER=' . $val;
		}

		array_push($scripts_to_run, $get);
	}

	if ($abort) {
		echo 'echo "No action taken."';
	} else if (count($scripts_to_run) == 0) {
		echo 'echo "No scripts passed! Available scripts are ' . implode(', ', $scripts_available) . '."';
	} else {

		foreach($scripts_to_run as $script) {
			echo file_get_contents('./scripts/' . $scripts_to_run . '.sh');
		}
	}
?>
