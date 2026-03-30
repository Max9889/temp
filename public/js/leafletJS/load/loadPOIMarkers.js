import { mapState } from "../../state.js"
import { formatDate } from "../../utils/formatting.js"
import _setMarker from "../setMarker.js"
import outputPOI from "../../infoTab/place/outputPOI.js"
import icons from "../../icons.js"

export default function _loadPOIMarkers(citiesObject) {
    let markerOptions = L.icon({
        iconUrl: icons.POI,

        iconSize: [25,25],
        iconAnchor: [12.5, 25],
    });

    let popupText = (POI, district, city) => {
        return `
            <b>${POI.POI_name}</b><br>
            A place of interest in ${district.district_name}, ${city.city_name}.<br><br>

            Established: ${formatDate(POI.date_established)}`;
    }

    citiesObject.Liverpool.districts.forEach(district => {
        district.POIs.forEach(POI => {
            let latlng = [POI.lat, POI.lng];
            _setMarker(
                mapState.liverpoolMap,
                latlng,
                markerOptions,
                function() {outputPOI(POI, citiesObject.Liverpool, document.getElementById("info-tab-liverpool"))},
                popupText(POI, district, citiesObject.Liverpool)
            );
        });
    });

    citiesObject.Shanghai.districts.forEach(district => {
        district.POIs.forEach(POI => {
            let latlng = [POI.lat, POI.lng];
            _setMarker(
                mapState.shanghaiMap,
                latlng,
                markerOptions,
                function() {outputPOI(POI, citiesObject.Shanghai, document.getElementById("info-tab-shanghai"))},
                popupText(POI, district, citiesObject.Shanghai)
            );
        });
    });
}
