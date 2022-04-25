import axios from 'axios';
import Config from 'react-native-config';

export default axios.create({
    baseURL: Config.SPREN_API_URL,
    timeout: 30000,
    headers: {
        'content-type': 'application/json',
        'X-API-KEY': Config.X_API_KEY,
    },
});
