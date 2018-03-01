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
import Jelly

final public class AppGuardGraphicContext {
  
  // The global corner radius to apply on the main displayed view
  public lazy var cornerRadius: CGFloat = 10
  
  public var roundedButton = true
  
  public lazy var actionButtonTintColor = UIColor.blue
  public lazy var actionButtonTitleColor = UIColor.white
  public lazy var actionButtonFont = UIFont.boldSystemFont(ofSize: 16)
  
  public lazy var laterButtonTintColor = UIColor.clear
  public lazy var laterButtonTitleColor = UIColor.darkGray
  public lazy var laterButtonFont = UIFont.boldSystemFont(ofSize: 15)
  
  public lazy var titleFont = UIFont.boldSystemFont(ofSize: 25)
  public lazy var titleColor = UIColor.darkGray
  
  public lazy var contentFont = UIFont.systemFont(ofSize: 15, weight: .regular)
  public lazy var contentColor = UIColor.darkGray
  
  public var image: UIImage?
  
  // Jelly
  public lazy var defaultJellyPresentation: JellyPresentation = {
    var presentation = JellySlideInPresentation(cornerRadius: Double(self.cornerRadius),
                                                backgroundStyle: .blur(effectStyle: .extraLight),
                                                duration: .medium,
                                                directionShow: .top,
                                                directionDismiss: .bottom,
                                                widthForViewController: .custom(value: 250),
                                                heightForViewController: .fullscreen)
    presentation.isTapBackgroundToDismissEnabled = false
    return presentation
  }()
  
  public lazy var jellyCustomTransition: JellyPresentation = {
    self.defaultJellyPresentation
  }()
}
