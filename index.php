<?php
	// If typing 'curl -L example.com/shup/shup.sh | bash' is too long
	// This lets you just do 'curl -L example.com/shup | bash'. Happy?

	header("Content-Type: text/x-shellscript");
	echo file_get_contents('shup.sh');
?>