# Spren Bridge

<a href="https://www.npmjs.org/package/@spren/react-native">
  <img src="https://img.shields.io/npm/v/@spren/react-native?color=brightgreen&label=npm%20package" alt="Current npm package version." />
</a>

# Requirements
|                | iOS     | Android     |
|----------------|---------|---------|
| **Support**    | iOS 14+| API 28+|


## Features

* Records biological activity data.

## Installation

```
npm install @spren/react-native --save
```

### iOS

Add one row to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Camera Usage Description` and a usage description.

If editing `Info.plist` as text, add:

```xml
<key>NSCameraUsageDescription</key>
<string>To measure your heart rate in order to provide you valuable insights.</string>
```

### API
```typescript
import {SprenView} from '@spren/react-native';
const sprenRef = useRef<SprenView>();
return (
  <SprenView
    ref={sprenRef}
    onStateChange={(event: IStateChange) => {})
    onProgressUpdate={(event: IProgressChange) => {})
    onReadingDataReady={async (event: IReadingDataReady) => {})
  >{children}</SprenView>
)
```
| Method                     | Parameters              | Description                                                                               |
|----------------------------|-------------------|-------------------------------------------------------------------------------------------|
| `sprenRef.current?.getReadingData()`        | `string`          | Returns reading data information (needs to be called when reading is over)                                                                 |
| `sprenRef.current?.cancelReading()`           |  | Cancels the ongoing reading                                                 |
| `sprenRef.current?.captureStart()`                |              | Starts camera capture |
| `sprenRef.current?.captureStop()`          |             | Stops camera capture                                                      |
| `sprenRef.current?.setAutoStart(bool)` *iOS only*           | `true`,`false`          | Set reading auto start. `autoStart` by default is false. Set `autoStart` to `true` if you want reading to start automatically.                                                             |
| `sprenRef.current?.dropComplexity()` *iOS only*  |   | Lower camera resolution and/or frame rate when phone load gets too high                                                              |
| `sprenRef.current?.setTorchMode(string)` *iOS only*        | `"0"`,`"1"`,`"2"`          | Configure flash light mode. torchMode possible values are: `"0"` - The capture device torch is always off. `"1"` - The capture device torch is always on. `"2"` - The capture device continuously monitors light levels and uses the torch when necessary.                                                                 |
| `sprenRef.current?.captureLock()` *iOS only*    |          | Locks camera device configuration      |
| `sprenRef.current?.captureUnlock()` *iOS only*     |          | Unlocks camera device configuration      |
| `sprenRef.current?.turnFlashOn()` *Android only*     |          | Sets Flash On      |
| `sprenRef.current?.reset()` *Android only*     |          | Reset new reading to the beginning state      |

## Usage

For more elaborate usage example see [here](https://github.com/Elite-HRV/spren-vision-ios/tree/main/react-native/example).

For a quick entry point, checkout these files:
- [SprenView](https://github.com/Elite-HRV/spren-vision-ios/tree/main/react-native/example/src/components/SprenView/index.tsx)
- [Recording](https://github.com/Elite-HRV/spren-vision-ios/tree/main/react-native/example/src/stacks/measure/Recording/index.tsx)
