Pod::Spec.new do |s|
  s.name             = 'AppGuard'
  s.version          = '0.1.0-beta2'
  s.summary          = 'AppGuard is a guard for your iOS app, to check / force users to update your app or show what changed.'
  s.homepage         = 'https://github.com/smartnsoft/AppGuard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/AppGuard.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/smartnsoft'

  s.ios.deployment_target = '9.0'

  s.source_files = 'AppGuard/Classes/**/*'

  s.resources = [
    'AppGuard/Assets/*.lproj/*.strings',
    'AppGuard/Assets/AppGuardImages.xcassets'
    ]

  s.frameworks = 'UIKit'
  s.dependency 'Jelly', '~> 1.2'
  
  s.subspec 'FirebaseRemoteConfig' do |sp|
    sp.source_files = 'AppGuard/Classes/Firebase/**/*.{swift}'
    sp.dependency 'Firebase/RemoteConfig', '~> 4.9'
  end
end
