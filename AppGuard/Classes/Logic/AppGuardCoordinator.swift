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

public final class AppGuardCoordinator {
  
  weak var controller: UIViewController?
  
  var contextType: AppGuardContextType = AppGuardContextType.none
  
  init(controller: UIViewController, `in` context: AppGuardContextType) {
    self.controller = controller
    self.contextType = context
  }
  
  func didChooseLater() {
    AppGuard.default.context.lastUpdateLater = Date()
    self.dismissLater()
  }
  
  func didChooseAction() {
    self.dismissAction()
  }
  
  private func dismissAction() {
    AppGuard.default.uiDelegate?.guardControllerWillDisappear(for: self.contextType)
    self.controller?.dismiss(animated: true, completion: {
      AppGuard.default.uiDelegate?.didChooseAction(for: self.contextType)
      AppGuard.default.uiDelegate?.guardControllerDidDisappear(for: self.contextType)
    })
    
  }
  
  private func dismissLater() {
    
    AppGuard.default.uiDelegate?.guardControllerWillDisappear(for: self.contextType)
    self.controller?.dismiss(animated: true, completion: {
      AppGuard.default.uiDelegate?.didChooseAction(for: self.contextType)
      AppGuard.default.uiDelegate?.guardControllerDidDisappear(for: self.contextType)
    })
  }
}
