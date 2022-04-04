#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint spren_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'spren_flutter'
  s.version          = '0.0.0'
  s.summary          = 'Stub Plugin.'
  s.homepage         = 'https://github.com/Elite-HRV/spren-vision-ios#readme'
  s.author           = { 'Spren' => 'nick@elitehrv.com' }
  s.source           = { :path => '.' }
  s.dependency 'Flutter'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
