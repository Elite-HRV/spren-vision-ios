import {UIManager} from 'react-native';
import {isIOS} from './index';

const callNativeMethod = (
    node: null | number,
    component: string,
    command: string,
    args: any = null,
) => {
    UIManager.dispatchViewManagerCommand(
        node,
        isIOS
            ? UIManager.getViewManagerConfig(component).Commands[command]
            : command,
        !!args ? [args] : [],
    );
};

export default callNativeMethod;
