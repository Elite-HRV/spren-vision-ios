# Spren React Native Demo

> The React Native, cross-platform iOS/Android Spren Demo app

> Requires a physical device for camera access

# Table of Contents

* [Requirements](#requirements)
* [Setup](#setup)
    * [Env Config](#env-config)
    * [iOS](#iOS)
    * [Android](#Android)
* [Usage](#Usage)

# Requirements
|                | iOS     | Android     |
|----------------|---------|---------|
| **Support**    | iOS 14+*| API 21+|

* Recommended IDEs
    * Webstorm
    * Xcode
    * Android Studio
    * Visual Studio Code
* nvm, Node.js 12/14 LTS, npm, npx
* yarn
* react-native-cli
* CocoaPods

# Setup

1. Install [nvm](https://github.com/nvm-sh/nvm)
    ```
    brew update
    brew install nvm
    ```

2. Install and use [Node.js](https://github.com/nodejs/node) 12/14 LTS
    ```
    nvm install 12 --lts
    ```

3. Install [yarn](https://github.com/yarnpkg/yarn) and install packages
    ```
    npm install --global yarn
    yarn install
    ```

4. Install CocoaPods
   ```
   sudo gem install cocoapods
   cd ios && pod install
   ```

5. Create `.env` from base example and fill all the keys
    ```
    cp .env.base .env
    ```

### Env Config

This example is using [react-native-config](https://github.com/luggit/react-native-config). So, adjust `.env` variables to your needs:

| Variable                | Description          | Values                                                          |
| ----------------------- | -------------------- | --------------------------------------------------------------- |
| SPREN_API_URL         | API URL          | test, production urls      |
| X_API_KEY             | API Key          | 36 chars string            |

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

* Run the app
    ```
    npx react-native run-ios
    ```

### Android

1. Run the app
    ```
    npx react-native run-android
    ```

## Usage

For a quick entry point, checkout these files:
- [SprenView](https://github.com/Elite-HRV/spren-vision-ios/tree/main/react-native/example/src/components/SprenView/index.tsx)
- [Recording](https://github.com/Elite-HRV/spren-vision-ios/tree/main/react-native/example/src/stacks/measure/Recording/index.tsx)
