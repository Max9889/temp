import icons from "../../icons.js"

// takes a universal weather code and returns plaintext
// html for the appropriate description
export default function getWeatherCodeInfo(code) {
    const descriptions = {
        0: {text: "Clear Skies       ", svg: icons.sun,},
        1: {text: "Mostly Clear Skies", svg: icons.sun_small_cloud},
        2: {text: "Partly Cloudy     ", svg: icons.sun_big_cloud},
        3: {text: "Overcast          ", svg: icons.cloud},
        45: {text: "Foggy             ", svg: icons.fog},
        51: {text: "Light Drizzle     ", svg: icons.raindrop},
        61: {text: "Slight Rain       ", svg: icons.rainy_cloud},
    }
    return descriptions[code] || {text: "Unknown           ", svg: icons.question_mark};
}
