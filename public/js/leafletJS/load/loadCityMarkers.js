import { mapState } from "../../state.js"
import { formatNumber } from "../../utils/formatting.js"
import setMarker from "../setMarker.js"
import outputCity from "../../infoTab/place/outputCity.js"
import icons from "../../icons.js"

export default function _loadCityMarkers(citiesObject) {
    let markerOptions = L.icon({
        iconUrl: icons.city,

        iconSize: [50,50],
        iconAnchor: [25, 50],
    });

    let popupText = (city) => {
        return `
            <b>${city.city_name}<br>
            A city in ${city.country}.</b><br><br>

            Total population: ${formatNumber(city.population)}`;
    }

    setMarker( // liverpool marker
        mapState.liverpoolMap,
        [citiesObject.Liverpool.lat,citiesObject.Liverpool.lng],
        markerOptions,
        function() {outputCity(citiesObject.Liverpool,document.getElementById("info-tab-liverpool"))},
        popupText(citiesObject.Liverpool)
    );

    setMarker( // shanghai marker
        mapState.shanghaiMap,
        [citiesObject.Shanghai.lat, citiesObject.Shanghai.lng],
        markerOptions,
        function() {outputCity(citiesObject.Shanghai, document.getElementById("info-tab-shanghai"))},
        popupText(citiesObject.Shanghai)
    );
}
