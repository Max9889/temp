import icons from "../icons.js"

// sets the photo widget image container to a loading spinner icon for at minimum 500ms
export default function _setWidgetLoad(imageContainer) {
    imageContainer.innerHTML = `<img src=${icons.spinner} class="spinner-small"></img>`
    return new Promise((resolve) => { // minimum time for spinner to show
        setTimeout(resolve, 300);
    });
}
