#
# Be sure to run `pod lib lint TKMAccountModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKMAccountModule'
  s.version          = '0.1.7'
  s.summary          = 'TKM 账号组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TKM 账号组件'

  s.homepage         = 'https://github.com/TokiModularization/TKMAccountModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tokihunter' => 'zhengxianda0512@gmail.com' }
  s.source           = { :git => 'https://github.com/TokiModularization/TKMAccountModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #Framework模式
  s.subspec 'FrameworkMode' do |fm|
    fm.vendored_frameworks = 'TKMAccountModule/TKMAccountModuleSDK/*.framework'
    # fm.resource = 'TKMAccountModule/TKMAccountModuleSDK/*.bundle'
  end
  
  #源码模式
  s.subspec 'SourceMode' do |sm|
    sm.source_files = [
      'TKMAccountModule/Classes/**/*',
      'TKMAccountModule/Interface/**/*.m'
    ]
    sm.public_header_files = [
      'TKMAccountModule/Classes/**/*.h'
    ]
    # sm.resource_bundles = {
    #   'TKMAccountModule' => ['TKMAccountModule/Assets/**/*.png']
    # }
  end

  #对外接口
  s.subspec 'Interface' do |interface|
    interface.source_files = [
     'TKMAccountModule/Interface/**/*.h',
    ]
    interface.public_header_files = [
     'TKMAccountModule/Interface/**/*.h'
    ]
  end

  #核心代码
  s.subspec 'Core' do |core|
    # FX=all pod install; 所有库都使用framework模式安装
    isAllFX = ENV['FX'] == "all" || ENV['TKMAccountModule_FX'] == "all"; 
    # FX=dependency pod install; 依赖库使用framework模式安装
    isDependencyFX = ENV['FX'] == "dependency" || ENV['TKMAccountModule_FX'] == "dependency"; 
    isDependency = !!__FILE__[".cocoapods/repos"];
    if isAllFX || (isDependency && isDependencyFX)
      core.dependency 'TKMAccountModule/FrameworkMode'
    else
      core.dependency 'TKMAccountModule/SourceMode'
      core.dependency 'TKMAccountModule/Interface'
    end

    # core.public_header_files = 'Pod/Classes/**/*.h'
    # core.frameworks = 'UIKit', 'MapKit'
    core.dependency 'Masonry'
    core.dependency 'TKModule'
    core.dependency 'TKMResourceManager'
    core.dependency 'TKMInfoManager'
    
    core.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end
  s.default_subspec = 'Core'
end
