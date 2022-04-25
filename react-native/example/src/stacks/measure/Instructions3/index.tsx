import React from 'react';
import {Image, Pressable, View} from 'react-native';
import {Button, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {styles} from './styles';
import CloseButton from '../../../components/CloseButton';
import Recording from '../Recording';

const illustration = require('./Instructions3.png');

interface Props {}

const Instructions3: NavigationFunctionComponent<Props> = ({componentId}) => {
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
                    Place your fingertip fully over the camera lens
                </Text>
                <View style={styles.textWrapper}>
                    <Text
                        style={styles.secondaryText}
                        numberOfLines={2}
                        adjustsFontSizeToFit={true}>
                        Hold your hand steady and apply light pressure with your finger.
                    </Text>
                </View>
            </View>
            <Button
                title="Start measurement"
                onPress={() => {
                    Navigation.push(componentId, {
                        component: {
                            name: Recording.componentName,
                        },
                    });
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

Instructions3.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Instructions3';
export default {
    componentName,
    component: Instructions3,
};

Navigation.registerComponent(componentName, () => Instructions3);
