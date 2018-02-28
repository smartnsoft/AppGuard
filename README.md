# 💂‍♀️ AppGuard

[![CI Status](http://img.shields.io/travis/smartnsoft/AppGuard.svg?style=flat)](https://travis-ci.org/smartnsoft/AppGuard)
[![Version](https://img.shields.io/cocoapods/v/AppGuard.svg?style=flat)](http://cocoapods.org/pods/AppGuard)
[![License](https://img.shields.io/cocoapods/l/AppGuard.svg?style=flat)](http://cocoapods.org/pods/AppGuard)
[![Platform](https://img.shields.io/cocoapods/p/AppGuard.svg?style=flat)](http://cocoapods.org/pods/AppGuard)


AppGuard is a guard for your iOS app, to check / force users to update your app or show what changed.

<p align="center"><img width=32% src="./img/appguard_update_mandatory.png"> <img width=32% src="./img/appguard_update.png"> <img width=32% src="./img/appguard_changelog.png"></p>

## Requirements

- iOS 9.0+
- Swift 4+
- Xcode 9.2+

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

StarsKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AppGuard'
```

## Third party dependencies

Today we have third parties dependencies, but the purpose is to avoid them the most.

We also wan to have a quick available library and significant customization, we use 3 dependencies:

- [Extra/UIKit](https://github.com/smartnsoft/Extra): our library to simplify UIKit operation code
- [Jelly](https://github.com/SebastianBoldt/Jelly): a simple UI component to simplify the rating transition display

## Description

AppGuard offers three default behaviors for your app to:

1. Check and show to the user if a new version of your app **have to** be downloaded (**mandatory update**).
2. Check and show to the user if a new version of your app **should be** downloaded (**recommandated update**).
3. Show to the user **what's new** in the last version (**update informations**).

By a mecanism of revival displays, blocked or dimissable pop-up, the user will / may have to update your app according to the informations and actions displayed.

## Usage

### Update the configuration

AppGuard use a simple Dictionnary data to update its configuration.

``` swift
let configurationData // a [String: Any?] instance from JSON file or static dictionnary or anything else
AppGuard.default.updateConfig(from: configurationData)

AppGuard.default.checkUpdateStatus()

```

- ℹ️ You can optionnaly specify the keys binding with the `AppGuardConfigurationKeysBinder`, to bind your source configuration to the AppGuard configuration. By default, the `AppGuardConfigurationKeys` will be used.

Use the Firebase Podspec

```ruby
pod 'AppGuard/FirebaseRemoteConfig'
```

``` swift

AppGuardConfigurationKeysBinder.bindConfigurationKeys { keys in
	keys[GuardConfigurationKeys.title.rawValue] = "myKey_title_key"
}

```

### Use Firebase Remote Config

<p><img width=20% src="./img/firebase_config.png"/></p>

If your app already use Firebase, why not use the Firebase Remote Config feature?
AppGuard will be able to convert your associated Firebase remote configuration object to a readable data dictionnary for itself 👌.

``` swift

// Bind the properties keys if needed before 
// or use the default ones in the remote config

let remoteConfig = RemoteConfig.remoteConfig()
remoteConfig.fetch(withExpirationDuration: 1.second) { (status, _) in
    
	AppGuard.default.updateConfig(from: remoteConfig)
	AppGuard.default.checkUpdateStatus()
}

```

## Customization

### View controller customization

You directly have access to the `AppGuardUpdateViewController` and `AppGuardChangelogViewController` to sublcass them and use your own ones by return them in the `AppGuardDataSource`.

``` swift
extension MyFile: AppGuardDataSource {

	func guardUpdateCustomController() -> AppGuardUpdateViewController? {
		return MyCustomUpdateViewController()
	}
	
	func guardChangelogCustomController() -> AppGuardChangelogViewController? {
		return MyCustomUpdateViewController()
	}

}
```

You can also only override the `.xib` of default controllers.

### Strings customization

You can use the configurations strings or the Localizable ones, which you can override to in your app bundle.

## Contributors

Made in 🇫🇷 by the [Smart&Soft](https://smartnsoft.com/) iOS Team

- Jean-Charles Sorin - Smart&Soft

## License

AppGuard is available under the MIT license. See the LICENSE file for more info.