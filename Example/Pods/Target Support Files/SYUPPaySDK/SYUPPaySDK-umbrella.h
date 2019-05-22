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

#import "UPAPayPlugin.h"
#import "UPAPayPluginDelegate.h"
#import "SYUPApplePayDummy.h"
#import "UPPaymentControl.h"
#import "SYUPPayDummy.h"

FOUNDATION_EXPORT double SYUPPaySDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SYUPPaySDKVersionString[];

