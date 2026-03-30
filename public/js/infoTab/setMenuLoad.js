import icons from "../icons.js"

// sets the infotab to a loading spinner icon for at minimum 500ms
export default function _setMenuLoad(infoTab) {
    infoTab.className = "info-tab-defaults info-tab-loading";
    infoTab.innerHTML = `<img src=${icons.spinner} class="spinner"></img>`
    return new Promise((resolve) => { // minimum time for spinner to show
        setTimeout(resolve, 300);
        infoTab.className = "info-tab-defaults info-tab-active";
    });
}
