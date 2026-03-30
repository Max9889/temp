import { formatDate } from "../../utils/formatting.js"
import { menuState } from "../../state.js"
import { CITIES, TOTAL_WEATHER_MENUS } from "../weather/outputWeather.js"
import setMenuLoad from "../setMenuLoad.js"
import getCities from "../../services/getCities.js"

// we do not need to catch errors here, as the news tabs will never
// be navigable to unless news has been confirmed from the php endpoint
export default async function _outputNews(city, infoTab) {
    let citiesPromise = getCities();
    let spinnerPromise = setMenuLoad(infoTab);
    let [citiesObject] = await Promise.all([citiesPromise, spinnerPromise]);

    // get appropriate menu index for city
    // defaults to shanghai for easy scalability
    let menuIndex;
    switch (city) {
        case CITIES.liverpool:
            menuIndex = menuState.liverpoolMenuIndex; 
            break;
        case CITIES.shanghai:
            menuIndex = menuState.shanghaiMenuIndex;
            break;
        default:
            menuIndex = menuState.shanghaiMenuIndex;
    }

    // convert city from URL format to cities api endpoint return format
    city = city.charAt(0).toUpperCase() + city.slice(1);

    console.log(citiesObject);
    console.log(city);
    let newsArray = citiesObject[city].news;
    let news = newsArray[menuIndex - TOTAL_WEATHER_MENUS];

    infoTab.innerHTML = `
    <div>
        <h2 style="text-align: center;">${news.title}, (${news.source})</h2>
        <b>Author: ${news.author}</b>
    </div>     
    <div style="display: flex; flex-direction: column; justify-content: space-around; align-items: center; text-align: center;">
        <p style="text-align: justify; width: 80%;">${news.description}</p>     
        <div>
            <p>Click <a href=${news.news_url}>here</a> to read the full article!</p>
            <p>Published ${formatDate(news.date_published)}</p>
        </div>
    </div>     
    `;
}
