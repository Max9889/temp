// contains the current menu index (page) of each city
// contains max menu items to be dynamically set when total
// news has been obtained
export const menuState = {
    liverpoolMenuIndex: 0,
    shanghaiMenuIndex: 0,
    liverpoolMenuMax: null,
    shanghaiMenuMax: null,
};

// contains instances of both maps to be dynamically set by
// leafletJS module
export const mapState = {
    liverpoolMap: null,
    shanghaiMap: null,
};

// contains the current photo index (page) of each photo widget
export const photoWidgetState = {
    liverpoolWidgetIndex: 0,
    shanghaiWidgetIndex: 0,
};
