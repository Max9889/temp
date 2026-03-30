import initInfoTab from "./infoTab/initInfoTab.js"
import initMaps from "./leafletJS/initMaps.js"
import initWidget from "./photoWidget/initWidget.js"

await initInfoTab();
await initMaps();
await initWidget();
