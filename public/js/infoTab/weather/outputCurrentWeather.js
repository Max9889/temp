import { formatTemp } from "../../utils/formatting.js"
import getWeatherCodeInfo from "./getWeatherCodeInfo.js"
import outputErrorWeather from "./outputErrorWeather.js"

// default function for this file, accesses the infotab for
// a given parameter city and displays current weather from the weatherObject provided
export default function _outputCurrentWeather(weatherObject, infoTab) {
    // check if the internal api returned an error
    if (weatherObject == null) {
        outputErrorWeather(infoTab);
        return; // return before the rest can happen
    }

    let time = weatherObject.time.split("T")[1];

    // adding the HTML to display the weather data via innerHTML rather than
    // "DOM soup" e.g createELement() twenty times
    let weatherCodeInfo = getWeatherCodeInfo(weatherObject.weather_code);
    infoTab.innerHTML = `
        <div>
            <span style="display: inline-flex; gap:0.25rem;">
                <img src=${weatherCodeInfo.svg} class="weather-icon"></img>
                <h2>${weatherCodeInfo.text}</h2>
            </span>
            <b>${time} (${(weatherObject.is_day) ? "Day" : "Night"})</b>
        </div>
        <div>
            <p><b>Temperature:</b> ${formatTemp(weatherObject.temperature_2m)}°C</p>
            <p><b>Feels like:</b> ${formatTemp(weatherObject.apparent_temperature)}°C</p>
            <p><b>Cloud Coverage:</b> ${weatherObject.cloud_cover}%</p>
            <p><b>Rain:</b> ${weatherObject.rain}mm</p>
            <p><b>Wind speed:</b> ${weatherObject.wind_speed_10m}mph</p>
            <p><b>Wind gusts:</b> ${weatherObject.wind_gusts_10m}mph</p>
            <p><b>Wind direction:</b> ${weatherObject.wind_direction_10m}°</p>
        </div>
    `;
}

