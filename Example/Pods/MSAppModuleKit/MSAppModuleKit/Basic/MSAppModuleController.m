//
//  MSAppModuleManager.m
//  Pods
//
//  Created by ryan on 15/10/19.
//
//

#import "MSAppModuleController.h"
#import "MSAppModule.h"
#import <JLRoutes/JLRoutes.h>
#import <MSRoutes/MSRoutes.h>

typedef NS_ENUM (NSUInteger, MSAppModuleLoadPriority) {
    MSAppModuleLoadPriorityHigh = 0,
    MSAppModuleLoadPriorityUI   = 500,
    MSAppModuleLoadPriorityLow  = 1000
};

NSString const *MSAppModuleSettingDidChangeNotification = @"MSAppModuleSettingDidChangeNotification";

MSAppModuleController *appModuleManager;

@interface MSAppModuleController ()

@property (nonatomic, strong) JLRoutes *routes;
@property (nonatomic, strong, readwrite) id<MSAppSettings> appSettings;

@end

@implementation MSAppModuleController

+ (void)load {
    [MSAppModuleController defaultAppModuleManager];
}

+ (instancetype)defaultAppModuleManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appModuleManager = [[self alloc] init];
    });
    return appModuleManager;
}

+ (instancetype)appModuleControllerWithSettings:(id<MSAppSettings>)appSettings {
    [MSAppModuleController defaultAppModuleManager].appSettings = appSettings;

    return appModuleManager;
}

- (id<MSAppModule>)appModuleWithModuleName:(NSString *)moduleName {
    Class moduleClass = NSClassFromString(moduleName);
    return [self appModuleWithModuleClass:moduleClass];
}


- (id<MSAppModule>)appModuleWithModuleClass:(Class)moduleClass {
    for(MSAppModule *module in _modules) {
        if([module class] == moduleClass) {
            return module;
        }
    }
    return nil;
}


- (instancetype)init {
    if (self = [super init]) {
        _modules = [NSMutableArray array];
        _idModuleDict = [NSMutableDictionary dictionary];
        self.routes = [JLRoutes globalRoutes];
    }
    return self;
}

- (BOOL)openURL:(NSURL *)URL sourceApplication:(NSString *)app annotation:(id)annotation navigation:(id)arg4 {

    for(MSAppModule *module in _modules) {
        BOOL rs = [module openURL:URL sourceApplication:app annotation:annotation navigation:arg4];
        if(rs) {
            return YES;
        }
    }
    
    [self.routes routeURL:URL];
    
    return YES;
}

- (void)addModulesFromPlist:(NSString *)plistFile {
    NSArray *classArray = [NSArray arrayWithContentsOfFile:plistFile];
    for(NSString *classname in classArray) {
        [self addModule:[NSClassFromString(classname) new]];
    }
}

- (void)addModuleWithClasses:(NSArray *)moduleClasses {
    for(Class moduleClass in moduleClasses) {
        [self addModuleWithClass:moduleClass];
    }
}

- (void)removeModuleWithClass:(Class)moduleClasses {
    MSAppModule *module = nil;
    
    for(MSAppModule *e in self.modules) {
        if([e isKindOfClass:moduleClasses]) {
            module = e;
            break;
        }
    }
    [self removeModule:module];
}

- (void)addModuleWithClass:(Class)moduleClasses {
    MSAppModule *module = [[moduleClasses alloc] init];
    [self addModule:module];
}


- (void)addModules:(NSArray *)modules {
    for(MSAppModule *module in modules) {
        [self addModule:module];
    }
}

- (void)removeModule:(MSAppModule *)module {
    [_modules removeObject:module];
    if([module respondsToSelector:@selector(moduleDidUnload:)]) {
        [module moduleDidUnload:self.appSettings];
    }
    
    [self unregisterRoutesWithModule:module];
}

- (void)addModule:(MSAppModule *)module {
    if (!module || [_modules containsObject:module]) {
        return;
    }
    NSAssert(self.appSettings, @"the appSettings is nil, set it before load modules");
    
    [_modules addObject:module];
    if([module respondsToSelector:@selector(moduleDidLoad:)]) {
        [module moduleDidLoad:self.appSettings];
    }
    
    if ([module respondsToSelector:@selector(isLoaded)]) {
        @try {
            [module setValue:@(YES) forKey:@"isLoaded"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@ has no setter or ivar for its bridge, which is not "
                        "permitted. You must either @synthesize the bridge property, "
                  "or provide your own setter method.", [module class]);
        }

    }
    
    [self registerRoutesWithModule:module];
}

- (void)registerRoutesWithModule:(MSAppModule *)module {
    if ([module respondsToSelector:@selector(plistRoutes)]) {
        NSDictionary *routes = [module plistRoutes];
        [self.routes registerRoutes:routes];
    }
    
    if([module respondsToSelector:@selector(moduleRegisterRoutes:)]) {
        [module moduleRegisterRoutes:self.routes];
    }
}

- (void)unregisterRoutesWithModule:(MSAppModule *)module {
    if ([module respondsToSelector:@selector(plistRoutes)]) {
        NSDictionary *routes = [module plistRoutes];
        [self.routes unregisterRoutes:routes];
    }

    if([module respondsToSelector:@selector(moduleUnregisterRoutes:)]) {
        [module moduleUnregisterRoutes:self.routes];
    }
}

- (void)handleNotification:(NSNotification *)notification sourceModuleClass:(Class)sourceModuleClass {
    for(MSAppModule *module in _modules) {
        if (![module isMemberOfClass:sourceModuleClass]) {
            if([module respondsToSelector:@selector(moduleDidReceiveNofication:)]) {
                [module moduleDidReceiveNofication:notification];
            }
        }
    }
}

- (void)handleNotification:(NSNotification *)notification sourceModule:(id<MSAppModule>)sourceModule {
    [self handleNotification:notification sourceModuleClass:[sourceModule class]];
}

//MARK: - Life Cycle
- (void)applicationDidEnterBackground {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidEnterBackground:)]) {
            [module moduleDidEnterBackground:self.appSettings];
        }
    }
}

- (void)applicationWillEnterForeground {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleWillEnterForeground:)]) {
            [module moduleWillEnterForeground:self.appSettings];
        }
    }
}

- (void)applicationWillTerminate {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleWillTerminate:)]) {
            [module moduleWillTerminate:self.appSettings];
        }
    }
}

- (void)applicationDidBecomeActive {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidBecomeActive:)]) {
            [module moduleDidBecomeActive:self.appSettings];
        }
    }
}

- (void)applicationWillResignActive {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleWillResignActive:)]) {
            [module moduleWillResignActive:self.appSettings];
        }
    }
}

- (void)applicationDidReceiveMemoryWarning {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidReceiveMemoryWarning:)]) {
            [module moduleDidReceiveMemoryWarning:self.appSettings];
        }
    }
}

//MARK: - Notification
- (void)applicationDidRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidRegisterUserNotificationSettings:)]) {
            [module moduleDidRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

- (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [module moduleDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidFailToRegisterForRemoteNotificationsWithError:)]) {
            [module moduleDidFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidReceiveRemoteNotification:)]) {
            [module moduleDidReceiveRemoteNotification:userInfo];
        }
    }
}

- (void)applicationDidReceiveLocalNotification:(UILocalNotification *)notification {
    for(MSAppModule *module in _modules) {
        if([module respondsToSelector:@selector(moduleDidReceiveLocalNotification:)]) {
            [module moduleDidReceiveLocalNotification:notification];
        }
    }
}


@end
