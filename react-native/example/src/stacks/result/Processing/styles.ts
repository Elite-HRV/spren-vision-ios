import {StyleSheet} from 'react-native';
import {getHeightFontProportion} from '../../../utils';

export const styles = StyleSheet.create({
    container: {
        padding: 20 * getHeightFontProportion(),
        flex: 1,
        justifyContent: 'space-between',
        alignItems: 'center',
        marginTop: 95 * getHeightFontProportion(),
    },
    topContainer: {
        alignItems: 'center',
    },
    title: {
        fontSize: 28 * getHeightFontProportion(),
        fontWeight: '800',
    },
    text: {
        marginTop: 10 * getHeightFontProportion(),
        fontSize: 17 * getHeightFontProportion(),
        opacity: 0.7,
    },
    progress: {
        alignItems: 'center',
        marginTop: 70,
    },
    close: {
        position: 'absolute',
        right: 25,
        top: 40,
        zIndex: 2,
    },
});
