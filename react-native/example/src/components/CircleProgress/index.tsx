import React, {useState} from 'react';
import {View} from 'react-native';
import CircularProgress from 'react-native-circular-progress-indicator';
import {getHeightFontProportion} from '../../utils';
import Checkmark from './checkmark';
import {styles} from './styles';

interface IProps {
    percentage: number;
    activeStrokeColor: string;
    inActiveStrokeColor: string;
    radius: number;
    showProgressValue: boolean;
    checkMarkWidth?: number;
    checkMarkHeight?: number;
    checkMarkColor?: string;
    checkMarkStrokeWidth?: number;
}

export const CircleProgress = ({
    percentage,
    activeStrokeColor,
    inActiveStrokeColor,
    radius,
    showProgressValue,
    checkMarkWidth,
    checkMarkHeight,
    checkMarkColor,
    checkMarkStrokeWidth,
}: IProps) => {
    const [width, setWidth] = useState(0);
    const [checkSize, setCheckSize] = useState({width: 0, height: 0});
    return (
        <View
            onLayout={event => {
                setWidth(event.nativeEvent.layout.width);
            }}>
            <CircularProgress
                showProgressValue={
                    percentage != 100 && showProgressValue ? true : false
                }
                value={percentage}
                activeStrokeColor={activeStrokeColor}
                inActiveStrokeColor={inActiveStrokeColor}
                textStyle={styles.default}
                valueSuffix="%"
                radius={radius}
            />

            {percentage == 100 && width != 0 && (
                <View
                    onLayout={event => {
                        setCheckSize(event.nativeEvent.layout);
                    }}
                    style={{
                        position: 'absolute',
                        left: (width - checkSize.width) / 2,
                        top: (width - checkSize.height) / 2,
                    }}>
                    <Checkmark
                        width={checkMarkWidth}
                        height={checkMarkHeight}
                        color={checkMarkColor}
                        strokeWidth={checkMarkStrokeWidth}
                    />
                </View>
            )}
        </View>
    );
};
