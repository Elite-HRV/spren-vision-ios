import React from 'react';
import {View} from 'react-native';
import {SprenLogo, Text} from '..';
import {styles} from './styles';

interface IProps {
    opacity: number;
}
export const PoweredBy = ({opacity}: IProps) => {
    return (
        <View style={{...styles.poweredBy, opacity: opacity}}>
            <Text style={styles.poweredByText}>Powered by</Text>
            <SprenLogo />
        </View>
    );
};
