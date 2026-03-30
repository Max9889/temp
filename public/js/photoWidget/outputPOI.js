import setWidgetLoad from "./setWidgetLoad.js"
 
export default async function outputPOI(imagePath, imageCaption, city) {
    let imageContainer = document.getElementById(`${city}-image-container`);
    imageContainer.className = "image-container";

    await setWidgetLoad(imageContainer);

    let img = new Image();
    img.src = imagePath;
    img.alt = imageCaption;

    imageContainer.innerHTML = "";
    imageContainer.appendChild(img);
}
