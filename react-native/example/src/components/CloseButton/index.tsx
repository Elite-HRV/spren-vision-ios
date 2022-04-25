import React from 'react';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import Close from './close';

const CloseButton: NavigationFunctionComponent = ({color}) => {
    return <Close color={color} />;
};

export const componentId = 'component.CloseButton.id';
export const componentName = 'component.CloseButton';

export default {
    componentName,
    component: CloseButton,
};

Navigation.registerComponent(componentName, () => CloseButton);
