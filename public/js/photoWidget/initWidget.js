import { CITIES } from "../infoTab/weather/outputWeather.js"
import outputPhoto from "./outputPhoto.js"
import applyButtonEventListeners from "./widgetNavigation.js"

export default async function initWidget() {
    outputPhoto(1, CITIES.liverpool);
    outputPhoto(1, CITIES.shanghai);
    applyButtonEventListeners();
}
