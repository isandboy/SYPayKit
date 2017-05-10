//
//  SYPayManager.m
//  SYPayKit
//
//  Created by isandboy on 05/09/2017.
//  Copyright (c) 2017 isandboy. All rights reserved.
//

#import "SYPayManager.h"
#import <SYPayKit/SYPayKit.h>

NSString *const kMSPayResultMessage = @"kMSPayResultMessage";

static NSString *const kDefaultPayFailueMessage = @"订单支付失败";
static NSString *const kDefaultPaySuccessMessage = @"订单支付成功";
static NSString *const kDefaultPayCancelMessage = @"订单支付取消";
static NSString *const kDefaultPayProcessingMessage = @"系统原因还在等待支付结果确认";

static const NSInteger kDefaultPayFailueStatus = -1; //支付失败
static const NSInteger kDefaultPaySuccessStatus = 0; //支付成功
static const NSInteger kDefaultPayProcessingStatus = 2; //支付处理中
static const NSInteger kDefaultPayCancelStatus = 3; //支付取消

@implementation SYPayManager

+ (void)initialize {
    SYPayDefaultConfigurator *payDefalutConfigurator = [[SYPayDefaultConfigurator alloc] init];
    payDefalutConfigurator.appScheme = @"你的target的scheme";
    payDefalutConfigurator.wxPayAppId = @"在微信平台申请的appid";
    [SYPay setPayPayDefaultConfigurator:payDefalutConfigurator];
}

+ (void)pay:(NSDictionary *)orderInfo viewController:(UIViewController *)viewController completion:(SYPayResult)payResult {

    if (!orderInfo) {
        payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:kDefaultPayFailueMessage}, nil);
    }
    
    if (![orderInfo isKindOfClass:[NSDictionary class]]) {
        payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:kDefaultPayFailueMessage}, nil);
    }
    
    NSObject *data = orderInfo[@"data"];
    if (!data) {
        payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:kDefaultPayFailueMessage}, nil);
    }
    SYPayType payType = [orderInfo[@"type"] integerValue];
    
    NSMutableDictionary *orderDic = [NSMutableDictionary dictionary];
    
    switch (payType) {
        case SYPayTypeAlipay:
        case SYPayTypeWXPay:
        case SYPayTypeUnion: {
            orderDic[kSYPayOrderKey] = data;
        }
            break;
        default:
        {
            if (payResult) {
                payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:@"不支持该种支付类型"}, nil);
                return;
            }
        }
            break;
    }
    
    SYPayment *payment = [self payObject:payType];
    if (!payment) {
        payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:@"不支持该种支付类型"}, nil);
        return;
    }
    
    [SYPay payment:payment withOrderInfo:orderDic viewController:viewController withCompletion:^(SYPayResultStatus status, NSDictionary *returnedInfo, NSError *error) {
#ifdef DEBUG
        NSLog(@"success:%zd\n,resultDic:%@\n,error:%@", status, returnedInfo, [error localizedDescription]);
#endif
        NSString *message;
        if (error) {
            message = [error localizedDescription];
        }
        
        switch (status) {
            case SYPayResultStatusSuccess:
            {
                if (payType == SYPayTypeUnion && returnedInfo) {
                    payResult(kDefaultPaySuccessStatus, @{kMSPayResultMessage:message ?: kDefaultPaySuccessMessage}, returnedInfo);
                } else {
                    payResult(kDefaultPaySuccessStatus, @{kMSPayResultMessage:message ?: kDefaultPaySuccessMessage}, nil);
                }
            }
                break;
            case SYPayResultStatusCancel:
            {
                payResult(kDefaultPayCancelStatus, @{kMSPayResultMessage:message ?: kDefaultPayCancelMessage}, nil);
            }
                break;
            case SYPayResultStatusProcessing:
            {
                payResult(kDefaultPayProcessingStatus, @{kMSPayResultMessage:message ?: kDefaultPayProcessingMessage}, nil);
            }
                break;
            default:
            {
                payResult(kDefaultPayFailueStatus, @{kMSPayResultMessage:message ?: kDefaultPayFailueMessage}, nil);
            }
                break;
        }
    }];
}

+ (SYPayment *)payObject:(SYPayType)payType {
    SYPayment *payment = nil;
    switch (payType) {
        case SYPayTypeAlipay:
        {
            payment = [[SYAlipay alloc] init];
        }
            break;
        case SYPayTypeWXPay:
        {
            payment = [[SYWxPay alloc] init];
        }
            break;
        case SYPayTypeUnion:
        {
            payment = [[SYUnionPay alloc] init];
        }
            break;
        default:
            break;
    }
    return payment;
}

@end
