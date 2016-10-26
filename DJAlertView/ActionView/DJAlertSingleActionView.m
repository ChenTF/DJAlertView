//
//  DJAlertSingleActionView.m
//  Pods
//
//  Created by chentengfei on 16/9/29.
//
//

#import "DJAlertSingleActionView.h"
#import "UIColor+Hex.h"

@implementation DJAlertSingleActionView

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
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_actionBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:[UIColor ColorOfHex:0x999999] forState:UIControlStateNormal];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor ColorOfHex:0xe6e6e6];
        
        _actionHeight = 45.0;
    }
    return self;
}

- (void)updateConstraints {
    
    [self addSubview:self.actionBtn];
    [self addSubview:self.topLine];
    
    // 按钮
    [self.actionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
        make.height.mas_offset(self.actionHeight);
    }];

    // 顶部线
    [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [super updateConstraints];
}


#pragma mark - Event Response
- (void)btnClick:(UIButton *)btn {
    
    [self setSelectedIndex:0];
}

@end
