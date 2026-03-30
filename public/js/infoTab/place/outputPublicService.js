import { _tabModePlace } from "../tabChangeMode.js"
import backToWeather from "./backToWeather.js"
import setMenuLoad from "../setMenuLoad.js"

export default async function _outputPublicService(publicService, infoTab) {
    _tabModePlace(infoTab); 

    await setMenuLoad(infoTab);

    infoTab.innerHTML = `
    <div>
        <h2>${publicService.service_name}</h2>
        <b>Public Service - ${publicService.service_type}</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <b style="text-align: justify;">${publicService.description}</b>     
        <button id="info-tab-back-button-${infoTab.id}" class="info-tab-back-button">Back</button>
    </div>     
    `;

    // add event listener to back button
    document.getElementById(`info-tab-back-button-${infoTab.id}`).addEventListener("click", function() {backToWeather(infoTab)});
}
