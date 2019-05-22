//
//  SYPayment.h
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import <Foundation/Foundation.h>
#import "SYPayDefaultConfigurator.h"

NS_ASSUME_NONNULL_BEGIN

extern NSInteger const kSYPayErrorCode;
extern NSString * const kSYPayOrderKey;
extern NSString * const kSYPaySuccessMessage;
extern NSString * const kSYPayFailureMessage;
extern NSString * const kSYPayCancelMessage;

/**
 *  支付结果状态
 */
typedef NS_ENUM(NSInteger, SYPayResultStatus) {
    /**
     *  成功
     */
    SYPayResultStatusSuccess,
    /**
     *  失败
     */
    SYPayResultStatusFailure,
    /**
     *  取消
     */
    SYPayResultStatusCancel,
    /**
     *  正在处理中（目前只有阿里支付有用，对应的是正在处理中）
     */
    SYPayResultStatusProcessing,
    
    /**
     *  银联苹果支付，使用该状态判断
     *  支付取消，交易已发起，状态不确定，商户需查询商户后台确认支付状态
     */
    SYPayResultStatusUnknownCancel,
    /**
     *  第三方支付app未安装
     *  目前只有微信需要判断，支付宝和银联支持网页支付
     */
    SYPayResultStatusUnInstall
};

typedef void(^SYPayResultHandle)(SYPayResultStatus status, NSDictionary * __nullable returnedInfo, NSError * __nullable error);

@protocol SYPayment <NSObject>

@required

- (void)prepareWithSettings:(SYPayDefaultConfigurator *)payDefaultConfigurator;

/**
 *  生成支付订单
 *
 *  @param charge Charge 对象(JSON 格式字符串 或 NSDictionary)
 */
- (NSObject *)generatePayOrder:(NSDictionary *)charge;

- (void)jumpToPay:(NSObject *)order result:(SYPayResultHandle)resultHandle;

- (void)jumpToPay:(NSObject *)order viewController:(nullable UIViewController*)viewController result:(SYPayResultHandle)resultHandle;

@optional

/*! @brief 检查第三方支付App是否已被用户安装
 *
 * @return 已安装返回YES，未安装返回NO。
 */
- (BOOL)isAppInstalled;

- (BOOL)handleOpenURL:(NSURL *)url;

- (BOOL)registerApp:(NSString *)appid;

- (void)setDebugMode:(BOOL)enabled;
    
// 苹果公司分配的商户号,表示调用Apple Pay所需要的MerchantID;
@property (nonatomic, copy) NSString *merchantID;

@end

@interface SYPayment : NSObject<SYPayment>

// 应用注册scheme,在AlixPayDemo-Info.plist定义URL types
@property (nonatomic, copy) NSString *appScheme;
    
@property (nonatomic, copy) SYPayResultHandle payResultHandle;

@end

NS_ASSUME_NONNULL_END
