//
//  JLRoutes+EMHelper.h
//  EMStock
//
//  Created by ryan on 6/1/16.
//  Copyright © 2016 flora. All rights reserved.
//

// 通过类名和路径注册跳转
// 只支持简单push和present
// 如果有特殊判断逻辑 就自行实现block里面的方法

#import <JLRoutes/JLRoutes.h>

@interface JLRoutes (Finder)

- (void)registerRoute:(NSString *)path pushingControllerName:(NSString *)controllerName;
- (void)registerRoute:(NSString *)path presentingControllerName:(NSString *)controllerName;

- (void)registerRoute:(NSString *)path pushingControllerClass:(Class)controllerClass;
- (void)registerRoute:(NSString *)path presentingControllerClass:(Class)controllerClass;

@end
