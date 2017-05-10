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
 kSYPayOrderKey: "partner=\"--------------\"&seller_id=\"-------------\"&out_trade_no=\"-----------\"&subject=\"areyouok\"&body=\"nama\"&total_fee=\"0.01\"&notify_url=\""&service=\"\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&sign=\"GsSZgPloF1vn52XAItRAldwQAbzIgkDyByCxMfTZG%2FMapRoyrNIJo4U1LUGjHp6gdBZ7U8jA1kljLPqkeGv8MZigd3kH25V0UK3Jc3C94Ngxm5S%2Fz5QsNr6wnqNY9sx%2Bw6DqNdEQnnks7PKvvU0zgsynip50lAhJmflmfHvp%2Bgk%3D\"&sign_type=\"RSA\"&appenv=\"system= ^version=\"&goods_type=\"0\"&rn_check=\"F\""
   }
 * 客户端不对order对应的value值做任何处理(改值是后台加密后的订单)，最后直接传给支付宝支付sdk
 * 2. 微信支付
 * { kSYPayOrderKey: {
 "appid": "wx-----------",
 "partnerid": "-----------",
 "noncestr": "-----------",
 "prepayid": "wx-----------",
 "packagevalue": "Sign=WXPay",
 "timestamp": "-----------",
 "sign": "-----------"
 }
 }
 * 3. 银联支付
 * {kSYPayOrderKey:@"--------------------" }
 *
 * @param viewController 发起支付页面的controller
 * @param 支付结果回调
 */

+ (void)pay:(NSDictionary *)orderInfo viewController:(UIViewController *)viewController completion:(SYPayResult)payResult;

@end
