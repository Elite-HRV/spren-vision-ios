#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint spren_flutter.podspec` to validate before publishing.
#

Pod::Spec.new do |s|
  s.name             = 'spren_flutter'
  s.version          = '1.0.1'
  s.summary          = "Flutter plugin wrapping Spren"
  s.homepage         = "https://github.com/Elite-HRV/spren-vision-ios#readme"
  s.license          = "LicenseRef-LICENSE"
  s.author           = "nick <nick@elitehrv.com> (https://github.com/Elite-HRV)"
  s.source       = { :git => "https://github.com/Elite-HRV/spren-vision-ios.git", :tag => "#{s.version}" }
  s.source_files = "Classes/**/*"
  s.dependency 'Flutter'
  s.dependency 'SprenVision'

  s.platforms    = { :ios => "14.0" }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
