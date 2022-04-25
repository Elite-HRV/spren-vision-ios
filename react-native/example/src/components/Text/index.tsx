import React from 'react';
import {Text as TextRN} from 'react-native';
import {colorsMain} from '../../utils';

interface IProps {
    children: any;
    onPress?: () => void;
    style?: any;
    nativeID?: string;
    uppercase?: boolean;
    numberOfLines?: number;
}
export const Text = ({children, style, ...rest}: IProps) => {
    return (
        <TextRN
            style={[
                {
                    color: colorsMain.foregroundColor,
                    fontFamily: 'Gilroy',
                },
                style,
            ]}
            {...rest}>
            {children}
        </TextRN>
    );
};
