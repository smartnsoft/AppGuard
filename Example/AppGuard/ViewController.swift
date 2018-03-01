//
//  ViewController.swift
//  AppGuard
//
//  Copyright (c) 2018 Smart&Soft. All rights reserved.
//

import UIKit
import AppGuard

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let path = Bundle.main.path(forResource: "configuration", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        if let localJSONConfiguration = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?] {
          AppGuard.default.prepare()
          AppGuard.default.updateConfig(from: localJSONConfiguration)
          AppGuard.default.dataSource = self
          AppGuard.default.uiDelegate = self
          
        }
      } catch {
        // handle error
      }
    }
    
  }
  
  @IBAction func didTapShowButton(_ sender: Any) {
    AppGuard.default.displayUpdateStatus(forced: true)
  }
  
}

// MARK: - AppGuardDataSource
extension ViewController: AppGuardDataSource {
  func customUpdateController() -> AppGuardUpdateViewController & AppGuardable {
    return AppGuardUpdateViewController()
  }
  
  func customChangelogController() -> AppGuardChangelogViewController & AppGuardable {
    return AppGuardChangelogViewController()
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
