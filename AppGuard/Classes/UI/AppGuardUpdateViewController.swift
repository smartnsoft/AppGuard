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

import UIKit
import Extra

public class AppGuardUpdateViewController: AppGuardViewController, AppGuardable {
  
  @IBOutlet public weak var ibDescriptionLabel: UILabel?
  @IBOutlet public weak var ibLaterButton: UIButton?
  
  public var coordinator: AppGuardCoordinator?
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    let nibName = "AppGuardUpdateViewController"
    let bundle: Bundle = Bundle.bundleForResource(name: nibName, ofType: "nib")
    
    super.init(nibName: nibName, bundle: bundle)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    if AppGuard.default.graphicContext.roundedButton {
      self.ibLaterButton?.layer.masksToBounds = true
      self.ibLaterButton?.layer.cornerRadius = 22
    }
  
    self.ibDescriptionLabel?.font = AppGuard.default.graphicContext.contentFont
    self.ibDescriptionLabel?.text = AppGuard.default.configuration.content
    
    self.ibLaterButton?.titleLabel?.font = AppGuard.default.graphicContext.laterButtonFont
    self.ibLaterButton?.setTitle(AppGuard.default.configuration.laterButtonLabel,
                                 for: .normal)
    self.ibLaterButton?.setTitleColor(AppGuard.default.graphicContext.laterButtonTitleColor,
                                      for: .normal)
    self.ibLaterButton?.setBackgroundImage(AppGuard.default.graphicContext.laterButtonBackgroundColor?.ex.toImage(),
                                            for: .normal)
    
    self.ibLaterButton?.isHidden = (self.coordinator?.contextType == .mandatoryUpdate)
    
  }
  
  @IBAction public func didTapLaterButton(_ sender: Any) {
    AppGuard.default.context.lastUpdateLater = Date()
    self.coordinator?.didChooseLater()
  }
  
  @IBAction public func didTapActionButton(_ sender: Any) {
    self.coordinator?.didChooseAction()
  }
}
