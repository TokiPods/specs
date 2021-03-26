#
# Be sure to run `pod lib lint TKMInfoManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKMInfoManager'
  s.version          = '0.1.2'
  s.summary          = 'TKM 数据信息管理器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TKM 数据信息管理器'

  s.homepage         = 'https://github.com/TokiModularization/TKMInfoManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tokihunter' => 'zhengxianda0512@gmail.com' }
  s.source           = { :git => 'https://github.com/TokiModularization/TKMInfoManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #Framework模式
  s.subspec 'FrameworkMode' do |fm|
    fm.vendored_frameworks = 'TKMInfoManager/TKMInfoManagerSDK/*.framework'
    # fm.resource = 'TKMInfoManager/TKMInfoManagerSDK/*.bundle'
  end
  
  #源码模式
  s.subspec 'SourceMode' do |sm|
    sm.source_files = [
      'TKMInfoManager/Classes/**/*',
      # 'TKMInfoManager/Interface/**/*.m'
    ]
    sm.public_header_files = [
      'TKMInfoManager/Classes/**/*.h'
    ]
    # sm.resource_bundles = {
    #   'TKMInfoManager' => ['TKMInfoManager/Assets/**/*.png']
    # }
  end

  #对外接口
  # s.subspec 'Interface' do |interface|
  #   interface.source_files = [
  #     'TKMInfoManager/Interface/**/*.h',
  #   ]
  #   interface.public_header_files = [
  #     'TKMInfoManager/Interface/**/*.h'
  #   ]
  # end

  #核心代码
  s.subspec 'Core' do |core|
    # FX=all pod install; 所有库都使用framework模式安装
    isAllFX = ENV['FX'] == "all" || ENV['TKMInfoManager_FX'] == "all"; 
    # FX=dependency pod install; 依赖库使用framework模式安装
    isDependencyFX = ENV['FX'] == "dependency" || ENV['TKMInfoManager_FX'] == "dependency"; 
    isDependency = !!__FILE__[".cocoapods/repos"];
    if isAllFX || (isDependency && isDependencyFX)
      core.dependency 'TKMInfoManager/FrameworkMode'
    else
      core.dependency 'TKMInfoManager/SourceMode'
      # core.dependency 'TKMInfoManager/Interface'
    end

    # core.public_header_files = 'Pod/Classes/**/*.h'
    # core.frameworks = 'UIKit', 'MapKit'
    core.dependency 'TKMRequest'
  end
  s.default_subspec = 'Core'
end
