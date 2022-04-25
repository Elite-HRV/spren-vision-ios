import {StyleSheet} from 'react-native';
import { colorsMain, getColors } from "../../utils";

export const styles = StyleSheet.create({
    button: {
        alignItems: 'center',
        justifyContent: 'center',
        paddingVertical: 15,
        paddingHorizontal: 32,
        borderRadius: 6,
        elevation: 3,
        backgroundColor: 'rgba(82, 70, 168, 1)',
    },
    text: {
        fontFamily: 'Gilroy',
        fontSize: 18,
        lineHeight: 21,
        fontWeight: '700',
        letterSpacing: 0.25,
        color: 'white',
    },
});
