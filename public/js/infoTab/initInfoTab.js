import {CITIES, DISPLAY_TYPE, TOTAL_WEATHER_MENUS, outputWeather} from "./weather/outputWeather.js"
import { menuState } from "../state.js"
import getCities from "../services/getCities.js"
import applyButtonEventListeners from "./tabNavigation.js"

export default async function initInfoTab() {
    let citiesObject = await getCities();
    if (citiesObject != null) {
        menuState.liverpoolMenuMax = citiesObject.Liverpool.news.length + TOTAL_WEATHER_MENUS;
        menuState.shanghaiMenuMax = citiesObject.Shanghai.news.length + TOTAL_WEATHER_MENUS;
    } else {
        menuState.liverpoolMenuMax = TOTAL_WEATHER_MENUS;
        menuState.shanghaiMenuMax = TOTAL_WEATHER_MENUS;
    }

    outputWeather(CITIES.liverpool, DISPLAY_TYPE.current);
    outputWeather(CITIES.shanghai, DISPLAY_TYPE.current);
    applyButtonEventListeners();
}
