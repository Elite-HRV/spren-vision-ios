import React from 'react';
import Svg, {Path} from 'react-native-svg';

const Checkmark = ({
    width = 26,
    height = 18,
    color = '#FFFFFF',
    strokeWidth = 5,
}) => (
    <Svg
        width={`${width}px`}
        height={`${height}px`}
        fill="none"
        viewBox={`0 0 26 18`}>
        <Path
            d="M3 7.60274L10.6271 15L23 3"
            stroke={color}
            strokeWidth={strokeWidth}
            strokeLinecap="round"
            strokeLinejoin="round"
        />
    </Svg>
);

export default Checkmark;
