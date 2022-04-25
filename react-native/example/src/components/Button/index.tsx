import React from 'react';
import {Text} from '../';
import {styles} from './styles';
import {Pressable} from 'react-native';

interface IProps {
    title: string;
    onPress?: () => void;
    style?: any;
    styleText?: any;
}
export const Button = ({style, styleText, title, ...rest}: IProps) => {
    return (
        <Pressable style={[styles.button, style]} {...rest}>
            <Text
                style={[styles.text, styleText]}
                numberOfLines={1}
                adjustsFontSizeToFit={true}>
                {title}
            </Text>
        </Pressable>
    );
};
