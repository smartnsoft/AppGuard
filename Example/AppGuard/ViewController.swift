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
import FirebaseRemoteConfig
import Kingfisher

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
        jellyShift.size = .custom(value: 600)
        return jellyShift
      }()
    }
    
    AppGuard.default.graphicContext.jellyCustomTransition = presentation
  }
}

class ViewController: UIViewController {
  
  @IBOutlet weak var ibDialogTypeSegmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TransitionType.default.configure()
    self.prepareAppGuard()
    
    self.updateConfigFile(nb: 1)
    
  }
  
  private func updateConfigFile(nb: Int) {
    AppGuardConfigurationKeysBinder.configureDefaultKeysBinding()
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
  
  @IBAction func didTapFetchLocalConfig(_ sender: Any) {
    self.updateConfigFile(nb: self.ibDialogTypeSegmentedControl.selectedSegmentIndex + 1)
  }
  
  
  @IBAction func didTapRetrieveUserConfigButton(_ sender: Any) {
    
    let binding: [String: String?] = [AppGuardConfigurationKeys.deeplink.rawValue: "update_deeplink",
                                      AppGuardConfigurationKeys.dialogType.rawValue: "update_dialogType",
                                      AppGuardConfigurationKeys.content.rawValue: "update_content",
                                      AppGuardConfigurationKeys.actionButtonLabel.rawValue: "update_actionButtonLabel",
                                      AppGuardConfigurationKeys.changelogContent.rawValue: "update_changelog_content",
                                      AppGuardConfigurationKeys.title.rawValue: "update_title",
                                      AppGuardConfigurationKeys.imageUrl.rawValue: "update_imageURL",
                                      AppGuardConfigurationKeys.versionCode.rawValue: "current_version_code"]
    AppGuardConfigurationKeysBinder.bindConfigurationKeys(binding)
    
    let remoteConfig = RemoteConfig.remoteConfig()
    remoteConfig.fetch(withExpirationDuration: 1) { (status, error) in
      
      switch status {
      case .success, .throttled:
        remoteConfig.activateFetched()
        AppGuard.default.updateFrom(remoteConfig: remoteConfig)
        
        let message = """
        title : \(AppGuard.default.configuration.title ?? "") \n
        deeplink : \(AppGuard.default.configuration.deeplink ?? "") \n
        dialogType : \(AppGuard.default.configuration.dialogType) \n
        content : \(AppGuard.default.configuration.content ?? "") \n
        actionButtonLabel : \(AppGuard.default.configuration.actionButtonLabel ?? "") \n
        changelogContent : \(AppGuard.default.configuration.changelogContent ?? "") \n
        title : \(AppGuard.default.configuration.title ?? "") \n
        imageUrl : \(AppGuard.default.configuration.imageUrl ?? "") \n
        versionCode : \(AppGuard.default.configuration.versionCode) \n
        """
        
        let alertController = UIAlertController(title: "Configuration updated from Firebase 👌",
                                                message: message,
                                                preferredStyle: .alert)
        let dismissItem = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(dismissItem)
        self.present(alertController, animated: true, completion: nil)
      case .failure:
        print("Cannot retrieve Firebase remote config, check your SDK integration first")
      default:
        break
      }
    }
  }
  
}

// MARK: - AppGuardDataSource
extension ViewController: AppGuardDataSource {
  func configureImageView(_ imageView: UIImageView?) {
    
    if let sImageUrl = AppGuard.default.configuration.imageUrl, let imageURL = URL(string: sImageUrl) {
      imageView?.kf.setImage(with: imageURL)
    } else if let imageView = imageView {
      let lottieView = LOTAnimationView(name: "techno_penguin")
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
