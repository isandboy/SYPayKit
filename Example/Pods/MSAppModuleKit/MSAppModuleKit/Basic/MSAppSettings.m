//
//  MSAppSettings.m
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import "MSAppSettings.h"

@implementation MSAppSettings

+ (instancetype)appSettings {
    return [self sharedAppSettings];
}

+ (instancetype)sharedAppSettings {
    static MSAppSettings *settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

@end
