import React from 'react';
import { Alert, Image, Platform, Pressable, View } from "react-native";
import {Button, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {styles} from './styles';
import CloseButton from '../../../components/CloseButton';
import {
    openSettings,
    PERMISSIONS,
    request,
    RESULTS,
} from 'react-native-permissions';
import Instructions3 from '../Instructions3';

const illustration = require('./Camera.png');

interface Props {}

const CameraPermissionsDenied: NavigationFunctionComponent<Props> = ({componentId}) => {
    return (
        <View style={styles.container}>
            <View style={styles.imageContainer}>
                <Image source={illustration} style={styles.image} />
            </View>
            <View>
                <Text
                    style={styles.mainText}
                    numberOfLines={3}
                    adjustsFontSizeToFit={true}>
                    Camera access is needed to start an HRV measurement
                </Text>
                <View style={styles.textWrapper}>
                    <Text
                        style={styles.secondaryText}
                        numberOfLines={3}
                        adjustsFontSizeToFit={true}>
                        Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.
                    </Text>
                </View>
            </View>
            <Button
                title="Enable camera"
                onPress={async () => {
                    await requestCameraPermission(componentId);
                }}
            />
            <Pressable
                style={styles.close}
                onPress={() => {
                    Navigation.pop(componentId);
                }}>
                <CloseButton.component />
            </Pressable>
        </View>
    );
};

const requestCameraPermission = async (componentId: string) => {
    const result = await request(
        Platform.select({
            ios: PERMISSIONS.IOS.CAMERA,
            default: PERMISSIONS.ANDROID.CAMERA,
        }),
    );

    if (result === RESULTS.GRANTED) {
        Navigation.push(componentId, {
            component: {
                name: Instructions3.componentName,
            },
        });
    } else {
        Alert.alert(
            'Enable camera in app settings',
            'To take a reading, please turn camera on in app setting',
            [
                {
                    text: 'Never Mind',
                    onPress: () => {},
                    style: 'cancel',
                },
                {
                    text: 'OK',
                    onPress: openSettings,
                },
            ],
            {cancelable: false},
        );
    }
};

CameraPermissionsDenied.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.CameraPermissionsDenied';
export default {
    componentName,
    component: CameraPermissionsDenied,
};

Navigation.registerComponent(componentName, () => CameraPermissionsDenied);
