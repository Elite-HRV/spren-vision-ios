import {getColors} from './index';
import { Appearance } from "react-native";

const backgroundColor = getColors({light: 'white', dark: '#242526'});
const foregroundColor = getColors({light: '#242526', dark: 'white'});

const colorScheme = Appearance.getColorScheme();
// console.log('colorScheme', colorScheme, backgroundColor, foregroundColor);
export default {
    backgroundColor,
    foregroundColor,
};
