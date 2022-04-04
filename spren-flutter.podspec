require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name             = "spren-flutter"
  s.version          = package["version"]
  s.summary          = "Flutter plugin wrapping Spren"
  s.homepage         = package["homepage"]
  s.license          = package["license"]
  s.author           = package["author"]
  s.source       = { :git => "https://github.com/Elite-HRV/spren-vision-ios.git", :tag => "#{s.version}" }
  s.source_files = "flutter/ios/Classes/**/*", "Sources/**/*.{swift}"
  s.vendored_frameworks = "Framework/SprenCore.xcframework"
  s.dependency 'Flutter'
  s.platforms    = { :ios => "14.0" }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
