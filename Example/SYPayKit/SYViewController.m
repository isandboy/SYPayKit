//
//  SYViewController.m
//  SYPayKit
//
//  Created by isandboy on 05/09/2017.
//  Copyright (c) 2017 isandboy. All rights reserved.
//

#import "SYViewController.h"
@import SYPayKit;

@interface SYViewController ()

@end

@implementation SYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openUnionPay:(id)sender {
    SYUnionPay *unionPay = [[SYUnionPay alloc] init];
    [SYPay payment:unionPay withOrderInfo:@{kSYPayOrderKey: @"201506221028315777129"} withCompletion:^(SYPayResultStatus status, NSDictionary * _Nullable returnedInfo, NSError * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
