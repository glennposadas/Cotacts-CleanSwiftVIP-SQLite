source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.1'
use_frameworks!
inhibit_all_warnings!

def test_pods
  inherit! :search_paths
  pod 'Quick'
  pod 'Nimble'
end

target 'Contacts' do
  pod 'CocoaLumberjack/Swift'
  pod 'Kingfisher'
  pod 'GRDB.swift'
  pod 'Moya'
  pod 'SnapKit'
  pod 'SwiftDate'
  
  target 'ContactsTests' do
    test_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.1'
    end
  end
end
