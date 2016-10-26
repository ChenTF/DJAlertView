//
//  AlertViewFactory.h
//  alertviewtest
//
//  Created by chentengfei on 16/9/13.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJAbstractAlertView.h"

@interface AlertViewFactory : NSObject

- (DJAbstractAlertView *)alertViewWithType:(NSString *)type;

@end
