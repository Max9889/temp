import _setMarker from "./setMarker.js"
import _loadCityMarkers from "./load/loadCityMarkers.js"
import _loadDistrictMarkers from "./load/loadDistrictMarkers.js"
import _loadTransportStationMarkers from "./load/loadTransportStationMarkers.js"
import _loadPublicServiceMarkers from "./load/loadPublicServiceMarkers.js"
import _loadPOIMarkers from "./load/loadPOIMarkers.js"
import _getCities from "../services/getCities.js"
import { mapState } from "../state.js"

export default async function initMaps() {
    let citiesObject = await _getCities();
    
    // init map instances
    let liverpoolMap = L.map('map-liverpool');
    let shanghaiMap = L.map('map-shanghai');
    let zoom = 13;

    // define tile layer options
    const openStreetMapURL = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    const openStreetMapAttribute = '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>';
    const tileLayerMaxZoom = 19;

    // set tile layers for both maps (using OpenStreetMap - open source)
    L.tileLayer(openStreetMapURL, {maxZOOM: tileLayerMaxZoom, attribution: openStreetMapAttribute}).addTo(liverpoolMap);
    L.tileLayer(openStreetMapURL, {maxZOOM: tileLayerMaxZoom, attribution: openStreetMapAttribute}).addTo(shanghaiMap);

    // save map instances to global state
    mapState.liverpoolMap = liverpoolMap;
    mapState.shanghaiMap = shanghaiMap;

    // error catching for database fetch
    if (citiesObject == null) {
        // fallback map centers for if database cannot be fetched
        const liverpoolCenterFallback = [53.400002, -2.983333];
        const shanghaiCenterFallback = [31.224361, 121.469170];

        liverpoolMap.setView(liverpoolCenterFallback, zoom);
        shanghaiMap.setView(shanghaiCenterFallback, zoom);

        let errorMessage = `
        <b>Internal fetch error</b><br><br>
        Could not fetch data for city. Map icons and city news will not be present. Please try again later!
        `;
        L.popup(liverpoolCenterFallback, {content: errorMessage}).addTo(liverpoolMap);
        L.popup(shanghaiCenterFallback, {content: errorMessage}).addTo(shanghaiMap);
    } else {
        // define centers for map view
        const liverpoolCenter = [citiesObject.Liverpool.lat, citiesObject.Liverpool.lng];
        const shanghaiCenter = [citiesObject.Shanghai.lat, citiesObject.Shanghai.lng];

        liverpoolMap.setView(liverpoolCenter, zoom);
        shanghaiMap.setView(shanghaiCenter, zoom);

        _loadCityMarkers(citiesObject);
        _loadDistrictMarkers(citiesObject);
        _loadTransportStationMarkers(citiesObject);
        _loadPublicServiceMarkers(citiesObject);
        _loadPOIMarkers(citiesObject);
    }
}
