//
//  MSRouteItem.m
//  Pods
//
//  Created by ryan on 16/1/8.
//
//

#import "MSRouteItem.h"

@implementation MSRouteItem

+ (instancetype)routeItemWithPattern:(NSString *)pattern handler:(MSRouteItemHandler)handler {
    MSRouteItem *item = [[self alloc] init];
    item.routePattern = pattern;
    item.handlerBlock = handler;
    
    return item;
}

@end
