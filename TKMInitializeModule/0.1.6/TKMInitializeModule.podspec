#
# Be sure to run `pod lib lint TKMInitializeModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKMInitializeModule'
  s.version          = '0.1.6'
  s.summary          = 'TKM 初始化组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TKM 初始化组件'

  s.homepage         = 'https://github.com/TokiModularization/TKMInitializeModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhengxianda0512@gmail.com' => 'xianda.zheng@email.com' }
  s.source           = { :git => 'https://github.com/TokiModularization/TKMInitializeModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #Framework模式
  s.subspec 'FrameworkMode' do |fm|
    fm.vendored_frameworks = 'TKMInitializeModule/TKMInitializeModuleSDK/*.framework'
    # fm.resource = 'TKMInitializeModule/TKMInitializeModuleSDK/*.bundle'
  end
  
  #源码模式
  s.subspec 'SourceMode' do |sm|
    sm.source_files = [
      'TKMInitializeModule/Classes/**/*',
      'TKMInitializeModule/Interface/**/*.m'
    ]
    sm.public_header_files = [
      'TKMInitializeModule/Classes/**/*.h'
    ]
    # sm.resource_bundles = {
    #   'TKMInitializeModule' => ['TKMInitializeModule/Assets/**/*.png']
    # }
  end

  #对外接口
  s.subspec 'Interface' do |interface|
    interface.source_files = [
     'TKMInitializeModule/Interface/**/*.h',
    ]
    interface.public_header_files = [
     'TKMInitializeModule/Interface/**/*.h'
    ]
  end

  #核心代码
  s.subspec 'Core' do |core|
    # FX=all pod install; 所有库都使用framework模式安装
    isAllFX = ENV['FX'] == "all" || ENV['TKMInitializeModule_FX'] == "all"; 
    # FX=dependency pod install; 依赖库使用framework模式安装
    isDependencyFX = ENV['FX'] == "dependency" || ENV['TKMInitializeModule_FX'] == "dependency"; 
    isDependency = !!__FILE__[".cocoapods/repos"];
    if isAllFX || (isDependency && isDependencyFX)
      core.dependency 'TKMInitializeModule/FrameworkMode'
    else
      core.dependency 'TKMInitializeModule/SourceMode'
      core.dependency 'TKMInitializeModule/Interface'
    end

    # core.public_header_files = 'Pod/Classes/**/*.h'
    # core.frameworks = 'UIKit', 'MapKit'
    core.dependency 'TKModule'
    core.dependency 'TKMResourceManager'
    core.dependency 'TKMInfoManager'
    
    core.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end
  s.default_subspec = 'Core'
end
