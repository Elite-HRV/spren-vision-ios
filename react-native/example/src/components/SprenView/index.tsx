import React, { RefObject } from "react";
import {
    SprenProps,
    SprenView as SprenViewBridge,
} from '@spren/react-native';
import {findNodeHandle} from 'react-native';
import {callNativeMethod} from '../../utils';

interface IProps extends SprenProps {
    children: any;
    ref?: RefObject<SprenView>;
}

export class SprenView extends React.Component<IProps, {}> {
    cancelReading = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'cancelReading');
    };
    setAutoStart = (autoStart: boolean) => {
        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'setAutoStart',
            autoStart,
        );
    };
    getReadingData = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'getReadingData');
    };
    captureStart = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureStart');
    };
    captureStop = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureStop');
    };
    captureLock = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureLock');
    };
    captureUnlock = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureUnlock');
    };
    dropComplexity = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'dropComplexity');
    };
    handleOverExposure = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'handleOverExposure');
    };
    setTorchMode = (torchMode: string) => {
        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'setTorchMode',
            torchMode,
        );
    };

    render() {
        const {style, children, ...rest} = this.props;

        return (
            <SprenViewBridge style={[style]} {...rest}>
                {children}
            </SprenViewBridge>
        );
    }
}
