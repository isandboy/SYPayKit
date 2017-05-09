//
//  SYPayKit.h
//  Pods
//
//  Created by Allen on 09/05/2017.
//
//

#ifndef SYPayKit_h
#define SYPayKit_h

#import <SYPayKit/SYPay.h>

#if __has_include(<SYPayKit/SYAlipay.h>)
#import <SYPayKit/SYAlipay.h>
#endif

#if __has_include(<SYPayKit/SYUnionPay.h>)
#import <SYPayKit/SYUnionPay.h>
#endif

#if __has_include(<SYPayKit/SYWxPay.h>)
#import <SYPayKit/SYWxPay.h>
#endif


#endif /* SYPayKit_h */
