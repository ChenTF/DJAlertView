//
//  DJAlertViewShowHandler.h
//  alertviewtest
//
//  Created by 陈腾飞 on 16/9/19.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJAbstractAlertView.h"
@class DJAbstractAlertView;

@interface DJAlertViewShowHandler : NSObject


+ (DJAlertViewShowHandler *)sharedInstance;

- (void)showAlertView:(DJAbstractAlertView *)alertView;
- (void)dismissAlertView:(DJAbstractAlertView *)alertView;

@end
