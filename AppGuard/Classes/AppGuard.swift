// The MIT License (MIT)
//
// Copyright (c) 2018 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation


/// UI display callbacks of the controllers
public protocol AppGuardUIDelegate: class {
  
  func guardControllerWillAppear(`for` context: AppGuardContextType)
  func guardControllerDidAppear(`for` context: AppGuardContextType)
  
  func guardControllerWillDisappear(`for` context: AppGuardContextType)
  func guardControllerDidDisappear(`for` context: AppGuardContextType)
}

/// Configure your custom controllers to display instead of default ones
public protocol AppGuardDataSource: class {
  func customUpdateController() -> AppGuardUpdateViewController
  func customChangelogController() -> AppGuardChangelogViewController
}

public final class AppGuard {
  
  /// The default 💂‍♀️ of your app
  public static let `default` = AppGuard()
  
  public var configuration = AppGuardConfiguration()
  
  public weak var uiDelegate: AppGuardUIDelegate?
  public weak var dataSource: AppGuardDataSource?
  
  public func prepare() {
    if (UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String)?.isEmpty == true || UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) == nil {
      AppGuardConfigurationKeysBinder.configureDefaultKeysBinding()
    }
    self.dataSource = self
  }
  
  public func updateConfig(from configurationData: [String: Any?]) {
    self.configuration.update(with: configurationData)
  }
  
  public func displayUpdateStatus() -> Bool {
    guard self.configuration.dialogTypeValue != .none else {
      return false
    }
    return true
  }
}

extension AppGuard: AppGuardDataSource {
  public func customUpdateController() -> AppGuardUpdateViewController {
    return AppGuardUpdateViewController()
  }
  
  public func customChangelogController() -> AppGuardChangelogViewController {
    return AppGuardChangelogViewController()
  }
}
