import React, { RefObject } from 'react';
import {
    SprenProps,
    SprenView as SprenViewBridge,
} from '@spren/react-native';
import {findNodeHandle} from 'react-native';
import { callNativeMethod, isIOS, isAndroid } from '../../utils';

interface IProps extends SprenProps {
    children: any;
    ref?: RefObject<SprenView>;
}

export class SprenView extends React.Component<IProps, {}> {

    /**
     * Cancels the ongoing reading
     */
    cancelReading = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'cancelReading');
    };

    /**
     * Set reading auto start. autoStart by default is false
     * Set autoStart to true if you want reading to start automatically.
     *
     * @param autoStart
     */
    setAutoStart = (autoStart: boolean) => {
        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'setAutoStart',
            autoStart,
        );
    };

    /**
     * Returns reading data information (needs to be called when reading is over)
     */
    getReadingData = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'getReadingData');
    };

    /**
     * Starts camera capture
     */
    captureStart = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureStart');
    };

    /**
     * Stops camera capture
     */
    captureStop = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureStop');
    };

    /**
     * Locks camera device configuration
     *
     * iOS only
     */
    captureLock = () => {
        if (!isIOS) {
            throw new Error('Platform not supported');
        }
        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureLock');
    };

    /**
     * Unlocks camera device configuration
     *
     * iOS only
     */
    captureUnlock = () => {
        if (!isIOS) {
            throw new Error('Platform not supported');
        }

        callNativeMethod(findNodeHandle(this), 'SprenView', 'captureUnlock');
    };

    /**
     * Lower camera resolution and/or frame rate when phone load gets too high
     *
     * iOS only
     */
    dropComplexity = () => {
        if (!isIOS) {
            throw new Error('Platform not supported');
        }

        callNativeMethod(findNodeHandle(this), 'SprenView', 'dropComplexity');
    };

    /**
     * Handles camera over exposure
     *
     * iOS only
     */
    handleOverExposure = () => {
        if (!isIOS) {
            throw new Error('Platform not supported');
        }
        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'handleOverExposure',
        );
    };

    /**
     * Sets Flash On
     *
     * Android only
     */
    turnFlashOn = () => {
        if (!isAndroid) {
            throw new Error('Platform not supported');
        }
        callNativeMethod(findNodeHandle(this), 'SprenView', 'turnFlashOn');
    };

    /**
     * Reset new reading to the beginning
     *
     * Android only
     */
    reset = () => {
        if (!isAndroid) {
            throw new Error('Platform not supported');
        }
        callNativeMethod(findNodeHandle(this), 'SprenView', 'reset');
    };

    /**
     * Configure flash light mode. torchMode possible values are:
     * @param torchMode
     *   0 - The capture device torch is always off.
     *   1 - The capture device torch is always on.
     *   2 - The capture device continuously monitors light levels and uses the torch when necessary.
     *
     *   iOS only
     */
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
