//
//  JLRoutes+Ext.m
//  Pods
//
//  Created by ryan on 17/11/2016.
//
//

#import "JLRoutes+plist.h"
#import "JLRoutes+Finder.h"

@implementation JLRoutes (Plist)

- (void)registerRoutesPlist:(NSString *)plistFile {
    if (plistFile == nil) {
        return;
    }
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    [self registerRoutes:plist];
}

- (void)unregisterRoutesPlist:(NSString *)plistFile {
    if (plistFile == nil) {
        return;
    }
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    [self unregisterRoutes:plist];
}

- (void)registerRoutes:(NSDictionary *)routes {
    for(NSString *URL in routes) {
        [self registerRoute:URL pushingControllerName:routes[URL]];
    }
}

- (void)unregisterRoutes:(NSDictionary *)routes {
    for(NSString *URL in routes) {
        [self removeRoute:URL];
    }
}


@end
