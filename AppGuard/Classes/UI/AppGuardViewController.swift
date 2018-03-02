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

public class AppGuardViewController: UIViewController {
  @IBOutlet public weak var ibImageView: UIImageView?
  @IBOutlet public weak var ibTitleLabel: UILabel?
  
  @IBOutlet public weak var ibActionButton: UIButton?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.ibTitleLabel?.text = AppGuard.default.configuration.title
    self.ibTitleLabel?.textColor = AppGuard.default.graphicContext.contentColor
    self.ibTitleLabel?.font = AppGuard.default.graphicContext.titleFont
    
    self.ibActionButton?.titleLabel?.font = AppGuard.default.graphicContext.actionButtonFont
    self.ibActionButton?.setTitle(AppGuard.default.configuration.actionButtonLabel,
                                  for: .normal)
    self.ibActionButton?.setTitleColor(AppGuard.default.graphicContext.actionButtonTitleColor,
                                       for: .normal)
    self.ibActionButton?.setBackgroundImage(AppGuard.default.graphicContext.actionButtonBackgroundColor?.ex.toImage(),
                                            for: .normal)
    if AppGuard.default.graphicContext.roundedButton {
      self.ibActionButton?.layer.masksToBounds = true
      self.ibActionButton?.layer.cornerRadius = 22
    }
    
    AppGuard.default.dataSource?.configureImageView(self.ibImageView)
  }
}
