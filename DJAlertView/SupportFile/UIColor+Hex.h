//
//  UIColor+Hex.h
//  SYBasicServiceLib
//
//  Created by iBlock on 16/3/30.
//  Copyright © 2016年 iBlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

//默认alpha值为1
+ (UIColor *)ColorOfHex:(UInt32)value;

+ (UIColor *)ColorOfHex:(UInt32)value alpha:(CGFloat)alpha;

@end
