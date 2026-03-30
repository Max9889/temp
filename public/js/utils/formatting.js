// format standardised ISO dates from db to dd/mm/yyyy
export function formatDate(date) {
    return date.split("-").reverse().join("/");
}

// format number into formatted string x,xxx,xxx
export function formatNumber(number) {
    return new Intl.NumberFormat().format(number);
}

// format temperature to be the same number of chars
export function formatTemp(temp) {
    let tempStr = Math.round(temp).toString();
    if (tempStr.length == 2) { return tempStr; }
    return "0" + tempStr;
}
