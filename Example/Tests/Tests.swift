import XCTest
import AppGuard
import SwiftDate

class Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    AppGuardConfigurationKeysBinder.resetBinding()
    AppGuard.default.context.reset()
    AppGuard.default.prepare()
  }
  
  override func tearDown() {
    AppGuardConfigurationKeysBinder.resetBinding()
    super.tearDown()
  }
  
  private func switchToConfig(named configurationName: String) {
    let configuration = StubsReader.config(from: configurationName)
    AppGuard.default.updateConfig(from: configuration)
    AppGuard.default.prepare()
    AppGuard.default.dataSource = UIViewController.topMost as? AppGuardDataSource
  }
  
  private func simulatePreviousVersionWas1() {
    UserDefaults.standard.setValue(1, forKey: "AppGuard.UserDefaults.context.lastVersionCodeUpdateDisplayed")
  }
  
  func testVersionCode() {
    //Be sure that the version code for test is set to 2
    if let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String,
      let version = Int(bundleVersion) {
      XCTAssertEqual(version, 2)
    } else {
      XCTFail("Version code as to be set to 2 for tests")
    }
    
  }
  
  func testDefaultKeyBindings() {
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey), "")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.deeplink.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.dialogType.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.content.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.actionButtonLabel.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.changelogContent.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.title.rawValue)
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey) as? String,
                           AppGuardConfigurationKeys.imageUrl.rawValue)
  }
  
  func testCustomKeyBindings() {
    
    let binding: [String: String?] = [AppGuardConfigurationKeys.deeplink.rawValue: "my_deeplink_key",
                                      AppGuardConfigurationKeys.dialogType.rawValue: "my_dialog_type_key",
                                      AppGuardConfigurationKeys.content.rawValue: "my_content_key",
                                      AppGuardConfigurationKeys.actionButtonLabel.rawValue: "my_action_label_key",
                                      AppGuardConfigurationKeys.changelogContent.rawValue: "my_changelog_content_key",
                                      AppGuardConfigurationKeys.title.rawValue: "my_title_key",
                                      AppGuardConfigurationKeys.imageUrl.rawValue: "my_imageurl_key",
                                      AppGuardConfigurationKeys.versionCode.rawValue: "my_versionCode_key"]
    AppGuardConfigurationKeysBinder.bindConfigurationKeys(binding)
    
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey), "")
    
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String,
                           "my_deeplink_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey) as? String,
                           "my_dialog_type_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey) as? String,
                           "my_content_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey) as? String,
                           "my_action_label_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey) as? String,
                           "my_changelog_content_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey) as? String,
                           "my_title_key")
    XCTAssertEqualOptional(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey) as? String,
                           "my_imageurl_key")
  }
  
  func testDefaultConfiguration() {
    self.switchToConfig(named: "configuration")
    
    XCTAssertEqualOptional(AppGuard.default.configuration.deeplink, "http://www.google.fr")
    XCTAssertEqualOptional(AppGuard.default.configuration.dialogTypeValue.rawValue, 2)
    XCTAssertEqualOptional(AppGuard.default.configuration.content, "Default content text")
    XCTAssertEqualOptional(AppGuard.default.configuration.actionButtonLabel, "Default action label")
    XCTAssertEqualOptional(AppGuard.default.configuration.changelogContent, "Default changelog text")
    XCTAssertEqualOptional(AppGuard.default.configuration.title, "Default title")
    XCTAssertEqualOptional(AppGuard.default.configuration.imageUrl, "Default image URL")
    
  }
  
  func testCustomConfiguration() {
    
    self.testCustomKeyBindings()
    self.switchToConfig(named: "custom_keys_configuration")

    XCTAssertEqualOptional(AppGuard.default.configuration.deeplink, "http://www.google.custom")
    XCTAssertEqualOptional(AppGuard.default.configuration.dialogTypeValue.rawValue, 1)
    XCTAssertEqualOptional(AppGuard.default.configuration.content, "Custom content text")
    XCTAssertEqualOptional(AppGuard.default.configuration.actionButtonLabel, "Custom action label")
    XCTAssertEqualOptional(AppGuard.default.configuration.changelogContent, "Custom changelog text")
    XCTAssertEqualOptional(AppGuard.default.configuration.title, "Custom title")
    XCTAssertEqualOptional(AppGuard.default.configuration.imageUrl, "Custom image URL")
  }
  
  
  /// Mandatory update has to be displayed
  func testMandatoryUpdate() {
    self.switchToConfig(named: "configuration_mandatoryTo3")
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "Mandatory update has to be displayed")
  }
  
  /// A mandatory update does not to be displayed if the version is correct
  func testNotConsernedMandatoryUpdate() {
    self.switchToConfig(named: "configuration_mandatoryTo2")
    
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "A mandatory update does not to be displayed if the version is correct (2)")
  }
  
  /// A mandatory update has to be displayed in any case, even before 3 days re-ask limit
  func testMandatoryUpdateBeforeDays() {
    self.switchToConfig(named: "configuration_mandatoryTo3")
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "Mandatory update has to be displayed first")
    XCTAssertNotNil(AppGuard.default.context.lastDisplayUpdate, "Last display date has to be saved")
    if let date = AppGuard.default.context.lastDisplayUpdate {
      let newDate = date - 2.days
      UserDefaults.standard.setValue(newDate, forKey: "AppGuard.UserDefaults.context.lastDisplayUpdate")
    }
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "A mandatory update has to be displayed in any case, even before 3 days re-ask limit")
    
  }
  
  /// A mandatory update has to be displayed in any case, even after 3 days re-ask limit
  func testMandatoryUpdateAfterDays() {
    self.switchToConfig(named: "configuration_mandatoryTo3")
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "Mandatory update has to be displayed first")

    XCTAssertNotNil(AppGuard.default.context.lastDisplayUpdate, "Last display date has to be saved")
    if let date = AppGuard.default.context.lastDisplayUpdate {
      let newDate = date - 3.days
      UserDefaults.standard.setValue(newDate, forKey: "AppGuard.UserDefaults.context.lastDisplayUpdate")
    }
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "A mandatory update has to be displayed in any case, even before 3 days re-ask limit")
  }
  
  /// A recommanded update has to be displayed if the version is too old
  func testRecommandedUpdate() {
    self.switchToConfig(named: "configuration_recommandedTo3")
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "A recommanded update has to be displayed if the version is too old")
  }
  
  /// A recommanded update has not to be displayed if the version is correct
  func testNotConcernedRecommandedUpdate() {
    self.switchToConfig(named: "configuration_recommandedTo2")
    
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "A recommanded update has not to be displayed if the version is correct")
  }
  
  
  /// A recommanded update does not to be displayed before the 3 days re-ask limit
  func testRecommandedUpdateBeforeDays() {
    self.testRecommandedUpdate()
    
    if let date = AppGuard.default.context.lastDisplayUpdate {
      let newDate = date - 2.days
      UserDefaults.standard.setValue(newDate, forKey: "AppGuard.UserDefaults.context.lastDisplayUpdate")
    }
    
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "A recommanded update does not to be displayed before the 3 days re-ask limit")
    
  }
  
  
  /// A recommanded update has to be re-displayed after the 3 days re-ask limit
  func testRecommandedUpdateAfterDays() {

    self.testRecommandedUpdate()
    
    if let date = AppGuard.default.context.lastDisplayUpdate {
      let newDate = date - 3.days
      UserDefaults.standard.setValue(newDate, forKey: "AppGuard.UserDefaults.context.lastDisplayUpdate")
    }
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "A recommanded update has to be re-displayed after the 3 days re-ask limit")
  }
  
  // The changelog screen has not to be displayed if the last version is upper than the current one
  func testChangelogDisplayNotConcernedUpper() {
    self.switchToConfig(named: "configuration_updateChangelogFor3")
    
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "The changelog screen has not to be displayed if the last version is upper than the current one")
  }
  
  // The changelog screen has not to be re-displayed if last changelogVersion is correct
  func testChangelogDisplay() {
    self.switchToConfig(named: "configuration_updateChangelogFor2")
    self.simulatePreviousVersionWas1()
    
    XCTAssertTrue(AppGuard.default.displayUpdateStatus(), "The changelog screen has not to be re-displayed if last changelogVersion is correct")
  }
  
  // The changelog screen has not to be re-displayed if last changelogVersion is correct
  func testChangelogDisplayNotRedisplay() {
    self.testChangelogDisplay()
    
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "The changelog screen has not to be re-displayed if last changelogVersion is correct")
  }
  
  // The changelog screen has not to be re-displayed if last version code are differents
  func testChangelogDisplayNotConcerned() {
    self.switchToConfig(named: "configuration_updateChangelogFor3")
    XCTAssertFalse(AppGuard.default.displayUpdateStatus(), "The changelog screen has not to be re-displayed if last changelogVersion is correct")
  }
  
}
