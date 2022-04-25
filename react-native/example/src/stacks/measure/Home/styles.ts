import {StyleSheet} from 'react-native';

export const styles = StyleSheet.create({
    container: {
        padding: 20,
        flex: 1,
        justifyContent: 'space-between',
    },
    mainText: {
        fontSize: 28,
        lineHeight: 38,
        fontWeight: '900',
        textAlign: 'center',
    },
    textWrapper: {
        alignSelf: 'center',
    },
    secondaryText: {
        marginTop: 10,
        fontSize: 17,
        lineHeight: 23,
        fontWeight: '500',
    },
    imageContainer: {
        flex: 0.8,
    },
    image: {
        resizeMode: 'contain',
        flex: 1,
    },
});
