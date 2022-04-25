import {LayoutStack} from 'react-native-navigation';
import Results from './Results';

export const id = 'result.stack.id';
const ResultStack = {
    id,
    children: [
        {
            component: {
                name: Results.componentName,
            },
        },
    ],
} as LayoutStack;

export default ResultStack;
