import React from "react";
import { Text, View } from "react-native";
import { getHeightFontProportion } from "../../utils";
import { CircleProgress } from "../CircleProgress";
import { styles } from "./styles";

interface IProps {
    percentage: number;
    text: string;
}

export const RecordingStatus = ({ percentage, text }: IProps) => {
    return (
        <View style={styles.container}>
            <CircleProgress
                percentage={percentage}
                activeStrokeColor="#92D15F"
                inActiveStrokeColor="#181919"
                radius={45 * getHeightFontProportion()}
                showProgressValue={true}
            />
            <Text adjustsFontSizeToFit={true} numberOfLines={3} style={styles.text}>{text}</Text>
        </View>
    );
};
