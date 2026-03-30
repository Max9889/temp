<?php
require_once __DIR__ . '/../../config/config.php';

const SHANGHAI1_ID = '169647';
const SHANGHAI2_ID = '34648465';
const SHANGHAI3_ID = '5811201';

const LIVERPOOL1_ID = '13517907';
const LIVERPOOL2_ID = '13436004';
const LIVERPOOL3_ID = '13435824';

const CACHE_DIR = '../../data';


const FILE_LIFETIME_LIMIT = 15 * 60; // 15 seconds x 60 -> 15 minutes

$city = $_GET['city'];
$image_index = $_GET['index'];

$photoId = null;
switch ($city) {
    case 'shanghai':
        switch ($image_index) {
            case 1: $photoId = SHANGHAI1_ID; break;
            case 2: $photoId = SHANGHAI2_ID; break;
            case 3: $photoId = SHANGHAI3_ID; break;
            default: $photoId = SHANGHAI1_ID;
        }
        break;
    case 'liverpool':
        switch ($image_index) {
            case 1: $photoId = LIVERPOOL1_ID; break;
            case 2: $photoId = LIVERPOOL2_ID; break;
            case 3: $photoId = LIVERPOOL3_ID; break;
            default: $photoId = LIVERPOOL1_ID;
        }
        break;
    default: $photoId = SHANGHAI1_ID;
}

$cache_file_path = CACHE_DIR . '/pexel_cache' . $photoId . '.json';

$cache_json = null;
if (!file_exists($cache_file_path) || time() - filemtime($cache_file_path) > FILE_LIFETIME_LIMIT) {
// initialise curl to access secret weather api endpoint
    $curl = curl_init();
    $pexelUrl = $_ENV['PEXEL_API_URL'] . $photoId;
    $pexelKey = $_ENV['PEXEL_API_KEY']; // get the key from the .env file

    // set curl options URL
    curl_setopt($curl, CURLOPT_URL, $pexelUrl);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("Authorization: $pexelKey"));

    // store the result in the cache_json to be written and also to be sent back to js
    $cache_json = curl_exec($curl);
    curl_close($curl); // close curl operation

    $dir = dirname($cache_file_path);
    if (!is_dir($dir)) {
        // mkdir(path, permissions, recursive)
        mkdir($dir, 0777, true);
    }

    // write to the cache file
    $cache_file = fopen($cache_file_path, "c"); // open file in write mode without truncating immediately to allow flock
    flock($cache_file, LOCK_EX); // lock file so it cannot be overwritten during writing
    ftruncate($cache_file, 0); // truncate the file from the first line
    rewind($cache_file); // ensure file pointer is at the start - works on multiple systems
    fwrite($cache_file, $cache_json); // write the json into the file
    fflush($cache_file); // ensure data is written immediately to prevent file corruption from overwrite
    flock($cache_file, LOCK_UN);
    fclose($cache_file);
} else { // file is okay to be read from -> exists and isn't stale
    $cache_file = fopen($cache_file_path, 'r');
    flock($cache_file, LOCK_SH); // lock file so it cannot be overwritten while reading
    $cache_json = stream_get_contents($cache_file); // store the cache as json
    // unlock and close
    flock($cache_file, LOCK_UN);
    fclose($cache_file);
}

header('Content-Type: application/json');
echo $cache_json;
