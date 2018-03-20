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
import XCTest

extension XCTestCase {
  func XCTAssertEqualOptional<T: Any>(_ a: @autoclosure () -> T?, _ b: @autoclosure () -> T?, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) where T: Equatable {
    if let _a = a() {
      if let _b = b() {
        XCTAssertEqual(_a, _b, (message != nil ? message! : ""), file: file, line: line)
      } else {
        XCTFail((message != nil ? message! : "a != nil, b == nil"), file: file, line: line)
      }
    } else if let _ = b() {
      XCTFail((message != nil ? message! : "a == nil, b != nil"), file: file, line: line)
    }
  }
}
