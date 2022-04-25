import React from 'react';
import {Pressable, View} from 'react-native';
import {PoweredBy, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {styles} from './styles';
import KeepAwake from 'react-native-keep-awake';
import Home from '../../measure/Home';
import CloseButton from '../../../components/CloseButton';

interface Props {
    blob: string;
    error: boolean;
    hrvScore?: number;
    hr?: number;
}

const Results: NavigationFunctionComponent<Props> = ({
    componentId,
    error,
    hrvScore,
    hr,
}) => {
    KeepAwake.deactivate();

    return (
        <>
            <Pressable
                style={styles.close}
                onPress={() => {
                    Navigation.setStackRoot(componentId, {
                        component: {
                            name: Home.componentName,
                            passProps: {
                                error: true,
                            },
                        },
                    });
                }}>
                <CloseButton.component />
            </Pressable>
            <View style={styles.container}>
                <View style={styles.topContainer}>
                    <Text style={styles.title}>
                        {error ? 'Sorry...' : 'Congrats!'}
                    </Text>
                    <Text style={styles.text}>
                        {error
                            ? "We couldn't process the results for this reading, please try again."
                            : 'You just completed your first heart rate variability (HRV) reading'}
                    </Text>
                    {!error && (
                        <View style={styles.resultsContainer}>
                            <View style={styles.resultsItem}>
                                <Text style={styles.resultsNumber}>
                                    {Math.round(hrvScore)}
                                </Text>
                                <Text style={styles.resultsText}>HRV Score</Text>
                            </View>
                            <View style={styles.resultsItem}>
                                <Text style={styles.resultsNumber}>
                                    {Math.round(hr)}
                                </Text>
                                <Text style={styles.resultsText}>Heart Rate</Text>
                            </View>
                        </View>
                    )}
                </View>

                <PoweredBy opacity={0.5} />
            </View>
        </>
    );
};

Results.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Results';
export default {
    componentName,
    component: Results,
};

Navigation.registerComponent(componentName, () => Results);
