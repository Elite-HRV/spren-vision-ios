import React from "react";
import { Image, View } from "react-native";
import { Button, PoweredBy, ProgressBar, ProgressText, SprenLogo, Text } from "../../../components";
import { Navigation, NavigationFunctionComponent, OptionsModalTransitionStyle } from "react-native-navigation";
import Instructions1 from "../Instructions1";
import { styles } from "./styles";

const illustration = require('./home.png');

interface Props {}

const Home: NavigationFunctionComponent<Props> = ({
    componentId,
}) => {
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
