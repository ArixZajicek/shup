<?php

	header("Content-Type: text/x-shellscript");
	header("Content-Disposition: attachment; filename=\"shup.sh\"");

	function msg($message = '') {
		echo "echo '" . $message . "'\n";
	}

	$scripts_available = $scripts_to_run = [];
	// Find possible scripts
	foreach(scandir('./scripts') as $filename) {
		if (!is_dir('./scripts/' . $filename) && substr($filename, -3) === '.sh') {
			array_push($scripts_available, substr($filename, 0, -3));
		}
	}

	
	if (isset($_GET['list'])) {
		// Just listing the scripts available
		msg('Available scripts are ' . implode(', ', $scripts_available) . '.');

	} else if (isset($_GET['run'])) {
		// Explicitly define running scripts
		foreach(explode(',', $_GET['run']) as $script) {
			// Make sure script is valid
			if (!in_array($script, $scripts_available)) {
				msg('Unexpected script ' . $script . ' passed, aborting. Available scripts are ' . implode(', ', $scripts_available) . '.');
				exit();
			}

			// Make sure no duplicates
			if (in_array($script, $scripts_to_run)) {
				msg('Script ' . $script . ' passed more than once, aborting.');
				exit();
			}

			// Make sure github username is provided for keys script
			if ($script == 'keys') {
				if (empty($_GET['gh'])) {
					msg('keys script requires a GitHub username to be passed."');
					exit();
				} else {
					echo 'GH_USER=' . $_GET['gh'];
				}
			}

			// Push to array
			array_push($scripts_to_run, $script);
		}

	} else {
		// Run all scripts
		foreach($scripts_available as $script) {
			if ($script == 'keys') {
				if (!empty($_GET['gh'])) {
					echo 'GH_USER=' . $_GET['gh'];
					array_push($scripts_to_run, $script);
				}
			} else {
				array_push($scripts_to_run, $script);
			}
		}
	}

	if (count($scripts_to_run) == 0) {
		msg('No scripts passed! Available scripts are ' . implode(', ', $scripts_available) . '."');
	} else {
		foreach($scripts_to_run as $script) {
			echo("#### Start of ' . $script . '.sh\n");
			echo file_get_contents('./scripts/' . $script . '.sh');
			echo("\n\n");
		}
	}
?>
