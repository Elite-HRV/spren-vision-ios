import {Navigation} from 'react-native-navigation';
import {colorsMain} from "../utils";

Navigation.setDefaultOptions({
    statusBar: {
        translucent: true,
        drawBehind: true,
        style: 'light',
        backgroundColor: colorsMain.backgroundColor,
        animated: true,
    },
    topBar: {
        visible: false,
    },
    layout: {
        backgroundColor: colorsMain.backgroundColor,
        componentBackgroundColor: colorsMain.backgroundColor,
        orientation: ['portrait'],
    },
    navigationBar: {
        backgroundColor: colorsMain.backgroundColor,
        visible: false,
    },
});
