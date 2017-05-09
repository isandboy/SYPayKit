//
//  SYPay.h
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#import <Foundation/Foundation.h>
#import "SYPayment.h"
#import "SYPayDefaultConfigurator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYPay : NSObject

/**
 * 支付配置
 */
+ (void)setPayPayDefaultConfigurator:(SYPayDefaultConfigurator *)payDefaultConfigurator;

/**
 *  支付调用接口(支付宝/微信)
 *  说明： *微信支付 success：YES,去后端验证，否则提示用户支付失败信息
 *  注意：不能success=YES，作为用户支付成功的结果，应以服务器端的接收的支付通知或查询API返回的结果为准
 *  @param charge           以kSYPayOrderKey为key的订单，对应的value为格式参考readme说明文档
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)payment:(SYPayment *)payment withOrderInfo:(NSDictionary *)charge withCompletion:(SYPayResultHandle)handle;

/**
 *  支付调用接口
 *
 *  @param charge           以kSYPayOrderKey为key的订单，对应的value为格式参考readme说明文档
 *  @param viewController   银联渠道需要
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)payment:(SYPayment *)payment withOrderInfo:(NSDictionary *)charge viewController:(nullable UIViewController *)viewController withCompletion:(SYPayResultHandle)handle;

/**
 *
 * @param URL : Handle URL responses from AppDelegate:HandleURL
 * - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
 回调
 */
+ (BOOL)handleOpenURL:(NSURL *)URL sourceApplication:(nullable NSString *)application;

/**
 * 设置是否是测试环境，银联支付有环境配置
 */
+ (void)setDebugMode:(BOOL)enabled;

///** @brief 检查第三方支付App是否已被用户安装
// *
// * @return 已安装返回YES，未安装返回NO。
// */
//+ (BOOL)isAppInstalled;

@end

NS_ASSUME_NONNULL_END
