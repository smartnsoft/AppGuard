//
//  ViewController.swift
//  AppGuard
//
//  Copyright (c) 2018 Smart&Soft. All rights reserved.
//

import UIKit
import AppGuard
import Extra
import Jelly
import Lottie

enum TransitionType: Int {
  case `default`
  case bottom
  case slideIn
  
  func configure() {
    var presentation: JellyPresentation
    switch self {
    case .default:
      presentation = JellySlideInPresentation(cornerRadius: 15,
                                              backgroundStyle: .blur(effectStyle: .extraLight),
                                              duration: .medium,
                                              directionShow: .top,
                                              directionDismiss: .bottom,
                                              widthForViewController: .custom(value: (UIApplication.shared.keyWindow?.frame.width ?? 0) * 0.8),
                                              heightForViewController: .custom(value: (UIApplication.shared.keyWindow?.frame.height ?? 0) * 0.6))
      presentation.isTapBackgroundToDismissEnabled = false
    case .slideIn:
      presentation = JellySlideInPresentation(cornerRadius: 15,
                                              backgroundStyle: .blur(effectStyle: .dark),
                                              jellyness: .jellier,
                                              duration: .medium,
                                              directionShow: .left,
                                              directionDismiss: .right,
                                              widthForViewController: .custom(value: (UIApplication.shared.keyWindow?.frame.width ?? 0) * 0.8),
                                              heightForViewController: .custom(value: (UIApplication.shared.keyWindow?.frame.height ?? 0) * 0.6))
    case .bottom:
      presentation = {
        var jellyShift = JellyShiftInPresentation()
        jellyShift.direction = .bottom
        jellyShift.backgroundStyle = .blur(effectStyle: .light)
        jellyShift.size = .custom(value: 500)
        return jellyShift
      }()
    }
    
    AppGuard.default.graphicContext.jellyCustomTransition = presentation
  }
}

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TransitionType.default.configure()
    self.prepareAppGuard()
    
    self.updateConfigFile(nb: 1)
    
  }
  
  private func updateConfigFile(nb: Int) {
    if let path = Bundle.main.path(forResource: "configuration\(nb)", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          AppGuard.default.updateConfig(from: localJSONConfiguration)
        }
      } catch {
        // handle error
      }
      
    }
  }
  
  private func prepareAppGuard() {
    AppGuard.default.prepare()
    AppGuard.default.dataSource = self
    AppGuard.default.uiDelegate = self
    AppGuard.default.graphicContext.actionButtonBackgroundColor = UIColor.ex.fromHexa("#17b8c5")
  }
  
  @IBAction func didChangedGuardType(_ sender: UISegmentedControl) {
    
    let index = sender.selectedSegmentIndex
    
    self.updateConfigFile(nb: index + 1)
  }
  
  @IBAction func didChangedTransitionType(_ sender: UISegmentedControl) {
    let type = TransitionType(rawValue: sender.selectedSegmentIndex)
    type?.configure()
  }
  
  @IBAction func didTapShowButton(_ sender: Any) {
    AppGuard.default.displayUpdateStatus(forced: true)
  }
  
}

// MARK: - AppGuardDataSource
extension ViewController: AppGuardDataSource {
  func configureImageView(_ imageView: UIImageView?) {
    if let imageView = imageView {
      let lottieView = LOTAnimationView(name: "icon-animated")
      lottieView.frame = imageView.frame
      lottieView.contentMode = .scaleAspectFit
      lottieView.loopAnimation = true
      imageView.ex.addSubview(lottieView)
      lottieView.play()
    }
    
  }
  
  
  func presenterController() -> UIViewController? {
    return self
  }
  
}


// MARK: - AppGuardUIDelegate
extension ViewController: AppGuardUIDelegate {
  func guardControllerWillAppear(for context: AppGuardContextType) {
    print("guardControllerWillAppear")
  }
  
  func guardControllerDidAppear(for context: AppGuardContextType) {
    print("guardControllerDidAppear")
  }
  
  func guardControllerWillDisappear(for context: AppGuardContextType) {
    print("guardControllerWillDisappear")
  }
  
  func guardControllerDidDisappear(for context: AppGuardContextType) {
    print("guardControllerDidDisappear")
  }
  
  func didChooseLater(for context: AppGuardContextType) {
    print("didChooseLater")
  }
  
  func didChooseAction(for context: AppGuardContextType) {
    if context == .mandatoryUpdate || context == .recommandedUpdate {
      UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/fr/app/id899247664")!)
    }
  }
  
  
}
