//
//  SYAlertViewFactory.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "SYAlertViewFactory.h"


@implementation SYAlertViewFactory

- (DJAbstractAlertView *)alertViewWithType:(NSString *)type {
    
    DJAbstractAlertView *alertView = nil;
    
    if ([type isEqualToString:kSYAlertViewType_SYLimitNoticeAlertView]) {
        alertView = [[SYLimitNoticeAlertView alloc] init];
    } else if ([type isEqualToString:kSYAlertViewType_SYAddFeeAlertView]) {
        alertView = [[SYAddFeeAlertView alloc] init];
    } else if ([type isEqualToString:kSYAlertViewType_SYDispatchingAddFreeAlertView]) {
        alertView = [[SYDispatchingAddFreeAlertView alloc] init];
    } else if ([type isEqualToString:SYAlertViewType_SYOrderAddFreeAlertView]) {
        alertView = [[SYOrderAddFreeAlertView alloc] init];
    } else if ([type isEqualToString:SYAlertViewType_SYInsuranceProgressAlertView]) {
        alertView = [[SYInsuranceProgressAlertView alloc] init];
    }
    
    return alertView;
}

@end
