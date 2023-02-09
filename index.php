<?php

	header("Content-Type: text/x-shellscript");
	if (!isset($_GET['view'])) {
		header("Content-Disposition: attachment; filename=\"shup.sh\"");
	}

	echo "#!/bin/bash\n";

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
		exit;

	} else if (isset($_GET['run'])) {
		// Explicitly define running scripts
		foreach(explode(',', $_GET['run']) as $script) {
			// Make sure script is valid
			if (!in_array($script, $scripts_available)) {
				msg('Unexpected script ' . $script . ' passed, aborting. Available scripts are ' . implode(', ', $scripts_available) . '.');
				exit;
			}

			// Make sure no duplicates
			if (in_array($script, $scripts_to_run)) {
				msg('Script ' . $script . ' passed more than once, aborting.');
				exit;
			}

			// Push to array
			array_push($scripts_to_run, $script);
		}

	} else {
		// Run all scripts
		foreach($scripts_available as $script) {
			array_push($scripts_to_run, $script);
		}
	}

	// Environment variables, if applicable.
	echo "################################################################################\n";
	echo "##                        ENVIRONMENT VARIABLES                               ##\n";
	echo "################################################################################\n";

	if (!empty($_GET['gh'])) {
		echo "GH_USER=" . $_GET['gh'] . "\n\n";
	}

	if (in_array('kcron', $scripts_to_run)) {
		echo "GH_KEY_SCRIPT_CONTENT=\"" . str_replace('"', '\"', file_get_contents('./scripts/keys.sh')) . "\"\n";
	}

	if (count($scripts_to_run) == 0) {
		msg('No scripts passed! Available scripts are ' . implode(', ', $scripts_available) . '."');
	} else {
		foreach($scripts_to_run as $script) {
			echo file_get_contents('./scripts/' . $script . '.sh') . "\n";
		}
	}
?>
