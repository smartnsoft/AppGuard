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

/// UI display callbacks of the controllers
public protocol AppGuardUIDelegate: class {
  
  func guardControllerWillAppear(`for` context: AppGuardContextType)
  func guardControllerDidAppear(`for` context: AppGuardContextType)
  
  func guardControllerWillDisappear(`for` context: AppGuardContextType)
  func guardControllerDidDisappear(`for` context: AppGuardContextType)
  
  func didChooseLater(`for` context: AppGuardContextType)
  func didChooseAction(`for` context: AppGuardContextType)
}

/// Configure your custom controllers to display instead of default ones
public protocol AppGuardDataSource: class {
  func presenterController() -> UIViewController?
  func configureImageView(_ imageView: UIImageView?)
}

public final class AppGuard {
  
  /// The default 💂‍♀️ of your app
  public static let `default` = AppGuard()
  
  public var configuration = AppGuardConfiguration()
  public var context = AppGuardContext()
  public var graphicContext = AppGuardGraphicContext()
  
  public weak var uiDelegate: AppGuardUIDelegate?
  public weak var dataSource: AppGuardDataSource?
  
  /// We have to keep a strong value to keep the animator alive
  fileprivate var jellyAnimator: JellyAnimator?
  
  public func prepare() {
    if (UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String)?.isEmpty == true || UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) == nil {
      AppGuardConfigurationKeysBinder.configureDefaultKeysBinding()
    }
  }
  
  public func updateConfig(from configurationData: [String: Any?]) {
    self.configuration.update(with: configurationData)
  }
  
  @discardableResult
  public func displayUpdateStatus(forced: Bool = false) -> Bool {
    
    let result = AppGuardChecker.needDisplayScreen()
    
    if forced || (result.willDisplay && result.context != .none) {
      if var controller =  self.controller(for: result.context) {
        let coordinator = AppGuardCoordinator(controller: controller, in: result.context)
        controller.coordinator = coordinator
        
        //Prepare animation
        let alertPresentation = self.graphicContext.jellyCustomTransition
        self.jellyAnimator = JellyAnimator(presentation: alertPresentation)
        self.jellyAnimator?.prepare(viewController: controller)
        
        //Display
        self.uiDelegate?.guardControllerWillAppear(for: result.context)
        self.dataSource?.presenterController()?.present(controller, animated: true, completion: {
          self.context.lastDisplayUpdate = Date()
          self.uiDelegate?.guardControllerDidAppear(for: result.context)
        })
      } else {
        return false
      }
    }
    
    return result.willDisplay
  }
  
  private func controller(`for` context: AppGuardContextType) -> (UIViewController & AppGuardable)?{
    switch context {
    case .lastUpdateChangelog:
      return AppGuardChangelogViewController()
    case .mandatoryUpdate, .recommandedUpdate:
      return AppGuardUpdateViewController()
    default:
      return nil
    }
  }
}
