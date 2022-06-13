import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'spren-vision-ios' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using correctly in your android setup\n';

export type SprenProps = {
  style: ViewStyle;
  onStateChange: (event: IStateChange) => void;
  onPrereadingComplianceCheck: (event: IPrereadingComplianceCheck) => void;
  onProgressUpdate: (event: IProgressChange) => void;
  onReadingDataReady: (event: IReadingDataReady) => void;
};

const ComponentName = 'SprenView';

export const SprenView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<SprenProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

export type ReadingState = 'started' | 'finished' | 'cancelled' | 'error';
export interface IStateChange {
  nativeEvent: {
    state: ReadingState;
  }
}

export interface IProgressChange {
  nativeEvent: {
    progress: number;
  }
}

export interface IReadingDataReady {
  nativeEvent: {
    readingData: string;
  }
}

export type Compliance = 'frameDrop' | 'brightness' | 'lensCoverage' | 'exposure'
export type ComplianceAction = 'increase' | 'decrease'

export interface IPrereadingComplianceCheck {
  nativeEvent: {
    name: Compliance;
    compliant: boolean;
    action?: ComplianceAction;
  }
}
