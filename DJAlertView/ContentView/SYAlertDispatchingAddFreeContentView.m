//
//  SYDispatchingAddFreeContentView.m
//  alertviewtest
//
//  Created by chentengfei on 16/9/13.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "SYAlertDispatchingAddFreeContentView.h"
#import <UIImage+CustomImage.h>
#import <UIColor+Hex.h>
#import <NSString+DJStrUtils.h>

@implementation DJAlertTextField

- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(1, self.frame.size.height * 0.5, 0, 0)];
}

@end

@interface SYAlertDispatchingAddFreeContentView ()

@property (nonatomic, strong) NSMutableArray *freeNumBtns;

@end

@implementation SYAlertDispatchingAddFreeContentView


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
        _freeNums = [NSArray array];
        _isHaveTextField = NO;
        
        _freeNumInterval = 10.0;
        _freeNumAndTextFieldInterval = 10.0;
        _freeNumBtns = [NSMutableArray arrayWithCapacity:6];
        _textFieldHeight = 37.0;
        
        _textField = [[DJAlertTextField alloc] init];
        [self configTextFieldStyle:_textField];
    }
    return self;
}

- (instancetype)initWithFreeNums:(NSArray *)freeNums HaveTextField:(BOOL)haveTextField {
    self = [self init];
    if (self) {
        
        _freeNums = [freeNums copy];
        _isHaveTextField = haveTextField;
    }
    return self;
}

#pragma mark - Outer Method

- (void)configureDefaultTip:(NSString *)tipStr {
    if (!tipStr) {
        return;
    }
    NSString * formateTipStr = [self fetchFormateTipString:tipStr];
    for (UIButton * btn in self.freeNumBtns) {
        NSString * btnTitle = [btn titleForState:UIControlStateNormal];
        if ([btnTitle isEqualToString:formateTipStr]) {
            [self btnClicked:btn];
        }
    }
    if (self.isHaveTextField) {
        self.textField.text = tipStr;
        if (!self.hasButtonSelected) {
            [self configTextFieldActive:YES];
        }
    }
}

- (NSString *)fetchTipResult {
    if (self.curSelectedButton) {
        return [[self.curSelectedButton titleForState:UIControlStateNormal] substringFromIndex:1];
    }
    if (self.isHaveTextField) {
        return self.textField.text;
    } else {
        return @"";
    }
}

- (void)cancelTipSelectedButton {
    if (self.curSelectedButton) {
        self.curSelectedButton.selected = NO;
        [self switchButtonStyle:self.curSelectedButton];
        self.curSelectedButton = nil;
    }
}

#pragma mark - Button Actions

- (void)btnClicked:(UIButton *)btn {
    if (self.curSelectedButton && self.curSelectedButton != btn) {
        [self cancelTipSelectedButton];
    }
    btn.selected = !btn.selected;
    
    NSLog(@"%d", btn.selected);
    self.hasButtonSelected = btn.selected;
    
    [self switchButtonStyle:btn];
    [self switchTextFieldStyle:btn];
    if (btn.selected) {
        self.curSelectedButton = btn;
    } else {
        self.curSelectedButton = nil;
    }
    
}

#pragma mark - Tools

- (NSString *)fetchFormateTipString:(NSString *)tipStr {
    NSString * formateTipStr = [NSString stringWithFormat:@"¥%@", tipStr];
    return formateTipStr;
}

/// 按钮状态变化时，切换样式
- (void)switchButtonStyle:(UIButton *)btn {
    if (btn.isSelected) {
        btn.layer.borderWidth = 0.0f;
    } else {
        [self configSelectedButton:btn];
    }
}

- (void)configTextFieldStyle:(UITextField *)textField {
    // 设置边框
    [self configTextFieldActive:NO];
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5;
    textField.backgroundColor = [UIColor whiteColor];
    // 设置其他
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = @"其他金额, 请在此输入(最高200元)";
    [textField setValue:[UIColor ColorOfHex:0xdbdbdb] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

    // 设置光标位置距离左边距离
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 37)];
    textField.leftView = leftLabel;
    leftLabel.textColor = [UIColor ColorOfHex:0x666666];
    leftLabel.frame = CGRectMake(leftLabel.frame.origin.x, leftLabel.frame.origin.y, 10, _textFieldHeight);
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)switchTextFieldStyle:(UIButton *)btn {
    BOOL isSelected = btn.selected;
    if (!self.isHaveTextField) {
        return;
    }
//    if (![NSString isEmptyString:_textField.text]) {
//        [self configTextFieldActive:!isSelected];
//    } else {
//        [self configTextFieldActive:NO];
//    }
    [self configTextFieldActive:NO];

    if (isSelected) {
        self.textField.text = [[btn titleForState:UIControlStateNormal] substringFromIndex:1];
    } else {
        self.textField.text = @"";
        self.hasButtonSelected = NO;
    }
    
}

- (void)configTextFieldActive:(BOOL)isActive {
    if (isActive) {
        self.textField.layer.borderColor = [UIColor ColorOfHex:0x666666].CGColor;
        self.textField.textColor = [UIColor ColorOfHex:0x666666];
    } else {
        self.textField.layer.borderColor = [UIColor ColorOfHex:0xcccccc].CGColor;
        self.textField.textColor = [UIColor ColorOfHex:0xcccccc];
    }
}

/** 设置按钮统一样式 */
- (void)configStyleWithButton:(UIButton *)btn title:(NSString *)title{
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor ColorOfHex:0xe0e0e0].CGColor;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:[UIColor ColorOfHex:0xe6454a] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor ColorOfHex:0x666666] forState:UIControlStateNormal];
    
    NSString *formateTitle = [self fetchFormateTipString:title];
    [btn setTitle:formateTitle forState:UIControlStateSelected];
    [btn setTitle:formateTitle forState:UIControlStateNormal];
}

- (void)configSelectedButton:(UIButton *)btn {
    btn.layer.borderColor = [UIColor ColorOfHex:0xe0e0e0].CGColor;
    btn.layer.borderWidth = 1.0f;
}

- (void)configButtonBackgroundImage:(UIButton *)btn {
    UIImage *checkedImage = [UIImage imageNamedFrombundle:@"MultipleChoice"];
    UIImage *resizableImage = [checkedImage resizableImageWithCapInsets:
                               UIEdgeInsetsMake(5, 5, checkedImage.size.height / 2,
                                                checkedImage.size.width / 2 + 10)];
    [btn setBackgroundImage:resizableImage
                   forState:UIControlStateSelected];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
}

#pragma mark -

- (void)updateConstraints {
    
    // 宽度改成了等宽自适应, 所以宽度无效
    CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width - 2 * 10 - 2 * (self.freeNumInterval + self.contentEdge.left)) / 3;
    _freeNumSize = CGSizeMake(btnWidth, 32.0);
    

    [self.freeNumBtns removeAllObjects];
    for (NSInteger i = 0; i < self.freeNums.count; i++) {
        
        UIButton *freeNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置样式
        [self configSelectedButton:freeNumBtn];
        [self configStyleWithButton:freeNumBtn title:self.freeNums[i]];
        [self configButtonBackgroundImage:freeNumBtn];
        
        // 设置事件
        [freeNumBtn addTarget:self action:@selector(btnClicked:)forControlEvents:UIControlEventTouchUpInside];
        
        // 布局计算
        [self addSubview:freeNumBtn];
        [self.freeNumBtns addObject:freeNumBtn];
//        CGFloat BtnX = self.contentEdge.left
//                        + i * self.freeNumInterval
//                        + i * self.freeNumSize.width;
//        [freeNumBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(BtnX);
//            make.top.mas_equalTo(self.contentEdge.top);
//            make.width.mas_equalTo(self.freeNumSize.width);
//            make.height.mas_equalTo(self.freeNumSize.height);
//            if (self.isHaveTextField == NO) {
//                make.bottom.mas_offset(-self.contentEdge.bottom);
//            }
//        }];
        
        [freeNumBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                // 第一个btn
                make.left.mas_offset(self.contentEdge.left);
            } else {
                // 非第一个
                UIButton *lastBtn = [self.freeNumBtns objectAtIndex:i - 1];
                make.left.equalTo(lastBtn.mas_right).offset(self.freeNumInterval);
                // 等宽
                make.width.equalTo(lastBtn);
            }
            
            make.top.mas_equalTo(self.contentEdge.top);
            make.height.mas_equalTo(self.freeNumSize.height);
            
            if (i == self.freeNums.count - 1) {
                // 最后一个
                make.right.mas_offset(-self.contentEdge.right);
            }
            
            if (i == 0 && self.isHaveTextField == NO) {
                // 如果没有输入框
                make.bottom.mas_offset(-self.contentEdge.bottom);
            }
        }];
    }
    
    if (self.isHaveTextField) {
        
        [self addSubview:self.textField];
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentEdge.left);
            make.top.equalTo(self).offset(self.contentEdge.top + self.freeNumSize.height + self.freeNumAndTextFieldInterval);
            make.right.mas_equalTo(-self.contentEdge.right);
            make.bottom.mas_equalTo(-self.contentEdge.bottom);
            make.height.mas_offset(self.textFieldHeight);
        }];
    }
    [self configureDefaultTip:self.defaultTipStr];
    
    [super updateConstraints];
}

@end
