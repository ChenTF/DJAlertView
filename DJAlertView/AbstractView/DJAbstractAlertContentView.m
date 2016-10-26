//
//  DJAbstractAlertContentView.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertContentView.h"

@implementation DJAbstractAlertContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        _contentEdge = UIEdgeInsetsZero;
    }
    return self;
}

@end
