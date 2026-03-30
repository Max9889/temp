<?php
require_once '../../config/config.php'; // provides env superglobals and error handling

// define cities for weather data
const CITY_LIVERPOOL = 'liverpool';
const CITY_SHANGHAI = 'shanghai';

// define return types for weather data
const TYPE_CURRENT = 'current';
const TYPE_FORECAST = 'forecast';

// define consts for cache file
const LIVERPOOL_CACHE_FILE_PATH = '../../data/liverpool_weather_cache.json';
const SHANGHAI_CACHE_FILE_PATH = '../../data/shanghai_weather_cache.json';
const FILE_LIFETIME_LIMIT = 15 * 60; // 15 seconds x 60 -> 15 minutes 

// get the city cache file path, city and return type from the query parameters
$city = $_GET['city'] ?? CITY_SHANGHAI; // default to shanghai
$return_type = $_GET['return_type'] ?? TYPE_CURRENT; // default to current weather data
$cache_file_path = match($city) {
    CITY_LIVERPOOL => LIVERPOOL_CACHE_FILE_PATH,
    CITY_SHANGHAI => SHANGHAI_CACHE_FILE_PATH,
    default => SHANGHAI_CACHE_FILE_PATH,
};

// get appropriate key, give a default if entered incorrectly
// include shanghai in this check despite redundancy to promote scalability with more cities
$city_key = match($city) {
    CITY_LIVERPOOL => 'LIVERPOOL_WEATHER_API',
    CITY_SHANGHAI => 'SHANGHAI_WEATHER_API',
    default => 'SHANGHAI_WEATHER_API',
};

// check if file is stale or doesnt exist
// file not exists is edge case for server startup
$cache_json = null;
if (!file_exists($cache_file_path) || time() - filemtime($cache_file_path) > FILE_LIFETIME_LIMIT) {
// initialise curl to access secret weather api endpoint
    $curl = curl_init();
    $city_URL = $_ENV[$city_key]; // get the city URL from superglobals

    // set curl options URL
    curl_setopt($curl, CURLOPT_URL, $city_URL);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

    // store the result in the cache_json to be written and also to be sent back to js
    $cache_json = json_decode(curl_exec($curl));
    curl_close($curl); // close curl operation

    // allow write permissions to xampp for directories
    $dir = dirname($cache_file_path);
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }   

    // write to the cache file
    $cache_file = fopen($cache_file_path, "c"); // open file in write mode without truncating immediately to allow flock
    flock($cache_file, LOCK_EX); // lock file so it cannot be overwritten during writing
    ftruncate($cache_file, 0); // truncate the file from the first line
    rewind($cache_file); // ensure file pointer is at the start - works on multiple systems
    fwrite($cache_file, json_encode($cache_json)); // write the json into the file
    fflush($cache_file); // ensure data is written immediately to prevent file corruption from overwrite
    flock($cache_file, LOCK_UN);
    fclose($cache_file);
} else { // file is okay to be read from -> exists and isn't stale
    $cache_file = fopen($cache_file_path, 'r'); 
    flock($cache_file, LOCK_SH); // lock file so it cannot be overwritten while reading
    $cache_json = json_decode(stream_get_contents($cache_file)); // store the cache as json
    // unlock and close
    flock($cache_file, LOCK_UN);
    fclose($cache_file);
}

// return the data as a JSON
header('Content-Type: application/json; charset=utf-8');
$output = match($return_type) {
    // choose current or daily forecast depending on return type query parameter
    // include forecast in this check despite redundancy to promote scalability with more return types
    TYPE_CURRENT => $cache_json->current,
    TYPE_FORECAST => $cache_json->daily,
    default => $cache_json->current,
};

echo json_encode($output);

?>
