
Pod::Spec.new do |s|
  s.name         = "SprenVision"
  s.version      = "1.2.1"
  s.summary      = "Spren Finger Camera SDK"
  s.homepage     = "https://github.com/Elite-HRV/spren-vision-ios#readme"
  s.license      = "LicenseRef-LICENSE"
  s.authors      = {'Keith Carolus'     => 'keith@spren.com',
                    'Fernando Eckert'   => 'Fernando@spren.com',
                    'Nick Avasiloy'     => 'nick@spren.com'}

  s.platforms    = { :ios => "14.0" }
  s.source       = { :git => "https://github.com/Elite-HRV/spren-vision-ios.git", :tag => "v#{s.version}" }

  s.source_files = "Sources/**/*.{swift}"
  s.vendored_frameworks = "Framework/SprenCore.xcframework"
  s.swift_version = '5.0'
  s.dependency 'DeviceKit', '~> 4.0'
end
