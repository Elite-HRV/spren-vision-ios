import React from 'react';
import {Image, Platform, Pressable, View} from 'react-native';
import {Button, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {styles} from './styles';
import CloseButton from '../../../components/CloseButton';
import {PERMISSIONS, request, RESULTS} from 'react-native-permissions';
import Instructions3 from '../Instructions3';
import CameraPermissionDenied from '../CameraPermissionDenied';

const illustration = require('./Instructions2.png');

interface Props {}

const Instructions2: NavigationFunctionComponent<Props> = ({componentId}) => {
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
                    Place your fingertip over the rear-facing camera lens
                </Text>
                <View style={styles.textWrapper}>
                    <Text
                        style={styles.secondaryText}
                        numberOfLines={4}
                        adjustsFontSizeToFit={true}>
                        For the most accurate reading, leave the flash on or
                        make sure you’re in a well lit area and can hold your
                        hand steady
                    </Text>
                </View>
            </View>
            <Button
                title="Next"
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
        Navigation.push(componentId, {
            component: {
                name: CameraPermissionDenied.componentName,
            },
        });
    }
};

Instructions2.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Instructions2';
export default {
    componentName,
    component: Instructions2,
};

Navigation.registerComponent(componentName, () => Instructions2);
