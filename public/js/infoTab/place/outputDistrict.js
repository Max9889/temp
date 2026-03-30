import { _tabModePlace } from "../tabChangeMode.js"
import { formatNumber } from "../../utils/formatting.js"
import backToWeather from "./backToWeather.js"
import setMenuLoad from "../setMenuLoad.js"

export default async function _outputDistrict(district, infoTab) {
    _tabModePlace(infoTab); 

    await setMenuLoad(infoTab);

    // acquire station and service names for district
    let transportStationNames = [];
    district.transport_stations.forEach(ts => { transportStationNames.push(ts.station_name); });

    let publicServiceNames = [];
    district.public_services.forEach(ps => { publicServiceNames.push(ps.service_name); });

    let POINames = [];
    district.POIs.forEach(poi => { POINames.push(poi.POI_name); });

    infoTab.innerHTML = `
    <div>
        <h2>${district.district_name}</h2>
        <b>District</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <b style="text-align: justify;">${district.description}</b>     
        <div style="text-align: left;">
            ${(transportStationNames.length > 0) ? '<p><b>Transport:</b> ' + transportStationNames.join(", ") + '</p>' : ''}
            ${(publicServiceNames.length > 0) ? '<p><b>Services:</b> ' + publicServiceNames.join(", ") + '</p>' : ''}
            ${(POINames.length > 0) ? '<p><b>Places of Interest:</b> ' + POINames.join(", ") + '</p>' : ''}
        </div>
        <div>
            <p><b>Population:</b> ${formatNumber(district.population)}</p>
            <p><b>Area:</b> ${district.area}km²</p>
        </div>
        <button id="info-tab-back-button-${infoTab.id}" class="info-tab-back-button">Back</button>
    </div>     
    `;

    // add event listener to back button
    document.getElementById(`info-tab-back-button-${infoTab.id}`).addEventListener("click", function() {backToWeather(infoTab)});
}
