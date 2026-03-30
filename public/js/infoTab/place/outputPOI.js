import { _tabModePlace } from "../tabChangeMode.js"
import { formatDate, formatNumber } from "../../utils/formatting.js"
import backToWeather from "./backToWeather.js"
import setMenuLoad from "../setMenuLoad.js"
import outputPOI from "../../photoWidget/outputPOI.js"
import { _widgetPhotoMode, _widgetPOIMode } from "../../photoWidget/widgetChangeMode.js"
import { _navigatePhotos } from "../../photoWidget/widgetNavigation.js"

export default async function _outputPOI(POI, city, infoTab) {
    _tabModePlace(infoTab); 

    let targetCity = infoTab.id.split("-")[2];
    _widgetPOIMode(targetCity);
    await Promise.all([setMenuLoad(infoTab), outputPOI("assets/img/poi/"+POI.image_filename, POI.image_caption, targetCity)]);

    infoTab.innerHTML = `
    <div>
        <h2>${POI.POI_name}</h2>
        <b>Place of Interest</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <b style="text-align: justify;">${POI.description}</b>     
        <div>
            <p><b>Established:</b> ${formatDate(POI.date_established)}</p>
            <p><b>Total Visitors:</b> ${formatNumber(POI.visitor_capacity)}</p>
            <p><b>Entry Fee (local currency):</b> ${POI.entry_fee} ${city.currency}</p>
            <p><b>Accessibility Rating:</b> ${POI.accessibility_rating}/10</p>
            <p><b>Total Area:</b> ${POI.area}km²</p>
        </div>
        <button id="info-tab-back-button-${infoTab.id}" class="info-tab-back-button">Back</button>
    </div>     
    `;

    // add event listener to back button
    document.getElementById(`info-tab-back-button-${infoTab.id}`).addEventListener("click", async function() {backToWeather(infoTab); await _navigatePhotos(0, targetCity); _widgetPhotoMode(targetCity); });
}
