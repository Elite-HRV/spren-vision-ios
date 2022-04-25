import {Dimensions, StyleSheet} from 'react-native';
const width = Dimensions.get('window').width;
const height = Dimensions.get('window').height;

export const styles = StyleSheet.create({
    container: {
        // flex: 1,
    },
    flashButton: {
        backgroundColor: '#303133',
        alignSelf: 'flex-end',
        paddingVertical: 11,
        paddingHorizontal: 14,
        borderRadius: 100,
    },
    sprenView: {
        width,
        height,
        zIndex: 100,
    },
    sprenViewContainer: {
        backgroundColor: 'transparent',
        padding: 20,
        paddingTop: 50,
        justifyContent: 'space-between',
        flex: 1,
    },
    centeredView: {
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 22,
    },
    modalView: {
        margin: 15,
        backgroundColor: 'white',
        borderRadius: 20,
        padding: 10,
        alignItems: 'center',
        shadowColor: '#000',
        shadowOffset: {
            width: 0,
            height: 2,
        },
        shadowOpacity: 0.25,
        shadowRadius: 4,
        elevation: 5,
    },
    modalTitle: {
        fontSize: 25,
        lineHeight: 30,
        color: '#000000',
        fontWeight: '600',
        paddingHorizontal: 15,
        paddingTop: 30,
        textAlign: 'center',
    },
    modalText: {
        fontSize: 17,
        lineHeight: 22,
        color: '#000000',
        textAlign: 'center',
        marginTop: 30,
        fontWeight: '500',
    },
    tryButton: {
        marginTop: 30,
        alignSelf: 'stretch',
        backgroundColor: 'purple',
        marginHorizontal: 5,
    },
    buttonText: {
        marginTop: 20,
        paddingHorizontal: 30,
        paddingVertical: 10,
        color: 'rgba(82, 70, 168, 1)',
        fontWeight: 'bold',
        alignSelf: 'center',
    },
    cancelButton: {
        marginTop: 30,
        alignSelf: 'stretch',
        marginHorizontal: 5,
        backgroundColor: 'transparent',
    },
    modalButtonsContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    close: {
        position: 'absolute',
        right: 25,
        top: 50,
        zIndex: 2,
    },
});
