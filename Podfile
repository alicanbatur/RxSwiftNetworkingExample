# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RxSwiftExample3' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RxSwiftExample3
  pod 'Moya-ModelMapper/RxSwift', '4.0.0'
  pod 'RxCocoa', '~> 3.0.0'
  pod 'RxSwift', '~> 3.0.0'
  pod 'RxOptional'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
              config.build_settings['ENABLE_TESTABILITY'] = 'YES'
              config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
