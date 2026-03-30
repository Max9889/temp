import { CITIES, DISPLAY_TYPE, outputWeather } from "./weather/outputWeather.js"
import { menuState } from "../state.js"
import outputNews from "./news/outputNews.js"

export default function applyButtonEventListeners() {
    let liverpoolLeft = document.getElementById("liverpool-button-left");
    let liverpoolRight = document.getElementById("liverpool-button-right");
    let shanghaiLeft = document.getElementById("shanghai-button-left");
    let shanghaiRight = document.getElementById("shanghai-button-right");

    liverpoolLeft.addEventListener("click", () => _navigateMenu(-1, CITIES.liverpool)); // placeholder event
    liverpoolRight.addEventListener("click", () => _navigateMenu(1, CITIES.liverpool)); // placeholder event
    shanghaiLeft.addEventListener("click", () => _navigateMenu(-1, CITIES.shanghai)); // placeholder event
    shanghaiRight.addEventListener("click", () => _navigateMenu(1, CITIES.shanghai)); // placeholder event
}

export async function _navigateMenu(direction, city) {
    let infoTab = document.getElementById(`info-tab-${city}`)

    // correctly identifies menu index required for given city
    // defaults to shanghai like the php weather api endpoint for scalability
    let menuIndex;
    let menuMax;
    switch(city) {
        case CITIES.liverpool: 
            menuIndex = "liverpoolMenuIndex";
            menuMax = "liverpoolMenuMax";
            break;
        case CITIES.shanghai: 
            menuIndex = "shanghaiMenuIndex";
            menuMax = "shanghaiMenuMax";
            break;
        default:
            menuIndex = "shanghaiMenuIndex";
            menuMax = "shanghaiMenuMax";
    }

    // scroll menu in the direction given
    menuState[menuIndex] = (menuState[menuIndex] + direction + menuState[menuMax]) % menuState[menuMax];

    // apply animation, only continue after complete (event listener is removed after one pass)
    // this is done by awaiting a promise which is resolved when the "animationend" event is raised
    // by infoTab
    if (direction != 0) { // direction 0 allows for navigation back to weather from place
        infoTab.classList.add(`info-tab-scroll-${(direction == -1) ? "left" : "right"}`);
        await new Promise((resolve) => {
            infoTab.addEventListener("animationend", resolve, {once: true}) ;
        });
    }

    // output weather
    switch(menuState[menuIndex]) {
        case 0:
            outputWeather(city, DISPLAY_TYPE.current)
            return;
        case 1:
            outputWeather(city, DISPLAY_TYPE.forecast)
            return;
        default: // news
            outputNews(city, infoTab);
    }
}
