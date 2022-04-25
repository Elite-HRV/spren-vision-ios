import React from 'react';
import {Image, Pressable, View} from 'react-native';
import {Button, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import Instructions2 from '../Instructions2';
import {styles} from './styles';
import CloseButton from '../../../components/CloseButton';

const illustration = require('./Instructions1.png');

interface Props {}

const Instructions1: NavigationFunctionComponent<Props> = ({componentId}) => {
    return (
        <View style={styles.container}>
            <View style={styles.imageContainer}>
                <Image source={illustration} style={styles.image} />
            </View>
            <View>
                <Text
                    style={styles.mainText}
                    numberOfLines={2}
                    adjustsFontSizeToFit={true}>
                    Measure your HRV with your phone camera
                </Text>
                <View style={styles.textWrapper}>
                    <Text
                        style={styles.secondaryText}
                        numberOfLines={3}
                        adjustsFontSizeToFit={true}>
                        Simply do a quick resting scan when you wake up to
                        receive personalized stress and recovery insights.
                    </Text>
                </View>
            </View>
            <Button
                title="Next"
                onPress={() => {
                    Navigation.push(componentId, {
                        component: {
                            name: Instructions2.componentName,
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
Instructions1.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Instructions1';
export default {
    componentName,
    component: Instructions1,
};

Navigation.registerComponent(componentName, () => Instructions1);
