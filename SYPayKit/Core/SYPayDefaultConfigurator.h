//
//  SYPayDefaultConfigurator.h
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYPayDefaultConfigurator : NSObject

//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
@property (nonatomic, strong) NSString *appScheme;

#if __has_include(<SYPayKit/SYWxPay.h>)

//微信支付

/**
 *  微信支付的AppId
 */
@property (nonatomic, copy) NSString *wxPayAppId;

/**
 *  appdesc 应用附加信息，长度不超过1024字节
 */
@property (nonatomic, copy, nullable) NSString *WXAppdesc;

#endif

//#if __has_include(<SYPayKit/SYApplePay.h>)
//// 苹果支付
//@property (nonatomic, copy) NSString *appleMechantId;
//#endif

@end

NS_ASSUME_NONNULL_END

