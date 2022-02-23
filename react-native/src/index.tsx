import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';
import { IStateChange } from "./";
import { IPrereadingComplianceCheck, IProgressChange, IReadingDataReady } from "spren-ios-sdk";

const LINKING_ERROR =
  `The package 'spren-ios-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type SprenProps = {
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
