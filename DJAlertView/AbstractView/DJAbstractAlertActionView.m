//
//  DJAbstractAlertActionView.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertActionView.h"

@implementation DJAbstractAlertActionView

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
    }
    return self;
}

- (instancetype)initWithDelegate:(id<DJAbstractAlertActionViewDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ActionView:SelectedIndex:)]) {
        [self.delegate ActionView:self SelectedIndex:index];
    }
}
@end
