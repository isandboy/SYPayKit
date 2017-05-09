//
//  MSRouteItem.h
//  Pods
//
//  Created by ryan on 16/1/8.
//
//

#import <Foundation/Foundation.h>

typedef BOOL (^MSRouteItemHandler) (NSDictionary *parameters);

@interface MSRouteItem : NSObject

@property (nonatomic, copy)NSString *routePattern;
@property (nonatomic, copy)MSRouteItemHandler handlerBlock;

+ (instancetype)routeItemWithPattern:(NSString *)pattern handler:(MSRouteItemHandler)handler;

@end
