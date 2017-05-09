//
//  SYPay.m
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import "SYPay.h"

@interface SYPay ()

@property (nonatomic, strong) SYPayment *payment;

@end

@implementation SYPay

/**
 *  单例支付类
 *
 *  @return 支付对象
 */
+ (instancetype)pay {
    static dispatch_once_t onceToken;
    static SYPay *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SYPay alloc] init];
    });
    return instance;
}

+ (void)payment:(SYPayment *)payment withOrderInfo:(NSDictionary *)charge withCompletion:(SYPayResultHandle)handle {
    [self payment:payment withOrderInfo:charge viewController:nil withCompletion:handle];
}

+ (void)payment:(SYPayment *)payment withOrderInfo:(NSDictionary *)charge viewController:(nullable UIViewController *)viewController withCompletion:(SYPayResultHandle)handle {
    
    SYPay *pay = [SYPay pay];
    
    if (pay.payment) {
        pay.payment = nil;
    }
    pay.payment = payment;
    
    if ([pay.payment respondsToSelector:@selector(prepareWithSettings:)]) {
        [pay.payment prepareWithSettings:pay.payDefaultConfigurator];
    }
    
    NSObject *order = [pay.payment generatePayOrder:charge];
    [pay.payment jumpToPay:order viewController:viewController result:handle];
}

+ (BOOL)handleOpenURL:(NSURL *)URL sourceApplication:(nullable NSString *)application {
    return [[SYPay pay].payment handleOpenURL:URL];
}

+ (void)setDebugMode:(BOOL)enabled {
    [[SYPay pay].payment setDebugMode:enabled];
}

//+ (BOOL)isAppInstalled {
//    return [[SYPay sharedPay].payment isAppInstalled];
//}

@end

