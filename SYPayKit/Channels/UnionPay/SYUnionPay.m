//
//  SYUnionPay.m
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import "SYUnionPay.h"

@import SYUPPaySDK;

static NSString *const kUnionPayStatusSuccess = @"success";
static NSString *const kUnionPayStatusFailure = @"fail";
static NSString *const kUnionPayStatusCancel = @"cancel";

static NSString *const kModeDevelopment = @"01";
static NSString *const kModeDistribute = @"00";

@interface SYUnionPay ()

@property (nonatomic, copy) NSString *tnMode;

@end

@implementation SYUnionPay

- (void)setDebugMode:(BOOL)enabled {
    self.tnMode = enabled ? kModeDevelopment : kModeDistribute;
}

- (void)jumpToPay:(NSString *)order viewController:(UIViewController *)viewController result:(SYPayResultHandle)resultHandle {
    self.payResultHandle = resultHandle;
    if (order && order.length > 0) {
        self.tnMode = self.tnMode ?: kModeDistribute;
        [[UPPaymentControl defaultControl] startPay:order fromScheme:self.appScheme mode:self.tnMode viewController:viewController];
    } else {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:kSYPayFailureMessage}];
        self.payResultHandle(SYPayResultStatusFailure, nil, error);
    }
}

- (BOOL)handleOpenURL:(NSURL *)url {
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        NSString *errorDescription = @"";
        SYPayResultStatus payresultStatus = SYPayResultStatusFailure;
        //结果code为成功时，先校验签名，校验成功后做后续处理
        if ([code isEqualToString:kUnionPayStatusSuccess]) {
            errorDescription = kSYPaySuccessMessage;
            payresultStatus = SYPayResultStatusSuccess;
        } else if ([code isEqualToString:kUnionPayStatusFailure]) {
            errorDescription = kSYPayFailureMessage;
            payresultStatus = SYPayResultStatusFailure;
            //交易失败
        } else if ([code isEqualToString:kUnionPayStatusCancel]) {
            //交易取消
            errorDescription = kSYPayCancelMessage;
            payresultStatus = SYPayResultStatusCancel;
        }
        
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:errorDescription}];
        self.payResultHandle(payresultStatus, data, error);
    }];
    return YES;
}

@end
