//
//  UIColor+Hex.m
//  SYBasicServiceLib
//
//  Created by iBlock on 16/3/30.
//  Copyright © 2016年 iBlock. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)ColorOfHex:(UInt32)value alpha:(CGFloat)alpha
{
    UIColor *color = [UIColor colorWithRed:((value & 0xFF0000) >> 16) / 255.0
                    green:((value & 0xFF00) >> 8) / 255.0
                     blue:(value & 0xFF) / 255.0
                    alpha:alpha];
    return color;
}

//默认alpha值为1
+ (UIColor *)ColorOfHex:(UInt32)value
{
    UIColor *color = [UIColor colorWithRed:((value & 0xFF0000) >> 16) / 255.0
                                     green:((value & 0xFF00) >> 8) / 255.0
                                      blue:(value & 0xFF) / 255.0
                                     alpha:1.0f];
    return color;
}

@end
