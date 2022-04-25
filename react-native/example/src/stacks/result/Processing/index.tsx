import React, {useEffect, useState} from 'react';
import {Pressable, View} from 'react-native';
import {CircleProgress, PoweredBy, Text} from '../../../components';
import {Navigation, NavigationFunctionComponent} from 'react-native-navigation';
import {styles} from './styles';
import {getHeightFontProportion, log, sleep} from '../../../utils';
import Results from '../Results';
import API from '../../../services/api';
import Home from '../../measure/Home';
import {contextNames, logLevel} from '../../../utils/log/log';
import CloseButton from '../../../components/CloseButton';

interface Props {
    readingData: string;
}

const Processing: NavigationFunctionComponent<Props> = ({
    componentId,
    readingData,
}) => {
    const [percentage, setPercentage] = useState(0);
    const [text, setText] = useState('');

    useEffect(() => {
        setPercentage(30);
        setText('Analyzing autonomic nervous system...');
        setTimeout(() => {
            post();
        }, 1000);
    }, []);

    const post = async () => {
        try {
            const response = await API.post(
                '/submit/sdkData',
                {
                    user: 'd159d47f-7441-44fa-af41-50d7496b201c',
                    readingData: readingData,
                },
                {
                    onUploadProgress: event => {
                        let progress: number = Math.round(
                            (event.loaded * 100) / event.total,
                        );

                        if (progress == 100) {
                            setPercentage(60);
                            setText('Analyzing baseline trends...');
                        }
                    },
                },
            );

            if (response?.data?.guid) {
                get(response?.data?.guid);
            } else {
                console.warn('response', 'error');
                log(
                    'processing',
                    'response?.data?.guid === null',
                    contextNames.RESULT_CONTEXT_1,
                    response,
                    logLevel.Error,
                );
                goError();
            }
        } catch (e) {
            console.warn('post request error', e);
            log(
                'processing',
                String(e),
                contextNames.RESULT_CONTEXT_1,
                {
                    warn: 'post request error',
                    readingData,
                },
                logLevel.Error,
            );
            goError();
        }
    };

    const goError = () => {
        Navigation.push(componentId, {
            component: {
                name: Results.componentName,
                passProps: {
                    error: true,
                },
            },
        });
    };

    const get = async (guid: string) => {
        try {
            const response = await API.get('/results/' + guid);

            if (response.data.biomarkers.hr.status === 'complete') {
                setPercentage(100);
                setText('Complete!');
                await sleep(1000);
                Navigation.push(componentId, {
                    component: {
                        name: Results.componentName,
                        passProps: {
                            error: false,
                            hrvScore: response.data.biomarkers.hrvScore.value,
                            hr: response.data.biomarkers.hr.value,
                        },
                    },
                });
            }

            if (response.data.biomarkers.hr.status === 'error') {
                log(
                    'processing',
                    'response.data.biomarkers.hr.status === error',
                    contextNames.RESULT_CONTEXT_1,
                    response,
                    logLevel.Error,
                );
                goError();
            }

            if (response.data.biomarkers.hr.status === 'pending') {
                setPercentage(80);
                setText('Generating personalized insights...');

                setTimeout(() => {
                    get(guid);
                }, 2000);
            }
        } catch (e) {
            console.warn('get request error', e);
            log(
                'processing',
                String(e),
                contextNames.RESULT_CONTEXT_1,
                {
                    warn: 'get request error',
                    readingData,
                },
                logLevel.Error,
            );
            goError();
        }
    };

    return (
        <>
            <Pressable
                style={styles.close}
                onPress={() => {
                    Navigation.setStackRoot(componentId, {
                        component: {
                            name: Home.componentName,
                            passProps: {
                                error: true,
                            },
                        },
                    });
                }}>
                <CloseButton.component />
            </Pressable>
            <View style={styles.container}>
                <View style={styles.topContainer}>
                    <Text style={styles.title}>Calculating your results</Text>
                    <Text style={styles.text}>{text}</Text>
                    <View style={styles.progress}>
                        <CircleProgress
                            percentage={percentage}
                            activeStrokeColor="#E55775"
                            inActiveStrokeColor="#EFF2F5"
                            radius={80 * getHeightFontProportion()}
                            showProgressValue={false}
                            checkMarkWidth={80}
                            checkMarkHeight={48}
                            checkMarkColor="#191A32"
                            checkMarkStrokeWidth={4}
                        />
                    </View>
                </View>

                <PoweredBy opacity={0.5} />
            </View>
        </>
    );
};

Processing.options = {
    topBar: {
        visible: false,
    },
    layout: {
        orientation: ['portrait'],
    },
};

export const componentName = 'screen.Processing';
export default {
    componentName,
    component: Processing,
};

Navigation.registerComponent(componentName, () => Processing);
