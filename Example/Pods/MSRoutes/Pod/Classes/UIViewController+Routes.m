//
//  UIViewController+Routes.m
//  client_eggorder_5
//
//  Created by Ryan Wang on 14-5-25.
//  Copyright (c) 2014年 tappal. All rights reserved.
//

#import "UIViewController+Routes.h"

@implementation UINavigationController (Routes)

- (void)pushViewControllerClass:(Class)controllerClass params:(NSDictionary *)params {
    UIViewController <UIViewControllerRouter>*controller;
    
    controller = [controllerClass alloc];
    if([controller respondsToSelector:@selector(initWithRouterParams:)]) {
        controller = [controller initWithRouterParams:params];
        [self pushViewController:controller animated:YES];
    } else {
        NSAssert(YES, @"Controller shouldn't be null,Check your code closely");
        controller = nil;
    }
}

@end



@implementation UIViewController (Routes)

- (void)presentViewControllerClass:(Class)controllerClass params:(NSDictionary *)params animated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController <UIViewControllerRouter>*controller;
    controller = [controllerClass alloc];
    if([controller respondsToSelector:@selector(initWithRouterParams:)]) {
        controller = [controller initWithRouterParams:params];
        [self presentViewController:controller animated:flag completion:completion];
    } else {
        NSAssert(YES, @"Controller shouldn't be null,Check your code closely");
        controller = nil;
    }
}

- (instancetype)initWithRouterParams:(NSDictionary *)params {
    if (self = [self init]) {
        
    }
    return self;
}


@end
