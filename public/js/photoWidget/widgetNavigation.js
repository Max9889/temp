import { CITIES } from "../infoTab/weather/outputWeather.js"
import { photoWidgetState } from "../state.js"
import outputPhoto from "./outputPhoto.js"

export default function applyButtonEventListeners() {
    let liverpoolLeft = document.getElementById("liverpool-widget-button-left");
    let liverpoolRight = document.getElementById("liverpool-widget-button-right");
    let shanghaiLeft = document.getElementById("shanghai-widget-button-left");
    let shanghaiRight = document.getElementById("shanghai-widget-button-right");

    liverpoolLeft.addEventListener("click", () => _navigatePhotos(-1, CITIES.liverpool));
    liverpoolRight.addEventListener("click", () => _navigatePhotos(1, CITIES.liverpool));
    shanghaiLeft.addEventListener("click", () => _navigatePhotos(-1, CITIES.shanghai));
    shanghaiRight.addEventListener("click", () => _navigatePhotos(1, CITIES.shanghai));
}

export async function _navigatePhotos(direction, city) {
    let imageContainer = document.getElementById(`${city}-image-container`);

    // correctly identifies menu index required for given city
    // defaults to shanghai like the php weather api endpoint for scalability
    let menuIndex;
    switch(city) {
        case CITIES.liverpool: menuIndex = "liverpoolWidgetIndex"; break;
        case CITIES.shanghai: menuIndex = "shanghaiWidgetIndex"; break;
        default: menuIndex = "shanghaiWidgetIndex";
    }

    const menuMax = 3;

    // scroll menu in the direction given
    console.log("current menu index: " + photoWidgetState[menuIndex]);
    photoWidgetState[menuIndex] = (photoWidgetState[menuIndex] + direction + menuMax) % menuMax;
    console.log("after scrolling menu index: " + photoWidgetState[menuIndex]);

    // apply animation, only continue after complete (event listener is removed after one pass)
    // this is done by awaiting a promise which is resolved when the "animationend" event is raised
    // by infoTab
    if (direction != 0) { // direction 0 allows for navigation back to weather from place
        imageContainer.classList.add(`image-container-scroll-${(direction == -1) ? "left" : "right"}`);
        await new Promise((resolve) => {
            imageContainer.addEventListener("animationend", resolve, {once: true}) ;
        });
    }

    // clear image so it doesn't flicker
    document.getElementById(`${city}-image-container`).innerHTML = "";
    await outputPhoto(photoWidgetState[menuIndex]+1, city);
}
