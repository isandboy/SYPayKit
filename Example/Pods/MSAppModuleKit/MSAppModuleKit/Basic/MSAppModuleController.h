//
//  MSAppModuleManager.h
//  Pods
//
//  Created by ryan on 15/10/19.
//
//

#import <Foundation/Foundation.h>
#import "MSModuleDefines.h"
#import "MSAppSettings.h"
#import "MSAppModule.h"

MS_MODULE_EXTERN NSString *MSAppModuleSettingDidChangeNotification; //TODO: 设置

@class MSAppModuleController;
@class MSAppModule;
@protocol MSAppModule;
@protocol MSAppSettings;

MS_MODULE_EXTERN MSAppModuleController *appModuleManager;

@interface MSAppModuleController : NSObject {
    NSMutableDictionary *_idModuleDict;
    unsigned short _lastModuleTag;
    NSMutableArray *_modules;
    NSMutableDictionary *_bookmarkModuleDict;
    NSMutableDictionary *_externalUrlSchemeDict;
}

@property (nonatomic, strong, readonly) id<MSAppSettings> appSettings;

+ (instancetype)appModuleControllerWithSettings:(id<MSAppSettings>)appSettings;

- (id<MSAppModule>)appModuleWithModuleName:(NSString *)moduleName;
- (id<MSAppModule>)appModuleWithModuleClass:(Class)moduleClass;

- (BOOL)openURL:(NSURL *)URL sourceApplication:(NSString *)sourceApp annotation:(id)arg3 navigation:(id)arg4;

/* Load module by Class */
- (void)addModuleWithClasses:(NSArray *)moduleClasses;
- (void)removeModuleWithClass:(Class)moduleClasses;
- (void)addModuleWithClass:(Class)moduleClasses;

/* Load module by Instance */
- (void)addModules:(NSArray *)modules;
- (void)removeModule:(MSAppModule *)module;
- (void)addModule:(MSAppModule *)module;
- (void)addModulesFromPlist:(NSString *)plistFile;

@property(readonly, nonatomic) NSArray *modules;


/** 
 * @brief Triger each module to update status
 * @param notification 
 * @param sourceModuleClass and sourceModule won't be notified
 */
- (void)handleNotification:(NSNotification *)notification sourceModuleClass:(Class)sourceModuleClass;
- (void)handleNotification:(NSNotification *)notification sourceModule:(id<MSAppModule>)sourceModule;

/*
 * These methods will forward to every module,
 * You don't have to process all calls in each module
 */
- (void)applicationDidEnterBackground;
- (void)applicationWillEnterForeground;
- (void)applicationWillTerminate;
- (void)applicationDidBecomeActive;
- (void)applicationWillResignActive;
- (void)applicationDidReceiveMemoryWarning;

//
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)applicationDidReceiveLocalNotification:(UILocalNotification *)notification NS_CLASS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's UNNotificationRequest") __TVOS_PROHIBITED;

- (void)applicationDidRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_CLASS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's UNNotificationRequest") __TVOS_PROHIBITED;
- (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;



@end
