import React from 'react';
import Svg, {Path} from 'react-native-svg';
import { colorsMain, isIOS } from "../../utils";
import {Appearance} from 'react-native';
const colorScheme = Appearance.getColorScheme();

const Close = ({color, width = 44, height = 44}) => {
    const c = isIOS
        ? color?.['dynamic'][colorScheme] || colorsMain.foregroundColor['dynamic'][colorScheme]
        : color || colorsMain.foregroundColor;
    return (
        <Svg
            width={`${width}px`}
            height={`${height}px`}
            fill="none"
            viewBox={`0 0 ${width} ${height}`}>
            <Path
                d="M13 13L31 31"
                stroke={c}
                strokeWidth="3"
                strokeLinecap="round"
            />
            <Path
                d="M13 31L31 13"
                stroke={c}
                strokeWidth="3"
                strokeLinecap="round"
            />
        </Svg>
    );
};
export default Close;
