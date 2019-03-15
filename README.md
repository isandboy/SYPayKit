[详情介绍](https://isandboy.github.io/2017/07/30/SYPayKit%E7%AE%80%E4%BB%8B/)

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
pod 'SYPayKit/Alipay'
pod 'SYPayKit/WXPay'
pod 'SYPayKit/UnionPay'
```
## 使用
目前支持的支付方式有，支付宝支付，微信支付，银联支付
```
SYUnionPay *alipay = [[SYUnionPay alloc] init];
NSDictionary *order = @{kMSPayOrderKey:@"201506221028315777129"};
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
		kSYPayOrderKey: "partner=\"--------------\"&seller_id=\"-------------\"&out_trade_no=\"-----------\"&subject=\"areyouok\"&body=\"nama\"&total_fee=\"0.01\"&notify_url=\""&service=\"\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&sign=\"GsSZgPloF1vn52XAItRAldwQAbzIgkDyByCxMfTZG%2FMapRoyrNIJo4U1LUGjHp6gdBZ7U8jA1kljLPqkeGv8MZigd3kH25V0UK3Jc3C94Ngxm5S%2Fz5QsNr6wnqNY9sx%2Bw6DqNdEQnnks7PKvvU0zgsynip50lAhJmflmfHvp%2Bgk%3D\"&sign_type=\"RSA\"&appenv=\"system= ^version=\"&goods_type=\"0\"&rn_check=\"F\""
  }

# 微信支付order

{ kSYPayOrderKey: {
			"appid": "wx-----------",
			"partnerid": "-----------",
			"noncestr": "-----------",
			"prepayid": "wx-----------",
			"packagevalue": "Sign=WXPay",
			"timestamp": "-----------",
			"sign": "-----------"
		}
}

# 银联支付order
{kSYPayOrderKey:@"--------------------" }
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
