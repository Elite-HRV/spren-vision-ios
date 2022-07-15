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
     * Returns reading data information (needs to be called when reading is over)
     */
    getReadingData = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'getReadingData');
    };

    /**
     * Cancels the ongoing reading
     */
    cancelReading = () => {
        callNativeMethod(findNodeHandle(this), 'SprenView', 'cancelReading');
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
     * Set reading auto start. autoStart by default is false
     * Set autoStart to true if you want reading to start automatically.
     *
     * @param autoStart
     *
     * iOS only
     */
    setAutoStart = (autoStart: boolean) => {
        if (!isIOS) {
            throw new Error('Platform not supported');
        }

        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'setAutoStart',
            autoStart,
        );
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
        if (!isIOS) {
            throw new Error('Platform not supported');
        }

        callNativeMethod(
            findNodeHandle(this),
            'SprenView',
            'setTorchMode',
            torchMode,
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

    render() {
        const {style, children, ...rest} = this.props;

        return (
            <SprenViewBridge style={[style]} {...rest}>
                {children}
            </SprenViewBridge>
        );
    }
}
