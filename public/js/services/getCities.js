// returns json city data from php db endpoint
export default async function _getCities() {
    const citiesDataKey = `cities-data`; // local storage key for weather data
    const citiesDataVersionKey = `cities-data-version`; // local storage key for weather data timestamp

    let citiesData = localStorage.getItem(citiesDataKey); // access local storage weather data
    let citiesDataVersion = localStorage.getItem(citiesDataVersionKey) // access local storage weather data timestamp
    
    let versionResponse = await fetch("../../api/get_cities_version.php");
    let citiesDataServerVersion = await versionResponse.text();

    // if cities data exists in HTML5 local storage AND version is up-to-date
    // this fetch to the php file is much quicker, as it does not query the db and is only a small string
    if (citiesData && citiesDataVersion == citiesDataServerVersion) {
        return JSON.parse(citiesData);
    }

    // otherwise, continue to query from the api as normal

    try {
        let response = await fetch("../../api/get_cities.php");
        let data = await response.json();

        // store data and version in local storage if status not error
        if (data.status !== "error") {
            localStorage.setItem(citiesDataKey, JSON.stringify(data));
            localStorage.setItem(citiesDataVersionKey, citiesDataServerVersion);
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

    // return null if error occurs
    return null;
}
