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

public typealias DisplayScreenResult = (willDisplay: Bool, context: AppGuardContextType)

final class AppGuardChecker {
  static func needDisplayScreen() -> DisplayScreenResult {
    
    let configuration = AppGuard.default.configuration
    let context = AppGuard.default.context
    
    guard configuration.dialogTypeValue != .none else {
      return (false, .none)
    }
    
    let needs = (context.lastDisplayUpdate == nil || Date().isAfter(context.lastDisplayUpdate,
                                                                    pastDays: configuration.maxDaysBetweenDisplay))
    
    return (needs, configuration.dialogTypeValue)
  }
}

// MARK: - TimeInterval
extension TimeInterval {
  static let dayInSeconds: TimeInterval = 24 * 60 * 60
}

extension Date {
  func isAfter(_ date: Date?, pastDays: Int) -> Bool {
    return self.timeIntervalSinceReferenceDate > ((date?.timeIntervalSinceReferenceDate ?? TimeInterval.greatestFiniteMagnitude)
      + (Double(pastDays) * TimeInterval.dayInSeconds))
  }
}
