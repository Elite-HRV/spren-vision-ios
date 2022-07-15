import React, {useEffect, useRef, useState} from 'react';
import { Pressable, View, Modal, Platform, AppState } from "react-native";
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import KeepAwake from 'react-native-keep-awake';
import {
    PoweredBy,
    RecordingStatus,
    FlashIconOn,
    FlashIconOff,
    SprenView,
    Text,
    Button,
} from '../../../components';
import {styles} from './styles';
import {
    IStateChange,
    ReadingState,
    IPrereadingComplianceCheck,
    IProgressChange,
    IReadingDataReady,
} from '@spren/react-native';
import { getColors, isIOS, sleep } from "../../../utils";
import Processing from '../../result/Processing';
import CloseButton from '../../../components/CloseButton';
import Home from '../Home';

interface Props {}
type ReadingStateApp = ReadingState | 'preReading';


const Recording: NavigationFunctionComponent<Props> = ({componentId}) => {
    const appState = useRef(AppState.currentState);
    const [appStateVisible, setAppStateVisible] = useState(appState.current);

    const [droppedFrames, setDroppedFrames] = useState(0);
    const [brightness, setBrightness] = useState(0);
    const [lensCovered, setLensCovered] = useState(0);
    const [exposure, setExposure] = useState(0);
    const [flash, setFlash] = useState('0');
    const [readingStatus, setReadingStatus] =
        useState<ReadingStateApp>('preReading');
    const [percentage, setPercentage] = useState(0);
    const [modalVisible, setModalVisible] = useState(false);
    const [text, setText] = useState(
        'Place your fingertip over the rear-facing camera lens.',
    );
    const sprenRef = useRef<SprenView>();
    KeepAwake.activate();

    useEffect(() => {
        const subscription = AppState.addEventListener(
            'change',
            nextAppState => {
                if (nextAppState.match(/inactive|background/)) {
                    cancelReading(true);
                }

                appState.current = nextAppState;
                setAppStateVisible(appState.current);
            },
        );

        return () => {
            cancelReading();
            subscription.remove();
        };
    }, []);

    useEffect(() => {
        setTorchMode(flash);
    }, [flash]);

    useEffect(() => {
        if (!isIOS) {
            return;
        }
        if (droppedFrames == 2) {
            sprenRef.current?.dropComplexity();
            setTorchMode(flash);
            setDroppedFrames(0);
        }
    }, [droppedFrames]);

    useEffect(() => {

    }, [exposure]);

    useEffect(() => {
        if (lensCovered == 5 && readingStatus != 'started') {
            setModalVisible(true);
        }
    }, [lensCovered]);

    useEffect(() => {
        (async () => {
            if (sprenRef.current) {
                await sleep(1000);
                setFlash('1');
                reset();
            }
        })();
    }, [sprenRef.current]);

    useEffect(() => {
        switch (readingStatus) {
            case 'started':
                break;
            case 'finished':
                setPercentage(100);
                sprenRef.current?.getReadingData();
                break;
            case 'error':
                setModalVisible(true);
                break;
        }
    }, [readingStatus]);

    const setTorchMode = (mode: string) => {
        switch (Platform.OS) {
            case 'android':
                sprenRef.current?.turnFlashOn();
                break;
            case 'ios':
                sprenRef.current?.setTorchMode(mode);
                break;
        }
    };

    const reset = () => {
        setReadingStatus('preReading');
        setPercentage(0);
        setBrightness(0);
        setExposure(0);
        setDroppedFrames(0);

        switch (Platform.OS) {
            case 'android':
                sprenRef.current?.reset();
                break;
            case 'ios':
                sprenRef.current?.setAutoStart(true);
                break;
        }
    };

    const cancelReading = (pop = false) => {
        sprenRef.current?.cancelReading();
        if (pop) {
            Navigation.setStackRoot(componentId, {
                component: {
                    name: Home.componentName,
                },
            });
        }
    };

    return (
        <View style={styles.container}>
            <SprenView
                ref={sprenRef}
                onStateChange={(event: IStateChange) => {
                    console.log('onStateChange');
                    console.log(event.nativeEvent.state);
                    setReadingStatus(event.nativeEvent.state);
                }}
                onPrereadingComplianceCheck={(
                    event: IPrereadingComplianceCheck,
                ) => {
                    if (
                        event.nativeEvent.name === 'frameDrop' &&
                        event.nativeEvent.compliant === false
                    ) {
                        setDroppedFrames(droppedFrames + 1);
                    }

                    if (
                        event.nativeEvent.name === 'brightness' &&
                        event.nativeEvent.compliant === false
                    ) {
                        setBrightness(brightness + 1);
                    }

                    if (
                        event.nativeEvent.name === 'lensCoverage' &&
                        event.nativeEvent.compliant === false
                    ) {
                        setLensCovered(lensCovered + 1);
                    }
                    if (
                        event.nativeEvent.name === 'exposure' &&
                        event.nativeEvent.compliant === false
                    ) {
                        setExposure(exposure + 1);
                    }
                }}
                onProgressUpdate={(event: IProgressChange) => {
                    setPercentage(event.nativeEvent.progress);
                    switch (event.nativeEvent.progress) {
                        case 0:
                            setText(
                                'Place your fingertip over the rear-facing camera lens.',
                            );
                            break;
                        case 1:
                            setText(
                                'Detecting your pulse. Keep your hand still and apply gentle pressure...',
                            );
                            break;
                        case 15:
                            setText(
                                'Measuring your heart rate. Please relax and hold still...',
                            );
                            break;
                        case 30:
                            setText(
                                'Detecting the imperceptible patterns in your heart beats...',
                            );
                            break;
                        case 50:
                            setText(
                                'Scanning your nervous system. Please hold still...',
                            );
                            break;
                        case 70:
                            setText('Extracting your respiration patterns...');
                            break;
                        case 85:
                            setText('Almost there...');
                            break;
                        case 100:
                            setText('Measurement complete!');
                        default:
                            break;
                    }
                }}
                onReadingDataReady={async (event: IReadingDataReady) => {
                    Navigation.setStackRoot(componentId, {
                        component: {
                            name: Processing.componentName,
                            passProps: {
                                readingData: event.nativeEvent.readingData,
                            },
                        },
                    });

                    setFlash('0');
                }}
                style={styles.sprenView}>
                <View style={styles.sprenViewContainer}>
                    <RecordingStatus percentage={percentage} text={text} />

                    <View>
                        {isIOS && readingStatus != 'started' && (
                            <Pressable
                                onPress={() => {
                                    setFlash(flash === '1' ? '0' : '1');
                                }}
                                style={styles.flashButton}>
                                {flash === '1' ? (
                                    <FlashIconOn />
                                ) : (
                                    <FlashIconOff />
                                )}
                            </Pressable>
                        )}
                        <PoweredBy opacity={0.7} />
                    </View>

                    <Pressable
                        style={styles.close}
                        onPress={() => {
                            cancelReading(true);
                        }}>
                        <CloseButton.component
                            color={getColors({light: 'white', dark: 'white'})}
                        />
                    </Pressable>
                </View>
            </SprenView>
            <Modal
                animationType="slide"
                transparent={true}
                visible={modalVisible}
                onRequestClose={() => {
                    setModalVisible(!modalVisible);
                }}>
                <View style={styles.centeredView}>
                    <View style={styles.modalView}>
                        <Text style={styles.modalTitle}>
                            Reading stopped, please try again
                        </Text>
                        <Text style={styles.modalText}>
                            Please make sure your finger fully covers the camera
                            camera lens throughout the entire measurement
                        </Text>
                        <Button
                            title="Try again"
                            style={styles.tryButton}
                            onPress={() => {
                                setModalVisible(false);
                                reset();
                            }}
                        />
                    </View>
                </View>
            </Modal>
        </View>
    );
};

Recording.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Recording';
export default {
    componentName,
    component: Recording,
};

Navigation.registerComponent(componentName, () => Recording);
