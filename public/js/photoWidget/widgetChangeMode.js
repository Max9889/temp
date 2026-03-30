export function _widgetPhotoMode(city) {
    document.getElementById(`${city}-widget-button-left`).style="opacity:255;";
    document.getElementById(`${city}-widget-button-right`).style="opacity:255;";
}

export function _widgetPOIMode(city) {
    document.getElementById(`${city}-widget-button-left`).style="opacity:0;";
    document.getElementById(`${city}-widget-button-right`).style="opacity:0;";
}
