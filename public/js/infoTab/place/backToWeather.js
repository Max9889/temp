import { _tabModeWeather } from "../tabChangeMode.js"
import { _navigateMenu } from "../tabNavigation.js"

export default function backToWeather(infoTab) {
    let city = infoTab.id.split("-")[2];
    _tabModeWeather(infoTab);
    _navigateMenu(0, city);
}
