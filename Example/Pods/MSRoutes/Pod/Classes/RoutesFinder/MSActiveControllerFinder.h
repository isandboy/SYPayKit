//
//  MSActiveControllerFinder.h
//  EMStock
//
//  Created by ryan on 3/10/16.
//  Copyright © 2016 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UIViewController *(^ActiveTopController)(void);
typedef UINavigationController *(^ActiveNavigationController)(void);
typedef UITabBarController *(^ActiveTabBarController)(void);
typedef void (^FinderResetStatus)(void);


@protocol MSActiveControllerFinder <NSObject>

@property (nonatomic, copy) ActiveTopController activeTopController;
@property (nonatomic, copy) ActiveNavigationController activeNavigationController;
@property (nonatomic, copy) ActiveTabBarController activeTabBarController;
@property (nonatomic, copy) ActiveTabBarController rootTabBarController;
@property (nonatomic, copy) FinderResetStatus resetStatus;

@end

@interface MSActiveControllerFinder : NSObject <MSActiveControllerFinder>

@property (nonatomic, copy) ActiveTopController activeTopController;
@property (nonatomic, copy) ActiveNavigationController activeNavigationController;
@property (nonatomic, copy) ActiveTabBarController activeTabBarController;
@property (nonatomic, copy) ActiveTabBarController rootTabBarController;
@property (nonatomic, copy) FinderResetStatus resetStatus;

//
// 注意使用+sharedFinder, +setSharedFinder: 代替+finder, +setFinder:
// 后面会显式淘汰
//
+ (void)setSharedFinder:(id<MSActiveControllerFinder>)finder;
+ (instancetype)sharedFinder;

+ (void)setFinder:(id<MSActiveControllerFinder>)finder;
+ (instancetype)finder;

@end
