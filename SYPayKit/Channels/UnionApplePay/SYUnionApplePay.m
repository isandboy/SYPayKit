//
//  SYUnionApplePay.m
//  SYPayKit
//
//  Created by Allen on 2019/5/22.
//

#import "SYUnionApplePay.h"

#import <PassKit/PassKit.h>
#import <SYUPPaySDK/UPAPayPlugin.h>

static NSString *const kModeDevelopment = @"01";
static NSString *const kModeDistribute = @"00";

@interface SYUnionApplePay () <UPAPayPluginDelegate>
    
@property (nonatomic, copy) NSString *tnMode;

@end

@implementation SYUnionApplePay
    
- (BOOL)isAppInstalled {
    if (@available(iOS 9.2, *)) {
        if([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay]] )
        {
            return YES;
        }
    } else {
        return NO;
    }
    return NO;
}
    
- (void)setDebugMode:(BOOL)enabled {
    self.tnMode = enabled ? kModeDevelopment : kModeDistribute;
}
    
- (void)jumpToPay:(NSString *)order viewController:(UIViewController *)viewController result:(SYPayResultHandle)resultHandle {
    self.payResultHandle = resultHandle;
    if (order && order.length > 0) {
        if (@available(iOS 9.2, *)) {
            if([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay]] )
            {
                [UPAPayPlugin startPay:order mode:self.tnMode viewController:viewController delegate:self andAPMechantID:self.merchantID];
            }
        } else {
            // Fallback on earlier versions
        }
    } else {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:kSYPayFailureMessage}];
        self.payResultHandle(SYPayResultStatusFailure, nil, error);
    }
}
    
-(void)UPAPayPluginResult:(UPPayResult *)result {
    NSString *errorDescription = @"";
    SYPayResultStatus payresultStatus = SYPayResultStatusFailure;

    if(result.paymentResultStatus == UPPaymentResultStatusSuccess) {
//        NSString *otherInfo = result.otherInfo? result.otherInfo : @"";
//        NSString *successInfo = [NSString stringWithFormat:@"支付成功\n%@",otherInfo]; [self showAlertMessage:successInfo];
        errorDescription = kSYPaySuccessMessage;
        payresultStatus = SYPayResultStatusSuccess;
    }
    else if(result.paymentResultStatus == UPPaymentResultStatusCancel) {
        errorDescription = result.errorDescription ?: kSYPayCancelMessage;
        payresultStatus = SYPayResultStatusCancel;
    }
    else if(result.paymentResultStatus == UPPaymentResultStatusFailure) {
        errorDescription = result.errorDescription ?: kSYPayFailureMessage;
        payresultStatus = SYPayResultStatusFailure;
    }
    else if(result.paymentResultStatus == UPPaymentResultStatusUnknownCancel) {
        //TODO UPPAymentResultStatusUnknownCancel表示发起支付以后用户取消，导致支付状态不确认，需 要查询商户后台确认真实的支付结果
//        NSString *errorInfo = [NSString stringWithFormat:@"支付过程中用户取消了，请查询后台确认订单"];
//        [self showAlertMessage:errorInfo];
        errorDescription = kSYPayCancelMessage;
        payresultStatus = SYPayResultStatusUnknownCancel;
    }

    NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:errorDescription}];
    self.payResultHandle(payresultStatus, nil, error);
}

    
- (BOOL)handleOpenURL:(NSURL *)url {
    return YES;
}
    
@end

