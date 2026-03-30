import { _tabModePlace } from "../tabChangeMode.js"
import backToWeather from "./backToWeather.js"
import setMenuLoad from "../setMenuLoad.js"

export default async function _outputTransportStation(transportStation, infoTab) {
    _tabModePlace(infoTab); 

    await setMenuLoad(infoTab);

    let toiletAvailability = (transportStation.toilets_available) ? "Yes" : "No";

    infoTab.innerHTML = `
    <div>
        <h2>${transportStation.station_name}</h2>
        <b>Transport Station - ${transportStation.station_type}</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <b style="text-align: justify;">${transportStation.description}</b>     
        <div>
            <p><b>Accessibility Rating:</b> ${transportStation.accessibility_rating}/10</p>
            <p><b>Toilets Available?</b> ${toiletAvailability}</p>
        </div>
        <button id="info-tab-back-button-${infoTab.id}" class="info-tab-back-button">Back</button>
    </div>     
    `;

    // add event listener to back button
    document.getElementById(`info-tab-back-button-${infoTab.id}`).addEventListener("click", function() {backToWeather(infoTab)});
}
