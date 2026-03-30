import _setMarker from "../setMarker.js"
import outputPublicService from "../../infoTab/place/outputPublicService.js"
import icons from "../../icons.js"
import { mapState } from "../../state.js"

export default function _loadPublicServiceMarkers(citiesObject) {
    let markerOptions = L.icon({
        iconUrl: icons.service,

        iconSize: [25,25],
        iconAnchor: [12.5, 25],
    });

    let popupText = (publicService, city) => {
        return `
            <b>${publicService.service_name}</b><br>
            A public service for ${city.city_name}<br><br>

            Service type: ${publicService.service_type}
        `;
    }

    citiesObject.Liverpool.districts.forEach(district => {
        district.public_services.forEach(publicService => {
            let latlng = [publicService.lat, publicService.lng];
            _setMarker(
                mapState.liverpoolMap,
                latlng,
                markerOptions,
                function() {outputPublicService(publicService, document.getElementById("info-tab-liverpool"))},
                popupText(publicService, citiesObject.Liverpool)
            );
        });
    });

    citiesObject.Shanghai.districts.forEach(district => {
        district.public_services.forEach(publicService => {
            let latlng = [publicService.lat, publicService.lng];
            _setMarker(
                mapState.shanghaiMap,
                latlng,
                markerOptions,
                function() {outputPublicService(publicService, document.getElementById("info-tab-shanghai"))},
                popupText(publicService, citiesObject.Shanghai)
            );
        });
    });
}
