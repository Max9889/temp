import { mapState } from "../../state.js"
import { formatNumber } from "../../utils/formatting.js"
import setMarker from "../setMarker.js"
import outputDistrict from "../../infoTab/place/outputDistrict.js"
import icons from "../../icons.js"

export default function _loadDistrictMarkers(citiesObject) {
    let markerOptions = L.icon({
        iconUrl: icons.district,

        iconSize: [37.5,37.5],
        iconAnchor: [18.75, 37.5],
    });

    let popupText = (district, city) => {
        return `
            <b>${district.district_name}</b><br>
            A district in ${city.city_name}.<br><br>

            Population: ${formatNumber(district.population)}`;
    }

    citiesObject.Liverpool.districts.forEach(district => {
        let latlng = [district.lat, district.lng];
        setMarker(
            mapState.liverpoolMap,
            latlng,
            markerOptions,
            function() {outputDistrict(district, document.getElementById("info-tab-liverpool"))},
            popupText(district, citiesObject.Liverpool)
        );
    });

    citiesObject.Shanghai.districts.forEach(district => {
        let latlng = [district.lat, district.lng];
        setMarker(
            mapState.shanghaiMap,
            latlng,
            markerOptions,
            function() {outputDistrict(district, document.getElementById("info-tab-shanghai"))},
            popupText(district, citiesObject.Shanghai)
        );
    });
}
