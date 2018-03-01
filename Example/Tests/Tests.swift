import XCTest
import AppGuard

class Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    AppGuardConfigurationKeysBinder.resetBinding()
    AppGuard.default.prepare()
  }
  
  override func tearDown() {
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
                                      AppGuardConfigurationKeys.imageUrl.rawValue: "my_imageurl_key"]
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
    self.testDefaultKeyBindings()

    let configuration = StubsReader.config(from: "configuration")
    AppGuard.default.updateConfig(from: configuration)

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

    let configuration = StubsReader.config(from: "custom_keys_configuration")
    AppGuard.default.updateConfig(from: configuration)

    XCTAssertEqualOptional(AppGuard.default.configuration.deeplink, "http://www.google.custom")
    XCTAssertEqualOptional(AppGuard.default.configuration.dialogTypeValue.rawValue, 1)
    XCTAssertEqualOptional(AppGuard.default.configuration.content, "Custom content text")
    XCTAssertEqualOptional(AppGuard.default.configuration.actionButtonLabel, "Custom action label")
    XCTAssertEqualOptional(AppGuard.default.configuration.changelogContent, "Custom changelog text")
    XCTAssertEqualOptional(AppGuard.default.configuration.title, "Custom title")
    XCTAssertEqualOptional(AppGuard.default.configuration.imageUrl, "Custom image URL")
  }
  
}
