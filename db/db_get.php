<?php
require_once __DIR__ . '/../config/config.php'; // provides env superglobals and error handling

function get_cities_json() {
    // note: i would've loved to use the JSON_ARRAYAGG() and JSON_ARRAY()
    // functions, but this version of MYSQL doesn't support them
    // instead, i have used CONCAT, GROUP_CONCAT and JSON_QUERY to build json arrays manually
    $sql_query = <<<SQL
        -- form the outermost city object --
        SELECT JSON_OBJECT(
            "city_id", c.city_id,
            "city_name", c.city_name,
            "country", (SELECT country_name FROM country co WHERE co.country_id = c.country_id),
            "timezone", (SELECT timezone_name FROM timezone t WHERE t.timezone_id = c.timezone_id),
            "lat", c.lat,
            "lng", c.lng,
            "population", c.population,
            "mayor_name", c.mayor_name,
            "GDP", c.GDP,
            "currency", c.currency,
            "area", c.area,

            -- form the array of news objects -- 
            "news", JSON_QUERY(COALESCE((SELECT CONCAT("[", GROUP_CONCAT(
                JSON_OBJECT(
                    "news_id", n.news_id,
                    "author", (SELECT author_name FROM author a WHERE a.author_id = n.author_id),
                    "source", (SELECT source_name FROM source s WHERE s.source_id = n.source_id),
                    "title", n.title,
                    "description", n.description,
                    "news_url", n.news_url,
                    "image_url", n.image_url,
                    "date_published", n.date_published
                )
            ), "]") FROM news n WHERE n.news_id IN (SELECT news_id FROM relevant_news WHERE city_id = c.city_id))
            , "[]"), "$"), -- return empty array if no news selected

            -- form the array of district objects -- 
            "districts", JSON_QUERY(COALESCE((SELECT CONCAT("[", GROUP_CONCAT(
                JSON_OBJECT(
                    "district_id", d.district_id,
                    "district_name", d.district_name,
                    "description", d.description,
                    "lat", d.lat,
                    "lng", d.lng,
                    "area", d.area,
                    "population", d.population,

                    -- form the array of transport_station objects --
                    "transport_stations", JSON_QUERY(COALESCE((SELECT CONCAT("[", GROUP_CONCAT(
                        JSON_OBJECT(
                            "station_id", ts.station_id,
                            "station_name", ts.station_name,
                            "station_type", (SELECT station_type_name FROM transport_station_type WHERE station_type_id = ts.station_type_id),
                            "description", ts.description,
                            "lat", ts.lat,
                            "lng", ts.lng,
                            "toilets_available", ts.toilets_available,
                            "accessibility_rating", ts.accessibility_rating
                        ) 
                    ), "]") FROM transport_station ts WHERE d.district_id = ts.district_id)
                    , "[]"), "$"), -- return empty array if no transport stations selected

                    -- form the array of transport_station objects --
                    "public_services", JSON_QUERY(COALESCE((SELECT CONCAT("[", GROUP_CONCAT(
                        JSON_OBJECT(
                            "service_id", ps.service_id,
                            "service_name", ps.service_name,
                            "service_type", (SELECT service_type_name FROM public_service_type WHERE service_type_id = ps.service_type_id),
                            "description", ps.description,
                            "lat", ps.lat,
                            "lng", ps.lng
                        ) 
                    ), "]") FROM public_service ps WHERE d.district_id = (SELECT district_id FROM service_area WHERE service_area_id = ps.service_area_id))
                    , "[]"), "$"), -- return empty array if no transport stations selected

                    -- form the array of POI objects --
                    "POIs", JSON_QUERY(COALESCE((SELECT CONCAT("[", GROUP_CONCAT(
                        JSON_OBJECT(
                            "POI_id", p.POI_id,
                            "POI_name", p.POI_name,
                            "description", p.description,
                            "lat", p.lat,
                            "lng", p.lng,
                            "area", p.area,
                            "date_established", p.date_established,
                            "accessibility_rating", p.accessibility_rating,
                            "entry_fee", p.entry_fee,
                            "visitor_capacity", p.visitor_capacity,
                            "image_filename", p.image_filename,
                            "image_caption", p.image_caption
                        ) 
                    ), "]") FROM POI p WHERE d.district_id = p.district_id)
                    , "[]"), "$") -- return empty array if no transport stations selected
                )     
            ), "]") FROM district d WHERE d.city_id = c.city_id)
            , "[]"), "$") -- return empty array if no districts selected
            
        ) FROM city c
    SQL;

    // form connection to database server
    $db_connection = new mysqli($_ENV["DB_HOST"], $_ENV["DB_USERNAME"], "", $_ENV["DB_NAME"]);
    if ($db_connection->connect_error) { // placeholder connection error
        exit("Failed to connect to db");
    }

    $db_connection->query("SET SESSION group_concat_max_len = 1000000;"); // set query return limit high enough to fit everything

    // run the defined query
    $db_query = $db_connection->query($sql_query);
    $json_output = []; // define container for results

    // iterate through results and store them by name
    while ($row = $db_query->fetch_row()) {
        $city = json_decode($row[0]); // only one field in row, as the SQL query returns a json object
        $json_output[$city->city_name] = $city;
    }
    $db_connection->close(); // close the db connection as no longer using it

    return $json_output;
}
?>
