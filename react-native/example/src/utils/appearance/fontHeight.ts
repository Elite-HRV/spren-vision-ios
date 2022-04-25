import {Dimensions} from 'react-native';

export default () => {
    const prop = (Dimensions.get('window').height / 896) * 1.2;
    if (prop > 1) {
        return 1;
    } else {
        return prop;
    }
};
