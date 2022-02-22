import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'spren-ios-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type SprenProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'SprenView';

export const SprenView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<SprenProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
