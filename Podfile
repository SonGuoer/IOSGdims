platform :ios, '10.0'
use_frameworks!

target ‘IOSGdims’ do
        pod ‘HandyJSON’,’~>1.7.2’
        pod 'SwiftyJSON'
	pod 'Alamofire'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

