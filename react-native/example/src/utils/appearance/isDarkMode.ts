import {Appearance} from 'react-native';
const colorScheme = Appearance.getColorScheme();
const isDarkMode = colorScheme === 'dark';

export default isDarkMode;
