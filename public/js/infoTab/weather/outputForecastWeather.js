import { formatDate, formatTemp } from "../../utils/formatting.js"
import icons from "../../icons.js"
import getWeatherCodeInfo from "./getWeatherCodeInfo.js"
import outputErrorWeather from "./outputErrorWeather.js"

// default function for this file, accesses the infotab for
// a given parameter city and displays weather forecast from the weatherObject provided
export default function _outputForecastWeather(weatherObject, infoTab) {
    if (weatherObject == null) {
        outputErrorWeather(infoTab); 
        return;
    }

    const weatherCodeOutput = (weatherCode) => {
        let weatherCodeInfo = getWeatherCodeInfo(weatherCode);
        return `<img src=${weatherCodeInfo.svg} class="weather-icon-small"></img>${weatherCodeInfo.text}`;
    }

    const lowTempIcon = `<img src=${icons.temp_cold} class="weather-icon-small"></img>`;
    const highTempIcon = `<img src=${icons.temp_hot} class="weather-icon-small"></img>`;


    infoTab.innerHTML = `
        <div>
            <h2>Weather Forecast</h2>
            <b>Weekly</b>
        </div>
        <div>
        <span style="display: flex; flex-direction: row; justify-content: center; align-items: space-around;">
            <div>
                <p><b>${formatDate(weatherObject.time[0])}:</b> ${weatherCodeOutput(weatherObject.weather_code[0])}</p>
                <p><b>${formatDate(weatherObject.time[1])}:</b> ${weatherCodeOutput(weatherObject.weather_code[1])}</p>
                <p><b>${formatDate(weatherObject.time[2])}:</b> ${weatherCodeOutput(weatherObject.weather_code[2])}</p>
                <p><b>${formatDate(weatherObject.time[3])}:</b> ${weatherCodeOutput(weatherObject.weather_code[3])}</p>
                <p><b>${formatDate(weatherObject.time[4])}:</b> ${weatherCodeOutput(weatherObject.weather_code[4])}</p>
                <p><b>${formatDate(weatherObject.time[5])}:</b> ${weatherCodeOutput(weatherObject.weather_code[5])}</p>
                <p><b>${formatDate(weatherObject.time[6])}:</b> ${weatherCodeOutput(weatherObject.weather_code[6])}</p>
            </div>
            <div>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[0])}°C → ${formatTemp(weatherObject.temperature_2m_max[0])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[1])}°C → ${formatTemp(weatherObject.temperature_2m_max[1])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[2])}°C → ${formatTemp(weatherObject.temperature_2m_max[2])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[3])}°C → ${formatTemp(weatherObject.temperature_2m_max[3])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[4])}°C → ${formatTemp(weatherObject.temperature_2m_max[4])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[5])}°C → ${formatTemp(weatherObject.temperature_2m_max[5])}°C${highTempIcon}</p>
                <p>${lowTempIcon}${formatTemp(weatherObject.temperature_2m_min[6])}°C → ${formatTemp(weatherObject.temperature_2m_max[6])}°C${highTempIcon}</p>
            </div>
        </span>
        </div>
    `;
}
