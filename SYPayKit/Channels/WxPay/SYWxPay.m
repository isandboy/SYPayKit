//
//  SYWxPay.m
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import "SYWxPay.h"
#import "WxApi.h"

@interface SYWxPay()<WXApiDelegate>

@end

@implementation SYWxPay

- (BOOL)isAppInstalled {
    return [WXApi isWXAppInstalled];
}

- (BOOL)registerApp:(NSString *)appid {
    return [WXApi registerApp:appid];
}

- (void)prepareWithSettings:(SYPayDefaultConfigurator *)payDefaultConfigurator {
    [super prepareWithSettings:payDefaultConfigurator];    
    [self registerApp:payDefaultConfigurator.wxPayAppId];
}

- (NSObject *)generatePayOrder:(NSDictionary *)charge {
//    NSDictionary *orderDic = (NSDictionary *)[super generatePayOrder:charge];
    //调起微信支付
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = [charge objectForKey:@"partnerid"];
    req.prepayId = [charge objectForKey:@"prepayid"];
    req.nonceStr = [charge objectForKey:@"noncestr"];
    req.timeStamp = [[charge objectForKey:@"timestamp"] intValue];
    req.package = [charge objectForKey:@"packagevalue"];             //由于Android那变package是关键字，所以后台此字段定义成packagevalue
    req.sign = [charge objectForKey:@"sign"];
    return req;
}

/**
 *  微信支付
 *  success：YES,去后端验证，否则提示用户支付失败信息
 *  注意：不能success=YES，作为用户支付成功的结果，应以服务器端的接收的支付通知或查询API返回的结果为准
 *  @param parmsList  后台返回来的预支付订单的各个参数
 *  @param completion 回调到客户端
 */
- (void)jumpToPay:(NSObject *)order result:(SYPayResultHandle)resultHandle{
    if (![WXApi isWXAppInstalled]) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(SYWxPay.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:@"应用未安装"}];
        resultHandle(SYPayResultStatusUnInstall, nil, error);
        return;
    } else if (![WXApi isWXAppSupportApi]) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:@"该版本微信不支持支付"}];
        resultHandle(SYPayResultStatusCancel, nil, error);
        return;
    }
    //调起微信支付
    PayReq *req = (PayReq *)order;
    [WXApi sendReq:req];
    //日志输出
    
#ifdef DEBUG
    NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@", req.partnerId, req.prepayId, req.nonceStr, (long)req.timeStamp, req.package, req.sign);
#endif
    self.payResultHandle = resultHandle;
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        SYPayResultStatus payResultStatus = SYPayResultStatusFailure;
        switch (resp.errCode) {
            case WXSuccess:
                //支付成功，去商家后台去验证
                payResultStatus = SYPayResultStatusSuccess;
                break;
            case WXErrCodeCommon: {
                //可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
                payResultStatus = SYPayResultStatusFailure;
            }
                break;
            case WXErrCodeUserCancel: {
                //无需处理。发生场景：用户不支付了，点击取消，返回APP。
                payResultStatus = SYPayResultStatusCancel;
            }
            default:
                break;
        }
        
        NSDictionary *errorDic = [self errorMessage];
        NSString *errorStr = resp.errStr;
        if (!errorStr) {
            errorStr = errorDic[@(resp.errCode)];
        }
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:kSYPayErrorCode userInfo:@{NSLocalizedDescriptionKey:errorStr}];
    
        self.payResultHandle(payResultStatus, errorDic, error);
    }
}

- (BOOL)handleOpenURL:(NSURL *)url {
    NSString *urlString = [url absoluteString];
    BOOL can = [urlString rangeOfString:@"wx"].location != NSNotFound;
    if (can && [urlString rangeOfString:@"pay"].location != NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
}

- (NSDictionary *)errorMessage {
    return @{@(WXSuccess):              kSYPaySuccessMessage,
             @(WXErrCodeCommon):        kSYPayFailureMessage,
             @(WXErrCodeUserCancel):    kSYPayCancelMessage};
}

@end
