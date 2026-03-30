// returns json photo data given query parameters
export default async function _getPhoto(city, index) {
    try {
        let response = await fetch(`../../api/get_photo.php?city=${city}&index=${index}`);
        let data = await response.json();

        // store data and version in local storage if status not error
        if (data.status !== "error") {
            return data;
        } else {
            const backendError = new Error(data.message);
            if (data.debug) { backendError.details = data.debug; }
            throw backendError;
        }
    } catch (err) {
        console.error("Fetch failed: " + err.message);
        if (err.details) { console.table(err.details); }
    }

    // return null if error occurs
    return null;
}
