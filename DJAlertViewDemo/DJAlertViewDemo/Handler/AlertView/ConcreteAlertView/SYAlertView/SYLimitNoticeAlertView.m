//
//  SYLimitNoticeAlertView.m
//  alertviewtest
//
//  Created by chentengfei on 16/9/12.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "SYLimitNoticeAlertView.h"

#import "DJAlertDoubleActionView.h"
#import "DJAlertDetailHeadView.h"

@implementation SYLimitNoticeAlertView

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
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    DJAlertDetailHeadView *headView = [[DJAlertDetailHeadView alloc] initWithType:DJDetailHeadViewTypeTitle];
    headView.titleLabel.textColor = [UIColor grayColor];
    headView.titleLabel.font = [UIFont systemFontOfSize:14.0];
    headView.titleEdge = UIEdgeInsetsMake(10, 10, 10, 10);

    self.headView = headView;
    
    DJAlertDoubleActionView *actionView = [[DJAlertDoubleActionView alloc] initWithDelegate:self];
    [actionView.okBtn setTitle:@"继续使用" forState:UIControlStateSelected];
    [actionView.okBtn setTitle:@"继续使用" forState:UIControlStateNormal];
    [actionView.okBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [actionView.cancelBtn setTitle:@"换个车型" forState:UIControlStateNormal];
    [actionView.cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    actionView.actionHeight = 30.0;
    self.actionView = actionView;
    
    
    self.alertViewPadding = 20.0;
}


- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = [titleStr copy];
    ((DJAlertDetailHeadView *)self.headView).titleLabel.text = titleStr;
}

@end
