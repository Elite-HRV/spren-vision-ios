import React from 'react';
import {Image} from 'react-native';
import { Navigation, NavigationFunctionComponent } from "react-native-navigation";

const progress1 = require('./progress-1.png');
const progress2 = require('./progress-2.png');
const progress3 = require('./progress-3.png');

interface Props {
    step: number;
}

const ProgressBar: NavigationFunctionComponent<Props> = ({step}: Props) => {
    const progress = [progress1, progress2, progress3];
    return <Image source={progress[step - 1]} />;
};

export const componentName = 'component.ProgressBar';

export default {
    componentName,
    component: ProgressBar,
};

Navigation.registerComponent(componentName, () => ProgressBar);
