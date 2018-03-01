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

public final class AppGuardConfiguration {
  
  public internal(set) var deeplink: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.deeplink.userDefaultsKey)
    }
  }
  
  public internal(set) var dialogType: Int {
    get {
      return UserDefaults.standard.integer(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.dialogType.userDefaultsKey)
    }
  }
  
  public var dialogTypeValue: AppGuardContextType {
    return AppGuardContextType(rawValue: self.dialogType) ?? .none
  }
  
  public internal(set) var content: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.content.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.content.userDefaultsKey)
    }
  }
  
  public internal(set) var actionButtonLabel: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsKey)
    }
  }
  
  public internal(set) var changelogContent: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsKey)
    }
  }
  
  public internal(set) var title: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.title.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.title.userDefaultsKey)
    }
  }
  
  public internal(set) var imageUrl: String? {
    get {
      return UserDefaults.standard.string(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsKey)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsKey)
    }
  }
  
  func update(with data: [String: Any?]) {
    AppGuardConfigurationKeys.allKeys.forEach { (stringKey) in
      if let parseKey = UserDefaults.standard.string(forKey: stringKey.userDefaultsCustomKey) {
        UserDefaults.standard.set(data[parseKey] as Any, forKey: stringKey.userDefaultsKey)
      }
    }
  }
  
}
