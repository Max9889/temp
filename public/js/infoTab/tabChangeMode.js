// shows the left and right navigation buttons
export function _tabModeWeather(infoTab) {
    infoTab.previousElementSibling.style = "opacity: 255" ;
    infoTab.nextElementSibling.style = "opacity: 255" ;
}

// hides the left and right navigation buttons
export function _tabModePlace(infoTab) {
    infoTab.previousElementSibling.style = "opacity: 0" ;
    infoTab.nextElementSibling.style = "opacity: 0" ;
}
