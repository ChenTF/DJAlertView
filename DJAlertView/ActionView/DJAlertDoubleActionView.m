//
//  DJDoubleActionView.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAlertDoubleActionView.h"
#import "UIColor+Hex.h"

@implementation DJAlertDoubleActionView

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
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor ColorOfHex:0x999999] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor ColorOfHex:0xe5454a] forState:UIControlStateSelected];
        [_okBtn setTitleColor:[UIColor ColorOfHex:0x999999] forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_okBtn setSelected:YES];
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor ColorOfHex:0xe6e6e6];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = [UIColor ColorOfHex:0xe6e6e6];
        
        
        _actionHeight = 45.0;
    }
    return self;
}

- (void)updateConstraints {
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.okBtn];
    [self addSubview:self.topLine];
    [self addSubview:self.centerLine];
    
    
    // 取消按钮
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.equalTo(self.okBtn.mas_left);
        make.width.equalTo(self.okBtn);
        make.height.mas_equalTo(self.actionHeight);
    }];
    
    // 确认按钮
    [self.okBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.equalTo(self.cancelBtn.mas_right);
    }];
    
    // 顶部线
    [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    // 中间线
    [self.centerLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
    
    [super updateConstraints];
}


#pragma mark - Event Response
- (void)btnClick:(UIButton *)btn {
    
    if (btn == self.okBtn) {
        [self setSelectedIndex:1];
    } else if (btn == self.cancelBtn) {
        [self setSelectedIndex:0];
    }
}



#pragma mark - Getters & Setters


@end
