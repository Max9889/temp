// output an error message into the infotab
export default function _outputErrorWeather(infoTab) {
        infoTab.innerHTML = `
        <div>
            <h2>Weather Error</h2>
        </div>
        <div style="width: 20rem;">
            <p>We encountered an error when trying to fetch the weather data. Please try again later!</p>
        </div>`
}
