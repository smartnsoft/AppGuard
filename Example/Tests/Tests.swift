import XCTest
import AppGuard

class Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    UserDefaults.resetStandardUserDefaults()
  }
  
  override func tearDown() {
    UserDefaults.resetStandardUserDefaults()
    super.tearDown()
  }

  
  func testDefaultKeyBindings() {
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey), "")
    
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.deeplink.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.dialogType.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.content.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.actionButtonLabel.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.changelogContent.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.title.rawValue)
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey) as? String,
                   AppGuardConfigurationKeys.imageUrl.rawValue)
  }
  
  func testCustomKeyBindings() {
    
    let binding: [String: String?] = [AppGuardConfigurationKeys.deeplink.rawValue: "my_deeplink_key",
                                      AppGuardConfigurationKeys.dialogType.rawValue: "my_dialog_type_key",
                                      AppGuardConfigurationKeys.content.rawValue: "my_content_key",
                                      AppGuardConfigurationKeys.actionButtonLabel.rawValue: "my_action_label_key",
                                      AppGuardConfigurationKeys.changelogContent.rawValue: "my_changelog_content_key",
                                      AppGuardConfigurationKeys.title.rawValue: "my_title_key",
                                      AppGuardConfigurationKeys.imageUrl.rawValue: "my_imageurl_key"]
    AppGuardConfigurationKeysBinder.bindConfigurationKeys(binding)
    
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey), "")
    XCTAssertNotNil(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey), "")
    
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.deeplink.userDefaultsCustomKey) as? String,
                   "my_deeplink_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.dialogType.userDefaultsCustomKey) as? String,
                   "my_dialog_type_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.content.userDefaultsCustomKey) as? String,
                   "my_content_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.actionButtonLabel.userDefaultsCustomKey) as? String,
                   "my_action_label_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.changelogContent.userDefaultsCustomKey) as? String,
                   "my_changelog_content_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.title.userDefaultsCustomKey) as? String,
                   "my_title_key")
    XCTAssertEqual(UserDefaults.standard.value(forKey: AppGuardConfigurationKeys.imageUrl.userDefaultsCustomKey) as? String,
                   "my_imageurl_key")
  }
  
  func testDefaultConfiguration() {
    self.testDefaultKeyBindings()
    
    let configuration = StubsReader.config(from: "configuration")
    AppGuard.default.updateConfig(from: configuration)
    
    XCTAssertEqual(AppGuard.default.configuration.deeplink, "")
    XCTAssertEqual(AppGuard.default.configuration.dialogTypeValue.rawValue, 2)
    XCTAssertEqual(AppGuard.default.configuration.content, "")
    XCTAssertEqual(AppGuard.default.configuration.actionButtonLabel, "")
    XCTAssertEqual(AppGuard.default.configuration.changelogContent, "")
    XCTAssertEqual(AppGuard.default.configuration.title, "")
    XCTAssertEqual(AppGuard.default.configuration.imageUrl, "")
    
  }
  
  func testCustomConfiguration() {
    self.testCustomKeyBindings()
    
    let configuration = StubsReader.config(from: "custom_keys_configuration")
    AppGuard.default.updateConfig(from: configuration)
    
    XCTAssertEqual(AppGuard.default.configuration.deeplink, "")
    XCTAssertEqual(AppGuard.default.configuration.dialogTypeValue.rawValue, 1)
    XCTAssertEqual(AppGuard.default.configuration.content, "")
    XCTAssertEqual(AppGuard.default.configuration.actionButtonLabel, "")
    XCTAssertEqual(AppGuard.default.configuration.changelogContent, "")
    XCTAssertEqual(AppGuard.default.configuration.title, "")
    XCTAssertEqual(AppGuard.default.configuration.imageUrl, "")
  }
  
}
