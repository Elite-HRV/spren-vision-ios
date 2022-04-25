import {StyleSheet} from 'react-native';
import {getHeightFontProportion} from '../../utils';

export const styles = StyleSheet.create({
    default: {
        fontSize: 20 * getHeightFontProportion(),
        fontFamily: 'Gilroy',
        fontWeight: '700',
        color: '#ffffff',
    },
});
