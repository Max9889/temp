import _setMarker from "../setMarker.js"
import outputTransportStation from "../../infoTab/place/outputTransportStation.js"
import icons from "../../icons.js"
import { mapState } from "../../state.js"

export default function _loadTransportStationMarkers(citiesObject) {
    let markerOptions = L.icon({
        iconUrl: icons.transport,

        iconSize: [25,25],
        iconAnchor: [12.5, 25],
    });

    let popupText = (transportStation, district, city) => {
        return `
            <b>${transportStation.station_name}</b><br>
            A transport station for ${district.district_name}, ${city.city_name}.<br><br>

            Transport type: ${transportStation.station_type}
        `;
    }

    citiesObject.Liverpool.districts.forEach(district => {
        district.transport_stations.forEach(transportStation => {
            let latlng = [transportStation.lat, transportStation.lng];
            _setMarker(
                mapState.liverpoolMap,
                latlng,
                markerOptions,
                function() {outputTransportStation(transportStation, document.getElementById("info-tab-liverpool"))},
                popupText(transportStation, district, citiesObject.Liverpool)
            );
        });
    });

    citiesObject.Shanghai.districts.forEach(district => {
        district.transport_stations.forEach(transportStation => {
            let latlng = [transportStation.lat, transportStation.lng];
            _setMarker(
                mapState.shanghaiMap,
                latlng,
                markerOptions,
                function() {outputTransportStation(transportStation, document.getElementById("info-tab-shanghai"))},
                popupText(transportStation, district, citiesObject.Shanghai)
            );
        });
    });
}
