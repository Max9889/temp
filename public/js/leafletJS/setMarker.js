export default function _setMarker(map, latlng, markerIcon, onclickEvent, popupText) {
    let marker = L.marker(latlng, {icon: markerIcon});
    if (onclickEvent) { marker.on("click", onclickEvent); }
    if (popupText) {
        marker.bindPopup(popupText, {offset: [0, -30], closeButton: false, autoPan: false});
        marker.on("mouseover", () => { marker.openPopup(); }); 
        marker.on("mouseout", () => { marker.closePopup(); });
    }
    marker.addTo(map);
}
