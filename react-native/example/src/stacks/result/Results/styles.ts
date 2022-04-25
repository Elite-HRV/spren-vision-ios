import {StyleSheet} from 'react-native';
import {getHeightFontProportion} from '../../../utils';

export const styles = StyleSheet.create({
    container: {
        padding: 20 * getHeightFontProportion(),
        flex: 1,
        justifyContent: 'space-between',
        alignItems: 'center',
        marginTop: 30 * getHeightFontProportion(),
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
        textAlign: 'center',
        fontWeight: '500',
        lineHeight: 21,
    },
    resultsContainer: {
        flexDirection: 'row',
        marginTop: 50 * getHeightFontProportion(),
        alignSelf: 'stretch',
        justifyContent: 'space-evenly',
    },
    resultsItem: {
        alignItems: 'center',
    },
    resultsNumber: {
        fontSize: 72,
        fontWeight: '500',
    },
    resultsText: {
        fontSize: 13,
        fontWeight: '600',
    },
    close: {
        position: 'absolute',
        right: 25,
        top: 40,
        zIndex: 2,
    },
});
