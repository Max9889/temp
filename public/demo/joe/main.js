import {CITIES, DISPLAY_TYPE, outputWeather} from "../../js/infoTab/outputWeather.js"
import applyButtonEventListeners from "../../js/infoTab/tabNavigation.js"

outputWeather(CITIES.liverpool, DISPLAY_TYPE.current);
applyButtonEventListeners();
