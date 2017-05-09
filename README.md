# SYPayKit

[![CI Status](http://img.shields.io/travis/isandboy/SYPayKit.svg?style=flat)](https://travis-ci.org/isandboy/SYPayKit)
[![Version](https://img.shields.io/cocoapods/v/SYPayKit.svg?style=flat)](http://cocoapods.org/pods/SYPayKit)
[![License](https://img.shields.io/cocoapods/l/SYPayKit.svg?style=flat)](http://cocoapods.org/pods/SYPayKit)
[![Platform](https://img.shields.io/cocoapods/p/SYPayKit.svg?style=flat)](http://cocoapods.org/pods/SYPayKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SYPayKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SYPayKit"
```

默认包含支付宝、微信、银联支付

目前支持以下几种支付方式

Alipay （支付宝）

WXPay（微信）

UnionPay（银联）

```
pod 'EMPayKit/Alipay'
pod 'EMPayKit/WXPay'
pod 'EMPayKit/UnionPay'
```
## 使用
目前支持的支付方式有，支付宝支付，微信支付，银联支付
```
SYUnionPay *alipay = [[SYUnionPay alloc] init];
NSDictionary *order = @{kMSPayOrderKey:@"201606221028315777129"};
[SYPay payment:payment withOrderInfo:nil withCompletion:^(SYPayResultStatus status, NSDictionary * _Nullable returnedInfo, NSError * _Nullable error) {
    NSLog(@"success:%d\n,resultDic:%@\n,error:%@", success, returnedInfo, [error localizedDescription]);
}];

```

参数说明：

1. 其中payment是对应的支付方式的实例
2. charge参数需要和后台约定成以下格式

```
# 支付宝支付order
{
		kMSPayOrderKey: "partner=\"2088811768954504\"&seller_id=\"emoney_mobile@126.com\"&out_trade_no=\"EM12016062210000018\"&subject=\"问股查看答案\"&body=\"问股\"&total_fee=\"0.01\"&notify_url=\"http://mpay.emoney.cn/alipay/notify\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&sign=\"a1DGJPY5VXjF9FGP5yCZFkuBnnw04JX%2fH5bPd4iZMj7gdnbIpwS8CSgHoxqeKzdycixKEi0wpL1FEiLoSAsdWX%2bFOYt5TWsiSnDbj%2fp4CEN%2fhjgtJdyDL6lpHN1fvn%2buBgob0gPV8g94jKo4VGFCLsT5wdjcXTys67qCA9Lrqyo%3d\"&sign_type=\"RSA\"&appenv=\"system= ^version=\"&goods_type=\"0\"&rn_check=\"F\""
  }

# 微信支付order

{ kMSPayOrderKey: {
			"appid": "wx85e5bbec559cd907",
			"partnerid": "1346821701",
			"noncestr": "eUgl4tZQ3nEAHmPkPeZOX25Aml",
			"prepayid": "wx2016062210571811a9bf574f0862648129",
			"packagevalue": "Sign=WXPay",
			"timestamp": "1466593038",
			"sign": "768FE57DA40625D37A85D05564E9B78E"
		}
}

# 银联支付order
{kMSPayOrderKey:@"201606221028325787138" }
```
更详细的情况可以参考demo里面的SYPayManager类

## 其他

iOS 9 以上版本如果需要使用支付宝和微信渠道，需要在 Info.plist 添加以下代码：
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>weixin</string>
    <string>wechat</string>
    <string>alipay</string>
</array>
```

## Author

isandboy, sandboylu@gmail.com

## License

SYPayKit is available under the MIT license. See the LICENSE file for more info.
