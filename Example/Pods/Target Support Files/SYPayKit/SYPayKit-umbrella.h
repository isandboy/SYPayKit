#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SYPayKit.h"
#import "SYAlipay.h"
#import "SYPay.h"
#import "SYPayDefaultConfigurator.h"
#import "SYPayment.h"
#import "SYUnionApplePay.h"
#import "SYUnionPay.h"
#import "SYWxPay.h"

FOUNDATION_EXPORT double SYPayKitVersionNumber;
FOUNDATION_EXPORT const unsigned char SYPayKitVersionString[];

