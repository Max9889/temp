<?php
require_once '../../config/config.php'; // provides global error handler
require_once '../../db/db_get.php'; // provides get_cities_json()

$website_link = "localhost/index.html"; // the link to the source of truth for all information
$cities_json = get_cities_json(); // get the cities data

$cities_array = [$cities_json["Liverpool"], $cities_json["Shanghai"]];

// fill news array and mark as shared or not
$news_array = [];
foreach ($cities_array as $city) {
    foreach($city->news as $news) {
        $id = $news->news_id;

        // check if first time seeing this news id
        if (!isset($news_array[$id])) {
            // if so, add to the array and give it the city name
            $news->city = $city->city_name;
            $news_array[$id] = $news; 
        } else {
            // if not, update the city name to shared
            $news_array[$id]->city = "Liverpool-Shanghai";
        }
    }
}

// rss items and channel share the same link, as it is an SPA
$site_domain = "https://localhost/index.html";

function get_city_description($city) {
    return "{$city->city_name} - a city in {$city->country} | " .
           "Timezone: {$city->timezone} | " . 
           "Population: {$city->population} | " . 
           "Latitude: {$city->lat} | " . 
           "Longitude: {$city->lng} | " .
           "Mayor: {$city->mayor_name} | " .
           "GDP: {$city->GDP} {$city->currency} (local currency) | " .
           "Total Area: {$city->area}km²";
}

function get_news_description($news) {
    $output = "Author: {$news->author} | " . 
              "Source: {$news->source} | " . 
              "Summary: {$news->description} | " . 
              "Image: {$news->image_url}";

    return str_replace(['’', '‘', '“', '”'], ["'", "'", '"', '"'], $output); // some articles may use erroneous characters
}

function get_district_description($district, $city) {
    return "{$district->district_name} - a district in {$city->city_name} | " .
           "{$district->description} | " .
           "Population: {$district->population} | " .
           "Latitude: {$district->lat} | " . 
           "Longitude: {$district->lng} | " .
           "Total Area: {$district->area}km²";
}

function get_poi_description($poi, $city, $site_domain) {
    $image_filename = $site_domain . "/assets/img/poi/" . $poi->image_filename;
    return "{$poi->POI_name} - a place of interest in {$city->city_name} | " .
           "{$poi->description} | " .
           "Established: {$poi->date_established} | " .
           "Accessibility Rating: {$poi->accessibility_rating}/10 | " .
           "Entry Fee: {$poi->entry_fee} {$city->currency} | " .
           "Visitor Capacity: {$poi->visitor_capacity} | " .
           "Image File: {$image_filename} | " .
           "Image Caption: {$poi->image_caption} | " .
           "Latitude: {$poi->lat} | " . 
           "Longitude: {$poi->lng} | " .
           "Total Area: {$poi->area}km²";
}

function get_station_description($station, $city) {
    $toilets_available = ($station->toilets_available) ? "Yes" : "No";
    return "{$station->station_name} - a transport station in {$city->city_name} | " .
           "{$station->description} | " .
           "Accessibility Rating: {$station->accessibility_rating}/10 | " .
           "Toilets Available?: {$toilets_available} | " .
           "Station Type: {$station->station_type} | " .
           "Latitude: {$station->lat} | " . 
           "Longitude: {$station->lng}";
}

function get_service_description($service, $city) {
    return "{$service->service_name} - a public service in {$city->city_name} | " .
           "{$service->description} | " .
           "Service Type: {$service->service_type} | " .
           "Latitude: {$service->lat} | " . 
           "Longitude: {$service->lng}";
}

header('Content-Type: application/rss+xml; charset=utf-8');
echo '<?xml version="1.0" encoding="UTF-8"?>';

// note that any php value passed directly into the xml is wrapped in htmlspecialchars()
// to avoid potentially passing character codes that can crash an rss feed reader
?>

<rss version="2.0">
    <channel>
        <title>Twin Cities Infohub</title>
        <link><?= htmlspecialchars($site_domain) ?></link>

        <description>Your source for info on the twin cities Liverpool and Shanghai!</description>

        <language>en-gb</language>
        <lastBuildDate><?= htmlspecialchars(date(DATE_RSS)) ?></lastBuildDate>

        <category>Liverpool-Shanghai Data</category>
        <category>University Assignment</category>

<?php foreach($news_array as $news): // NEWS LAYER ?>
        <item>
            <title><?= htmlspecialchars($news->city) ?> News: <?= htmlspecialchars($news->title) ?></title>
            <link><?= htmlspecialchars($news->news_url) ?></link>

            <description><?= str_replace("&amp;", "&amp;amp;", htmlspecialchars(get_news_description($news))) ?></description>

            <category>News</category>
            <category><?= htmlspecialchars($news->city) ?></category>

            <pubDate><?= htmlspecialchars(date(DATE_RSS, strtotime($news->date_published))) ?></pubDate>
            <guid isPermaLink="false">news_<?= htmlspecialchars($news->news_id) ?></guid>
        </item>

<?php endforeach; // NEWS LAYER ?>
<?php foreach($cities_array as $city): // CITY LAYER ?>
        <item>
            <title>City: <?= htmlspecialchars($city->city_name) ?></title>
            <link><?= htmlspecialchars($site_domain) ?></link>

            <description><?= htmlspecialchars(get_city_description($city)) ?></description>

            <category>City</category>
            <category><?= htmlspecialchars($city->country) ?></category>

            <guid isPermaLink="false">city_<?= htmlspecialchars($city->city_id) ?></guid>
        </item>

<?php foreach($city->districts as $district): // DISTRICT LAYER ?>
        <item>
            <title>District: <?= htmlspecialchars($district->district_name) ?> [<?= htmlspecialchars($city->city_name) ?>]</title>
            <link><?= htmlspecialchars($site_domain) ?></link>

            <description><?= htmlspecialchars(get_district_description($district, $city)) ?></description>

            <category>District</category>
            <category><?= htmlspecialchars($city->city_name) ?></category>

            <guid isPermaLink="false">district_<?= htmlspecialchars($district->district_id) ?></guid>
        </item>

<?php foreach($district->POIs as $poi): // POI LAYER ?>
        <item>
            <title>Place of Interest: <?= htmlspecialchars($poi->POI_name) ?> [<?= htmlspecialchars($city->city_name) ?>]</title>
            <link><?= htmlspecialchars($site_domain) ?></link>

            <description><?= htmlspecialchars(get_poi_description($poi, $city, $site_domain)) ?></description>

            <category>Place of Interest</category>
            <category><?= htmlspecialchars($district->district_name) ?></category>
            <category><?= htmlspecialchars($city->city_name) ?></category>

            <guid isPermaLink="false">poi_<?= htmlspecialchars($poi->POI_id) ?></guid>
        </item>

<?php endforeach; // POI LAYER ?>
<?php foreach($district->transport_stations as $station): // TRANSPORT STATION LAYER ?>
        <item>
            <title>Transport Station: <?= htmlspecialchars($station->station_name) ?> [<?= htmlspecialchars($city->city_name) ?>]</title>
            <link><?= htmlspecialchars($site_domain) ?></link>

            <description><?= htmlspecialchars(get_station_description($station, $city)) ?></description>

            <category>Transport Station</category>
            <category><?= htmlspecialchars($district->district_name) ?></category>
            <category><?= htmlspecialchars($city->city_name) ?></category>

            <guid isPermaLink="false">station_<?= htmlspecialchars($station->station_id) ?></guid>
        </item>

<?php endforeach; // PUBLIC SERVICE LAYER ?>
<?php $services_outputted = []; ?>
<?php foreach($district->public_services as $service): // TRANSPORT STATION LAYER ?>
<?php if(in_array($service->service_id, $services_outputted)) { continue; } else { $services_outputted[] = $service->service_id; } ?>
        <item>
            <title>Public Service: <?= htmlspecialchars($service->service_name) ?> [<?= htmlspecialchars($city->city_name) ?>]</title>
            <link><?= htmlspecialchars($site_domain) ?></link>

            <description><?= htmlspecialchars(get_service_description($service, $city)) ?></description>

            <category>Public Service</category>
            <category><?= htmlspecialchars($district->district_name) ?></category>
            <category><?= htmlspecialchars($city->city_name) ?></category>

            <guid isPermaLink="false">service_<?= htmlspecialchars($service->service_id) ?></guid>
        </item>

<?php endforeach; // PUBLIC SERVICE LAYER ?>
<?php endforeach; // DISTRICT LAYER ?>
<?php endforeach; // CITY LAYER ?>
    </channel>
</rss>
