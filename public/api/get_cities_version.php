<?php
require_once '../../config/config.php'; // provides env superglobals and error handling

header("Content-type: text/plain; charset=utf-8");
echo $_ENV["DB_VERSION"];
?>
