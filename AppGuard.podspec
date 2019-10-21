Pod::Spec.new do |s|
  s.name             = 'AppGuard'
  s.version          = '0.3.0'
  s.summary          = 'AppGuard is a guard 💂‍♀️ for your iOS app, to check / force users to update your app or show what changed.'
  s.homepage         = 'https://github.com/smartnsoft/AppGuard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/AppGuard.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/smartnsoft'
  s.swift_version    = '4.2'
  s.ios.deployment_target = '9.0'
  s.frameworks = 'UIKit'
  s.default_subspec = 'Core'
  s.static_framework = true
  s.resource_bundles = {'AppGuard' => ['AppGuard/Classes/UI/*.{xib}']}

  s.subspec 'Core' do |core|
    core.dependency 'Jelly', '~> 1.2.0'
    core.source_files = [
    'AppGuard/Classes/Logic/*',
    'AppGuard/Classes/UI/*'
    ]
  end
  
  s.subspec 'FirebaseRemoteConfig' do |firebase|
    firebase.dependency 'AppGuard/Core'
    firebase.dependency 'Firebase/RemoteConfig', '~> 6.10'
    firebase.source_files = 'AppGuard/Classes/Firebase/**/*.{swift}'
  end
end
