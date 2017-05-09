//
//  SYPayment.m
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import "SYPayment.h"

const NSInteger kSYPayErrorCode = 100;
NSString * const kSYPaySuccessMessage = @"订单支付成功";
NSString * const kSYPayFailureMessage = @"订单支付失败";
NSString * const kSYPayCancelMessage = @"用户中途取消";
NSString * const kSYPayOrderKey = @"order";

@implementation SYPayment

- (void)prepareWithSettings:(SYPayDefaultConfigurator *)payDefaultConfigurator {
    self.appScheme = payDefaultConfigurator.appScheme;
}

- (NSObject *)generatePayOrder:(NSDictionary *)charge {
    if (charge) {
        return charge[kSYPayOrderKey];
    }
    return nil;
}

- (void)jumpToPay:(NSObject *)order result:(SYPayResultHandle)resultHandle {
    [self jumpToPay:order viewController:nil result:resultHandle];
}

- (void)jumpToPay:(NSObject *)order viewController:(nullable UIViewController*)viewController result:(SYPayResultHandle)resultHandle {
    resultHandle(NO, nil ,nil);
}

- (BOOL)isAppInstalled {
    return YES;
}

- (BOOL)handleOpenURL:(NSURL *)url {
    return YES;
}

- (BOOL)registerApp:(NSString *)appid {
    return YES;
}

- (void)setDebugMode:(BOOL)enabled {
    
}

//+ (NSDictionary *)jsonToDictionary:(id)json {
//    if (!json || json == (id)kCFNull) return nil;
//    NSDictionary *dic = nil;
//    NSData *jsonData = nil;
//    if ([json isKindOfClass:[NSDictionary class]]) {
//        dic = json;
//    } else if ([json isKindOfClass:[NSString class]]) {
//        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
//    } else if ([json isKindOfClass:[NSData class]]) {
//        jsonData = json;
//    }
//    
//    if (jsonData) {
//        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
//        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
//    }
//    return dic;
//}

@end
