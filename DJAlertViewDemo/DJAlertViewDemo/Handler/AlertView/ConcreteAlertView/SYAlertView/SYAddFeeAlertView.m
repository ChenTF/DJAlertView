//
//  SYAddFeeAlertView.m
//  alertviewtest
//
//  Created by chentengfei on 16/9/6.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "SYAddFeeAlertView.h"

#import "DJAlertDetailHeadView.h"
#import "DJAlertImgTextFieldContentView.h"
#import "DJAlertDoubleActionView.h"

@implementation SYAddFeeAlertView

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
    
    DJAlertDetailHeadView *detailHeadView = [[DJAlertDetailHeadView alloc] initWithType:DJDetailHeadViewTypeDetail];
    [detailHeadView.titleLabel setText:@"目前周围用车需求较多, 可应答司机少。您可选择增加小费以尽快出发, 小费归司机所有。"];
    [detailHeadView.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [detailHeadView.titleLabel setTextColor:[UIColor grayColor]];
    detailHeadView.titleLabel.textAlignment = NSTextAlignmentLeft;
    detailHeadView.titleEdge = UIEdgeInsetsMake(20, 20, 0, 20);
    
    [detailHeadView.detailLabel setText:@"加X元小费"];
    [detailHeadView.detailLabel setFont:[UIFont systemFontOfSize:15]];
    [detailHeadView.detailLabel setTextColor:[UIColor grayColor]];
    detailHeadView.detailEdge = UIEdgeInsetsMake(15, 20, 10, 20);
    
    self.headView = detailHeadView;
    
    
    DJAlertImgTextFieldContentView *textFieldContentView = [[DJAlertImgTextFieldContentView alloc] initWithLeftType:DJImgTextFieldContentViewLeftTypeLabel];
    [textFieldContentView.leftLabel setText:@"小费"];
    [textFieldContentView.leftLabel setFont:[UIFont systemFontOfSize:15.0]];
    textFieldContentView.leftViewEdge = UIEdgeInsetsMake(10, 10, 10, 10);
    textFieldContentView.contentEdge = UIEdgeInsetsMake(0, 20, 10, 20);
    self.contentView = textFieldContentView;
    
    DJAlertDoubleActionView *doubleActionView = [[DJAlertDoubleActionView alloc] initWithDelegate:self];
    [doubleActionView.okBtn setTitle:@"加小费" forState:UIControlStateNormal];
    [doubleActionView.cancelBtn setTitle:@"不加, 再等等" forState:UIControlStateNormal];
    self.actionView = doubleActionView;
    
}


@end
