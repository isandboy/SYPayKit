//
//  MSAppModule.m
//  Pods
//
//  Created by ryan on 15/10/19.
//
//

#import "MSAppModule.h"
#import <JLRoutes/JLRoutes.h>

NSString *const MSAppModuleUpdatesNotificationName = @"MSAppModuleUpdatesNotificationName";

@interface MSAppModule ()

@property(readwrite, nonatomic, strong) id <MSAppSettings> moduleSettings;

@end

@implementation MSAppModule

@synthesize isLoaded = _isLoaded;

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSString *)moduleId {
    return NSStringFromClass([self class]);
}

- (NSString *)moduleName {
    return NSStringFromClass([self class]);
}

- (NSString *)moduleVersion {
    return @"1.0";
}

- (void)moduleDidLoad:(id<MSAppSettings>)info {
    self.moduleSettings = info;
}

- (void)moduleDidUnload:(id<MSAppSettings>)info {
    self.moduleSettings = nil;
}

- (void)moduleDidEnterBackground:(id)info {
    
}

- (void)moduleWillEnterForeground:(id)info {
    
}

- (void)moduleWillTerminate:(id)info {
    
}

- (void)moduleSettingsDidChange:(NSDictionary *)settings {
    
}

- (void)moduleDidReceiveNofication:(NSNotification *)notification {
    
}

- (BOOL)openURL:(NSURL *)URL sourceApplication:(NSString *)app annotation:(id)arg3 navigation:(id/* <FBNavigation>*/)arg4 {
    return NO;
}


- (void)moduleDidRecieveNotification:(NSNotification *)notification {
    
}

- (void)handleAPNSWithPayLoad:(NSDictionary *)arg1 launchedByUser:(BOOL)arg2 {
    
}

- (void)moduleRegisterRoutes:(JLRoutes *)route {
}

- (void)moduleUnregisterRoutes:(JLRoutes *)route {
}

+ (NSDictionary *)plistWithFileName:(NSString *)fileName {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString *path = [bundle pathForResource:fileName ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@end
