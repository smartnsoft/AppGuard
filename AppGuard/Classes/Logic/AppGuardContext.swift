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

public protocol AppGuardable {
  var coordinator: AppGuardCoordinator? { get set }
}

public enum AppGuardContextKeys: String {
  case lastDisplayUpdate
  case lastSeenInformativeUpdate
  case lastUpdateLater
  
  static let allKeys: [AppGuardContextKeys] = [.lastDisplayUpdate,
                                               .lastSeenInformativeUpdate,
                                               .lastUpdateLater]
  
  var userDefaultsKey: String {
    return "AppGuard.UserDefaults.context.\(self)"
  }
}

public final class AppGuardContext {
  public internal(set) var lastDisplayUpdate: Date? {
    get {
      return UserDefaults.standard.value(forKey: AppGuardContextKeys.lastDisplayUpdate.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardContextKeys.lastDisplayUpdate.userDefaultsKey)
    }
  }
  
  public internal(set) var lastSeenInformativeUpdate: Date? {
    get {
      return UserDefaults.standard.value(forKey: AppGuardContextKeys.lastSeenInformativeUpdate.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardContextKeys.lastSeenInformativeUpdate.userDefaultsKey)
    }
  }
  
  public internal(set) var lastUpdateLater: Date? {
    get {
      return UserDefaults.standard.value(forKey: AppGuardContextKeys.lastUpdateLater.userDefaultsKey) as? Date
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: AppGuardContextKeys.lastUpdateLater.userDefaultsKey)
    }
  }
  
  public func reset() {
    AppGuardContextKeys.allKeys.forEach { (key) in
      UserDefaults.standard.set(nil, forKey: key.userDefaultsKey)
    }
  }
  
}
