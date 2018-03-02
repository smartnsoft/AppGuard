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

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    if var transition = AppGuard.default.graphicContext.jellyCustomTransition as? JellySlideInPresentation {
      transition.heightForViewController = .custom(value: self.navigationController?.view.frame.height ?? 0 - 100)
      transition.widthForViewController = .custom(value: self.navigationController?.view.frame.width ?? 0 - 40)
    }
  }
  
  @IBAction func didChangedGuardType(_ sender: UISegmentedControl) {
    
    let index = sender.selectedSegmentIndex
    
    self.updateConfigFile(nb: index + 1)
    
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
