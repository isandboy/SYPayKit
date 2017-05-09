//
//  SYPayManager.h
//  SYPayKit
//
//  Created by isandboy on 05/09/2017.
//  Copyright (c) 2017 isandboy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  支付类型
 */
typedef NS_ENUM(NSUInteger, SYPayType) {
    /**
     *  支付宝
     */
    SYPayTypeAlipay     = 1 << 0,
    /**
     *  微信
     */
    SYPayTypeWXPay      = 1 << 1,
    /**
     *  银联
     */
    SYPayTypeUnion      = 1 << 2,
};


typedef void(^SYPayResult)(NSInteger code, NSDictionary *result, NSObject *data);

extern NSString *const kMSPayResultMessage;

@interface SYPayManager : NSObject

/**
 * @param orderInfo
 * 1. 支付宝支付：数据格式为
 * {
 "order": "partner=\"2088811768954504\"&seller_id=\"emoney_mobile@126.com\"&out_trade_no=\"EM12016062210000018\"&subject=\"问股查看答案\"&body=\"问股\"&total_fee=\"0.01\"&notify_url=\"http://mpay.emoney.cn/alipay/notify\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&sign=\"a1DGJPY5VXjF9FGP5yCZFkuBnnw04JX%2fH5bPd4iZMj7gdnbIpwS8CSgHoxqeKzdycixKEi0wpL1FEiLoSAsdWX%2bFOYt5TWsiSnDbj%2fp4CEN%2fhjgtJdyDL6lpHN1fvn%2buBgob0gPV8g94jKo4VGFCLsT5wdjcXTys67qCA9Lrqyo%3d\"&sign_type=\"RSA\"&appenv=\"system= ^version=\"&goods_type=\"0\"&rn_check=\"F\""
   }
 * 客户端不对order对应的value值做任何处理(改值是后台加密后的订单)，最后直接传给支付宝支付sdk
 * 2. 微信支付
 * {
     "order": {
     "appid": "wx85e5bbec559cd907",
     "partnerid": "1346821701",
     "noncestr": "eUgl4tZQ3nEAHmPkPeZOX25Aml",
     "prepayid": "wx2016062210571811a9bf574f0862648129",
     "packagevalue": "Sign=WXPay",
     "timestamp": "1466593038",
     "sign": "768FE57DA40625D37A85D05564E9B78E"
     }
   }
 * 3. 银联支付
 * {"order":@"201606221028325787138"}
 *
 * @param viewController 发起支付页面的controller
 * @param 支付结果回调
 */

+ (void)pay:(NSDictionary *)orderInfo viewController:(UIViewController *)viewController completion:(SYPayResult)payResult;

@end
