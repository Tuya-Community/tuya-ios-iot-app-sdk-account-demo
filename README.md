# Tuya iOS IoT App SDK Sample for Objective-C （User Module）[![](https://img.shields.io/badge/build-passing-green)](https://github.com/Tuya-Community/tuya-ios-iot-app-sdk-account-demo)[![](https://img.shields.io/badge/language-Objective--C-blue)](https://github.com/Tuya-Community/tuya-ios-iot-app-sdk-account-demo)



Tuya iOS IoT App SDK is divided into several function groups to give developers a clear insight into the implementation for different features, including the user registration process, home management for different users, device network configuration, and controls. For device network configuration, the EZ mode and AP mode are implemented. This allows developers to pair devices over Wi-Fi and control the devices over LAN and MQTT. For device control, a common panel is used to send and receive any type of data points.

This sample demonstrates the use of Tuya iOS IoT App SDK to  login and register by your phone or email . You could manage your information after  login, like reset the password or change the nick name .

## Prerequisites

- Xcode 12.0 and later
- iOS 9.0 and later

## Get started

1. The Tuya IoT App SDK for iOS is distributed through [CocoaPods](http://cocoapods.org/) and other dependencies in this sample. Make sure that you have installed CocoaPods. If not, run the following command to install CocoaPods first:

   ```
   sudo gem install cocoapods
   pod setup
   ```

2. Clone or download this sample, change the directory to the one that includes **Podfile**, and then run the following command:

   ```
   pod install
   ```

3. Get a pair of keys and a security image from the [Tuya IoT Platform](https://iot.tuya.com/?_source=github), and register a developer account if you don't have one. Then, perform the following steps:

   1. Log in to the [Tuya IoT Platform](https://iot.tuya.com/?_source=github). In the left-side navigation pane, choose **App** > **SDK Development**.
   2. Click **Create** to create an app.
   3. Fill in the required information. Make sure that you enter the valid package name. It cannot be changed afterward.
   4. Click the created app, and you will find the AppKey, AppSecret, and security image under the **Get Key** tag.

4. Open the `TuyaAppSDKSample-iOS-UserAccount-ObjC.xcworkspace` pod generated for you.

5. Fill in the AppKey and AppSecret in the **AppKey.h** file.

   ```
   #define APP_KEY @"<#AppKey#>"
   #define APP_SECRET_KEY @"<#SecretKey#>"
   ```

6. Download the security image, rename it to `t_s.bmp`, and then drag it to the workspace to be at the same level as `Info.plist`.

7. If you want to debug it on simulator (on Macbook with M1 chip), please add the following line on Pods project .

   <img width="1129" alt="截屏2021-05-24 下午2 21 53" src="https://user-images.githubusercontent.com/82919975/119305963-08978580-bc9c-11eb-9b3a-9034cad1ef88.png">


   **Note**: The package name, AppKey, AppSecret, and security image must be the same as your app on the [Tuya IoT Platform](https://iot.tuya.com/?_source=github). Otherwise, the sample cannot request the API.

## References

For more information, see [App SDK](https://developer.tuya.com/en/docs/app-development/integrate-sdk?id=Ka5d52ewngdoi).



## Support and Feedback 

You can get support from Tuya with the following methods:

 - Tuya Smart Help Center: https://support.tuya.com/en/help 
 - Technical Support Council: https://service.console.tuya.com 

We use [GitHub Issues](https://github.com/Tuya-Community/tuya-ios-iot-app-sdk-account-demo/issues) to track issues. If at all possible, please submit a reproduction of your bug along with your bug report.

