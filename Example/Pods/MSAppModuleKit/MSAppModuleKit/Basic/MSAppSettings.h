//
//  MSAppSettings.h
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSAppSettings <NSObject>

@optional
@property (nonatomic, strong, readwrite) NSString *mainURLScheme;
@property (nonatomic, strong) NSArray<NSString *> *supportsURLSchemes;

@end


// @abstract
@interface MSAppSettings : NSObject <MSAppSettings>

// `+appSettings` is gone when converted to Swift
//
+ (instancetype)appSettings; // __deprecated;
+ (instancetype)sharedAppSettings;

@end
