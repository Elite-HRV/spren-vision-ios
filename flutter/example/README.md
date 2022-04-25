# Spren React Native Demo

> Demonstrates how to use the spren_flutter plugin in iOS/Android environments

> Requires a physical device for camera access

# Setup

* Install [flutter](https://docs.flutter.dev/get-started/install)

* Create `.env` from base example and fill all the keys
    ```
    cp .env.base .env
    ```
  
  This example is using [flutter_dotenv](https://pub.dev/packages/flutter_dotenv). So, adjust `.env` variables to your needs:
  
  | Variable                | Description          | Values                                                          |
  | ----------------------- | -------------------- | --------------------------------------------------------------- |
  | SPREN_API_URL         | API URL          | test, production urls      |
  | X_API_KEY             | API Key          | 36 chars string            |

* Run  
  ```
  flutter pub get
  ```

* Open this project in Android Studio and run it on physical device
  
### iOS

> Requires minimum deployment target set to iOS 14 or higher.


Add one row to the `Info.plist`:

* key `Privacy - Camera Usage Description` and add usage description.

  If editing `Info.plist` as text, add:

  ```xml
  <key>NSCameraUsageDescription</key>
  <string>To measure your heart rate in order to provide you valuable insights.</string>
  ```

* Open `SprenDemo.xcworkspace` in Xcode and change:
  - `Team`
  - `Bundle Identifier`
### Usage

For a quick entry point checkout this [file](https://github.com/Elite-HRV/spren-vision-ios/tree/main/flutter/example/lib/route/camera/camera.dart).
