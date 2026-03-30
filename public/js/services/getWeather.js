// returns json weather data given city and display type, types
// defined in the weatherOutput manager file
export default async function _getWeather(city, displayType) {
    const weatherDataKey = `weather-${displayType}-${city}`; // local storage key for weather data
    const weatherDataTimestampKey = `weather-${displayType}-${city}-timestamp`; // local storage key for weather data timestamp
    const weatherDataLifetime = 15 * 60 * 1000; // 5 minutes in ms is max lifetime of weather in local storage
    const currentTime = Date.now(); 

    let weatherData = localStorage.getItem(weatherDataKey); // access local storage weather data
    let weatherDataTimestamp = localStorage.getItem(weatherDataTimestampKey) // access local storage weather data timestamp

    // if weather data storage exists (i.e. not null) and is NOT stale (>15 min), return from local storage
    if (weatherData && (currentTime - Number(weatherDataTimestamp) < weatherDataLifetime)) {
        return JSON.parse(weatherData);
    }

    // otherwise, continue to fetch from php endpoint
    
    try {
        let response = await fetch(`../../api/get_weather.php?city=${city}&return_type=${displayType}`);
        let data = await response.json();

        // store data and timestamp in local storage as long as status not error
        if (data.status !== "error") {
            localStorage.setItem(weatherDataKey, JSON.stringify(data));
            localStorage.setItem(weatherDataTimestampKey, currentTime);
            return data;
        } else {
            const backendError = new Error(data.message);
            if (data.debug) { backendError.details = data.debug; }
            throw backendError;
        }
    } catch (err) {
        console.error("Fetch failed: " + err.message);
        if (err.details) { console.table(err.details); }
    }

    // return null if error
    return null;
}
