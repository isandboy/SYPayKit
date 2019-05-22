#
# Be sure to run `pod lib lint SYPayKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYPayKit'
  s.version          = '0.1.1'
  s.summary          = '集成微信、银联、支付宝支付'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    1. 集成微信、银联、支付宝三种支付方式
    2. 对外抽象统一接口
    3. 支持OC，Swift项目，可以打包成动态库
                     DESC

  s.homepage         = 'https://github.com/isandboy/SYPayKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'isandboy' => 'sandboylu@gmail.com' }
  s.source           = { :git => 'https://github.com/isandboy/SYPayKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SYPayKit/SYPayKit.h'

  s.subspec 'Core' do |ss|
    ss.source_files = 'SYPayKit/Core/*.{h,m,c,swift}'
    ss.frameworks = 'CFNetwork', 'SystemConfiguration'
  end

  s.subspec 'Alipay' do |ss|
    ss.source_files = 'SYPayKit/Channels/Alipay/*.{h,m}'
    ss.dependency 'SYPayKit/Core'
    ss.dependency 'SYAlipaySDK'
  end

  s.subspec 'WXPay' do |ss|
    ss.source_files = 'SYPayKit/Channels/WxPay/**/*.{h,m}'
    ss.dependency 'SYPayKit/Core'
    ss.dependency 'SYWechatOpenSDK'
  end

  s.subspec 'UnionPay' do |ss|
    ss.source_files = 'SYPayKit/Channels/UnionPay/**/*.{h,m}'
    ss.dependency 'SYPayKit/Core'
    ss.dependency 'SYUPPaySDK/PayWallet'
  end

  s.subspec 'UnionApplePay' do |ss|
    ss.source_files = 'SYPayKit/Channels/UnionApplePay/**/*.{h,m}'
    ss.dependency 'SYPayKit/Core'
    ss.dependency 'SYUPPaySDK/ApplyPay'
end

  # s.subspec 'ApplePay' do |ss|
  #   ss.source_files = 'SYPayKit/Channels/ApplePay/*.{h,m}'
  #   ss.vendored_libraries = 'SYPayKit/Channels/ApplePay/**/*.a'
  #   ss.dependency 'SYPayKit/Core'
  #   ss.frameworks = 'PassKit', 'CFNetwork', 'SystemConfiguration'
  # end

# s.subspec 'InAppPurchase' do |ss|
#   ss.source_files = 'EMPayKit/Channels/InAppPurchase/**/*.{h,m,c,swift}'
#   ss.dependency 'EMSpeed/Network'
# end

end
