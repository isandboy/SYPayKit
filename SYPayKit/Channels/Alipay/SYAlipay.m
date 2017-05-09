//
//  SYAlipay.m
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import "SYAlipay.h"
#import <AlipaySDK/AlipaySDK.h>

@interface SYAlipay ()

@property (nonatomic, copy) NSString *charge;

@end

@implementation SYAlipay

- (void)jumpToPay:(NSObject *)order viewController:(UIViewController *)viewController result:(SYPayResultHandle)resultHandle {
    
    self.charge = (NSString *)order;
    self.payResultHandle = resultHandle;
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    [[AlipaySDK defaultService] payOrder:(NSString *)order fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
        [self parse:resultDic];
    }];
}

- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
#ifdef DEBUG
            NSLog(@"result = %@", [[self class] returnErrorMessage:[[resultDic objectForKey:@"resultStatus"] integerValue]]);
#ifdef DEBUG
            [self parse:resultDic];
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]) {//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self parse:resultDic];
        }];
    }
    return YES;
}

- (void)parse:(NSDictionary *)resultDic {
#ifdef DEBUG
    NSLog(@"reslut = %@", resultDic);
#endif
    SYPayResultStatus status;
    NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
    if (resultStatus == 6001) {
        status = SYPayResultStatusCancel;
    } else if (resultStatus == 9000) {
        status = SYPayResultStatusSuccess;
    } else if (resultStatus == 8000) {
        status = SYPayResultStatusProcessing;
    } else {
        status = SYPayResultStatusFailure;
    }
    
    if (!resultDic || ![resultDic isKindOfClass:[NSDictionary class]]) {
        status = SYPayResultStatusFailure;
    }
    NSString *result = resultDic[@"result"];
    
    if (result && result.length) {
        
        NSDictionary *resultOrderDic = [[self class] separated:result byString:@"&"];
        NSString *validSuccess = resultOrderDic[@"success"];
        
        if (resultStatus == 9000 && [validSuccess isEqualToString:@"\"true\""]) {
            status = SYPayResultStatusSuccess;
        } else if (resultStatus == 6001){
            status = SYPayResultStatusCancel;
        } else if (resultStatus == 4000){
            status = SYPayResultStatusFailure;
        } else if (resultStatus == 8000) {
            status = SYPayResultStatusProcessing;
        }
    }
    
    //    NSString *memo = resultDic[@"memo"];
    NSString *message = [[self class] returnErrorMessage:resultStatus];
    
    NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:message}];    
    self.charge = nil;
    self.payResultHandle(status, resultDic, error);
}

+ (NSString *)returnErrorMessage:(NSInteger)status {
    NSDictionary *errorDic = [[self class] errrorMessage];
    NSString *message = errorDic[@(status)];
    if (!message) {
        message = @"未知错误";
    }
    return message;
}

+ (NSDictionary *)errrorMessage {
    return @{@9000: @"订单支付成功",
             @8000: @"正在处理中",
             @4000: @"订单支付失败",
             @6001: @"用户中途取消",
             @6002: @"网络连接出错"};
}

+ (NSDictionary *)separated:(NSString *)string byString:(NSString *)byString{
    NSAssert(string, @"string cann't be nil");
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *aa = string;
    NSArray *aaArray = [aa componentsSeparatedByString:byString];
    for (NSString *bb in aaArray) {
        NSRange range = [bb rangeOfString:@"="];
        NSString *key = [bb substringToIndex:(int)(range.location)];
        NSString *value = [bb substringFromIndex:(int)(range.location+1)];
        [dic setValue:value forKey:key];
    }
    return dic;
}

@end
