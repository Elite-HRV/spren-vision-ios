import React from 'react';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {Text} from '../Text';
import {styles} from './styles';

interface Props {
    text: string;
}

const ProgressText: NavigationFunctionComponent<Props> = ({text}: Props) => {
    return <Text style={styles.text}>{text}</Text>;
};

export const componentId = 'component.ProgressText.id';
export const componentName = 'component.ProgressText';
export default {
    componentId,
    componentName,
    component: ProgressText,
};

Navigation.registerComponent(componentName, () => ProgressText);
