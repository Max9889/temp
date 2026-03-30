import outputCurrentWeather from "./outputCurrentWeather.js"
import outputForecastWeather from "./outputForecastWeather.js"
import getWeather from "../../services/getWeather.js"
import setMenuLoad from "../setMenuLoad.js"

// consts defined clearly to avoid passing string literals to function
export const CITIES = {
    liverpool: "liverpool",
    shanghai: "shanghai",
};

export const DISPLAY_TYPE = {
    current: "current",
    forecast: "forecast",
};

export const TOTAL_WEATHER_MENUS = 2;

// manager function for central calls to forecast or current weather display
// city -> CITIES object
// output_type -> DISPLAY_TYPE object
export async function outputWeather(city, displayType) {
    // reference the appropriate infoTab element
    const infoTab = document.getElementById(`info-tab-${city}`);

    // await spinner animation and fetch request before calling
    // appropriate output function
    const weatherPromise = getWeather(city, displayType);
    const spinnerPromise = setMenuLoad(infoTab);
    let [weatherObject] = await Promise.all([weatherPromise, spinnerPromise]);

    // call the appropriate output function with the acquired data
    switch(displayType) {
        case DISPLAY_TYPE.current:
            outputCurrentWeather(weatherObject, infoTab);
            return;
        case DISPLAY_TYPE.forecast:
            outputForecastWeather(weatherObject, infoTab);
            return;
    }
}
