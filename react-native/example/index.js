import {Navigation} from 'react-native-navigation';
import {MeasurementStack, DevStack} from './src/stacks';
import {isDev} from './src/utils';
import * as Sentry from '@sentry/react-native';
import Config from 'react-native-config';

Sentry.init({
    integrations: [
        new Sentry.ReactNativeTracing({
            routingInstrumentation:
                new Sentry.ReactNativeNavigationInstrumentation(Navigation),
        }),
    ],
    dsn: Config.SENTRY_DSN,
});

Navigation.events().registerAppLaunchedListener(() => {
    Navigation.setRoot({
        root: {
            stack: isDev && !!DevStack.children ? DevStack : MeasurementStack,
        },
    });
});
