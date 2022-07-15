import React, { useEffect, useState } from 'react';
import { Image, View } from "react-native";
import { Button, PoweredBy, ProgressBar, ProgressText, SprenLogo, Text } from "../../../components";
import { Navigation, NavigationFunctionComponent, OptionsModalTransitionStyle } from "react-native-navigation";
import Instructions1 from "../Instructions1";
import { styles } from "./styles";
import { getApiLevel } from 'react-native-device-info';
import { isAndroid, isIOS } from '../../../utils';
import CircularProgress from 'react-native-circular-progress-indicator';

const illustration = require('./home.png');
const ANDROID_MIN_SUPPORTED_SDK = 28;

interface Props {}

const Home: NavigationFunctionComponent<Props> = ({
    componentId,
}) => {
    const [deviceEligible, setDeviceEligible] = useState<boolean | null>(null);

    const isDeviceEligible = async (): Promise<boolean> => {
        if (isIOS) {
            return Promise.resolve(true);
        } else if (isAndroid) {
            const apiLevel = await getApiLevel();

            return apiLevel >= ANDROID_MIN_SUPPORTED_SDK;
        } else {
            return Promise.resolve(false);
        }
    };

    useEffect(() => {
        (async () => {
            const isEligible = await isDeviceEligible();
            setDeviceEligible(isEligible);
        })();
    }, []);

    if (deviceEligible === true) {
        return (
            <View style={styles.container}>
                <View style={styles.imageContainer}>
                    <Image source={illustration} style={styles.image} />
                </View>
                <View>
                    <Text style={styles.mainText} numberOfLines={3} adjustsFontSizeToFit={true}>
                        Unlock advanced HRV insights with your smartphone camera
                    </Text>
                    <View style={styles.textWrapper}>
                        <Text style={styles.secondaryText} numberOfLines={3} adjustsFontSizeToFit={true}>{`\u2022 Integrate via SDK and API
    \u2022 Customizable look and feel
    \u2022 Validated algorithms`}
                        </Text>
                    </View>
                </View>
                <Button
                    title="Try it now"
                    onPress={() => {
                        Navigation.push(componentId, {
                            component: {
                                name: Instructions1.componentName,
                            },
                        });
                    }}
                />
            </View>
        );
    } else if (deviceEligible === false) {
        return (
            <View style={styles.container}>
                <View style={styles.imageContainer}>
                    <Image source={illustration} style={styles.image} />
                </View>
                <View>
                    <Text style={styles.mainText} numberOfLines={3} adjustsFontSizeToFit={true}>
                        Unfortunately we do not support Android 8 or lower.
                    </Text>
                </View>
            </View>
        );
    } else {
        return <CircularProgress value={58} />;
    }
};
Home.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Home';
export default {
    componentName,
    component: Home,
};

Navigation.registerComponent(componentName, () => Home);
