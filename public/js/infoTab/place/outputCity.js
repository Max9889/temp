import { _tabModePlace } from "../tabChangeMode.js"
import { formatNumber } from "../../utils/formatting.js"
import backToWeather from "./backToWeather.js"
import setMenuLoad from "../setMenuLoad.js"

export default async function _outputCity(city, infoTab) {
    _tabModePlace(infoTab); 

    await setMenuLoad(infoTab);

    let districtNames = [];
    city.districts.forEach(district => { districtNames.push(district.district_name); });

    infoTab.innerHTML = `
    <div>
        <h2>${city.city_name}, ${city.country}</h2>
        <b>City</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <p><b>Districts:</b> ${districtNames.join(", ")}</p>     
        <div>
            <p><b>Population:</b> ${formatNumber(city.population)}</p>
            <p><b>Mayor:</b> ${city.mayor_name}</p>
            <p><b>GDP (local currency):</b> ${formatNumber(city.GDP)} ${city.currency}</p>
            <p><b>Total Area:</b> ${city.area}km²</p>
            <p><b>Timezone:</b> ${city.timezone}</p>
        </div>
        <button id="info-tab-back-button-${infoTab.id}" class="info-tab-back-button">Back</button>
    </div>     
    `;

    // add event listener to back button
    document.getElementById(`info-tab-back-button-${infoTab.id}`).addEventListener("click", function() {backToWeather(infoTab)});
}
