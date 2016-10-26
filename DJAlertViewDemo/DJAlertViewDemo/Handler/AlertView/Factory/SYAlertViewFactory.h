//
//  SYAlertViewFactory.h
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertViewFactory.h"

#import "SYAddFeeAlertView.h"
#import "SYLimitNoticeAlertView.h"
#import "SYDispatchingAddFreeAlertView.h"
#import "SYOrderAddFreeAlertView.h"
#import "SYInsuranceProgressAlertView.h"

#define kSYAlertViewType_SYLimitNoticeAlertView @"SYAlertViewType_SYLimitNoticeAlertView"
#define kSYAlertViewType_SYAddFeeAlertView @"SYAlertViewType_SYAddFeeAlertView"
#define kSYAlertViewType_SYDispatchingAddFreeAlertView @"SYAlertViewType_SYDispatchingAddFreeAlertView"
#define SYAlertViewType_SYOrderAddFreeAlertView @"SYAlertViewType_SYOrderAddFreeAlertView"
#define SYAlertViewType_SYInsuranceProgressAlertView @"SYAlertViewType_SYInsuranceProgressAlertView"


@interface SYAlertViewFactory : AlertViewFactory

@end
