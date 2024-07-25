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
  
  /// Whether the main button show have rounded edges.
  /// You can customize the corner radius with the ````buttonCornerRadius```` property
  public var roundedButton = true
  
  /// The corner radius to apply to the main button.
  /// Ignored if ````roundedButton```` is ````false````.
  /// If nil, the corner radius will be set so that the button is round.
  public var buttonCornerRadius: CGFloat?
  
  public lazy var actionButtonBackgroundColor: UIColor? = UIColor.blue
  public lazy var actionButtonTitleColor = UIColor.white
  public lazy var actionButtonFont = UIFont.boldSystemFont(ofSize: 16)
  
  public lazy var laterButtonBackgroundColor: UIColor? = UIColor.clear
  public lazy var laterButtonTitleColor = UIColor.darkGray
  public lazy var laterButtonFont = UIFont.boldSystemFont(ofSize: 15)
  
  public lazy var titleFont = UIFont.boldSystemFont(ofSize: 25)
  public lazy var titleColor = UIColor.darkGray
  
  public lazy var contentFont = UIFont.systemFont(ofSize: 15)
  public lazy var contentColor = UIColor.darkGray
  
  public var image: UIImage?
  
  // Jelly
  public lazy var defaultJellyPresentation: Presentation = {
    
    let uiConfiguration = PresentationUIConfiguration(cornerRadius: Double(self.cornerRadius),
                                                      backgroundStyle: .blurred(effectStyle: .extraLight),
                                                      isTapBackgroundToDismissEnabled: false
    )
    
    let timing = PresentationTiming(duration: .medium)
    let size = PresentationSize(width: .custom(value: 250), height: .custom(value: 400))
    
    var presentation = JellySlideInPresentation(directionShow: .top, directionDismiss: .bottom,
                                                uiConfiguration: uiConfiguration,
                                                size: size,
                                                timing: timing
    )
    
    
    return presentation
  }()
  
  public lazy var jellyCustomTransition: Presentation = {
    self.defaultJellyPresentation
  }()
}
