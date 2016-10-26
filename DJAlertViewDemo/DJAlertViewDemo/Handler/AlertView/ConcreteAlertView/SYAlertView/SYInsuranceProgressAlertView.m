//
//  SYInsuranceProgressAlertView.m
//  SuYun
//
//  Created by chentengfei on 16/9/29.
//  Copyright © 2016年 58. All rights reserved.
//

#import "SYInsuranceProgressAlertView.h"

#import "DJAlertDetailHeadView.h"
#import "DJAlertSingleActionView.h"
#import "NSString+DJStrUtils.h"
#import "UIColor+Hex.h"

@implementation SYInsuranceProgressAlertView

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
    DJAlertDetailHeadView *headView = [[DJAlertDetailHeadView alloc] initWithType:DJDetailHeadViewTypeDetail];
    headView.titleLabel.text = @"平安保险已收到您的理赔";
    headView.titleLabel.textColor = [UIColor ColorOfHex:0x333333];
    headView.titleLabel.textAlignment = NSTextAlignmentCenter;
    headView.titleEdge = UIEdgeInsetsMake(15, 0, 0, 0);
    
    headView.detailLabel.textAlignment = NSTextAlignmentCenter;
    headView.detailEdge = UIEdgeInsetsMake(4, 0, 15, 0);
    
    self.headView = headView;
    
    DJAlertSingleActionView *actionView = [[DJAlertSingleActionView alloc] initWithDelegate:self];
    [actionView.actionBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [actionView.actionBtn setTitleColor:[UIColor ColorOfHex:0xe6454a] forState:UIControlStateNormal];
    self.actionView = actionView;
}


- (void)setProgressStr:(NSString *)progressStr {
    
    if ([NSString isEmptyString:progressStr]) {
        _progressStr = @"处理中..";
    } else {
        _progressStr = [progressStr copy];
    }
    
    NSString *detailStr = [NSString stringWithFormat:@"当前状态为: %@", progressStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:detailStr];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor ColorOfHex:0x333333] range:NSMakeRange(0, progressStr.length)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor ColorOfHex:0xe6454a] range:NSMakeRange(7, progressStr.length)];
    
    ((DJAlertDetailHeadView *)self.headView).detailLabel.attributedText = attributeStr;
}

@end
