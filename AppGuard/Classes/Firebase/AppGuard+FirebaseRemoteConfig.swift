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
import FirebaseRemoteConfig

public extension AppGuard {
  
  /// Update your AppGuard configuration from a Firebase RemoteConfig.
  ///
  /// **Note**: It will use the configured (or default) keys binding for parsing.
  ///
  /// - Parameter config: Your desired Firebase Remote Config
  func updateFrom(remoteConfig config: RemoteConfig) {
    AppGuardConfigurationKeys.allStringKeys.forEach { (stringKey) in
      if let parseKey = UserDefaults.standard.string(forKey: stringKey.userDefaultsCustomKey) {
        UserDefaults.standard.set(config.configValue(forKey: parseKey).stringValue,
                                  forKey: stringKey.userDefaultsKey)
      }
    }
    
    AppGuardConfigurationKeys.allIntKeys.forEach { (integerKey) in
      if let parseKey = UserDefaults.standard.string(forKey: integerKey.userDefaultsCustomKey) {
         UserDefaults.standard.set(config.configValue(forKey: parseKey).numberValue.intValue,
                                  forKey: integerKey.userDefaultsKey)
      }
    }
  }
  
}
