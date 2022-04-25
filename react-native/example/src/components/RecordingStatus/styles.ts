import {StyleSheet} from 'react-native';
import {getHeightFontProportion} from '../../utils';

export const styles = StyleSheet.create({
    container: {
        padding: 24,
        backgroundColor: '#303133',
        borderRadius: 16,
        flexDirection: 'row',
        justifyContent: 'flex-start',
        alignItems: 'center',
    },
    text: {
        fontSize: 14 * getHeightFontProportion(),
        fontWeight: '700',
        color: '#FFFFFF',
        lineHeight: 24,
        flex: 1,
        marginLeft: 20,
    },
});
