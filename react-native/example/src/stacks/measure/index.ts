import {LayoutStack} from 'react-native-navigation';
import Home from './Home';

export const id = 'measurement.stack.id';
const MeasurementStack = {
    id,
    children: [
        {
            component: {
                name: Home.componentName,
            },
        },
    ],
} as LayoutStack;

export default MeasurementStack;
