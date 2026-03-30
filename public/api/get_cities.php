<?php
require_once '../../config/config.php'; // provides global error handler
require_once '../../db/db_get.php'; // provides get_cities_json()

$cities_json = get_cities_json();

// output as json
header('Content-Type: application/json; charset=utf-8');
echo json_encode($cities_json);

?>
