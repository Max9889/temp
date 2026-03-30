import getPhoto from "../services/getPhoto.js"
import setWidgetLoad from "./setWidgetLoad.js"

export default async function _outputPhoto(photoID, city) {
    let imageContainer = document.getElementById(`${city}-image-container`);
    imageContainer.className = "image-container";

    let spinnerPromise = setWidgetLoad(imageContainer);
    let photo = await getPhoto(city, photoID);

    let img = new Image();
    img.src = photo.src.tiny;
    img.alt = photo.alt;

    // preload image promise for spinner timing
    let imageDecodePromise = img.decode();
    await Promise.all([spinnerPromise, imageDecodePromise]);

    imageContainer.innerHTML = "";
    imageContainer.appendChild(img);
}
