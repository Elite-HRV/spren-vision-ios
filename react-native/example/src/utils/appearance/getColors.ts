import {isDarkMode} from '../appearance';
import { DynamicColorIOS, DynamicColorIOSTuple } from "react-native";
import {isIOS} from '../platform';

export default (colors: DynamicColorIOSTuple) => {
    const isDark = isDarkMode;
    if (isIOS) {
        return DynamicColorIOS(colors);
    }
    return isDark ? colors.dark : colors.light;
};
