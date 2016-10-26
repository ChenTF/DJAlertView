//
//  AbstractAlertView.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertView.h"
#import "DJAlertViewShowHandler.h"

@interface DJAbstractAlertView ()

@property (nonatomic, strong) UIView *alertContentView;
@property (nonatomic, strong) UIView *shardowView;

@end

@implementation DJAbstractAlertView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - Life Cycle


- (instancetype)init {
    self = [super init];
    if (self) {
        
        _headView = [[DJAbstractHeadView alloc] init];
        _contentView = [[DJAbstractAlertContentView alloc] init];
        _actionView = [[DJAbstractAlertActionView alloc] init];
        _backgroundImageView = [[UIImageView alloc] init];
        
        _shardowView = [[UIView alloc] init];
        _shardowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _alertContentView = [[UIView alloc] init];
        _alertContentView.backgroundColor = [UIColor whiteColor];
        
        _alertViewPadding = 10.0;
        if ([UIScreen mainScreen].bounds.size.width == 375) {
            // 6
            _alertViewPadding = 30.0;
        } else if ([UIScreen mainScreen].bounds.size.width > 375) {
            // 6p
            _alertViewPadding = 45.0;
        }
        
        
        [self setLayerCornerRadius:8];
        
        [self addKeyboardListen];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addLayout {
    [self addSubview:self.shardowView];
    
    [self.shardowView addSubview:self.alertContentView];
    
    [self.alertContentView addSubview:self.backgroundImageView];
    [self.alertContentView addSubview:self.headView];
    [self.alertContentView addSubview:self.contentView];
    [self.alertContentView addSubview:self.actionView];
    
    // 全屏背景
    [self.shardowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *shardowViewSupView = self.shardowView.superview;
        make.edges.equalTo(shardowViewSupView);
    }];
    
    // AlertView试图
    [self.alertContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *alertContentViewSupView = self.alertContentView.superview;
        make.centerY.equalTo(alertContentViewSupView).with.priorityLow();
        make.bottom.equalTo(alertContentViewSupView.mas_top).with.priorityHigh();
        make.left.equalTo(alertContentViewSupView).offset(self.alertViewPadding);
        make.right.equalTo(alertContentViewSupView).offset(-self.alertViewPadding);
    }];
    
    // 背景图片
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *backgroundImageViewSupView = self.backgroundImageView.superview;
        make.edges.equalTo(backgroundImageViewSupView);
    }];
    
    // 头部
    [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *headViewSupView = self.headView.superview;
        make.left.top.right.equalTo(headViewSupView);
    }];
    
    // 内容区
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *contentViewSuperView = self.contentView.superview;
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(contentViewSuperView);
    }];
    
    // 底部
    [self.actionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *actionViewSupView = self.actionView.superview;
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(actionViewSupView);
        make.bottom.equalTo(actionViewSupView);
    }];
}


- (void)updateConstraints {
    
    [self addLayout];
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    
    
    [super layoutSubviews];
}

#pragma mark - Public Methods
- (void)setLayerCornerRadius:(CGFloat)cornerRadius {
    
    self.alertContentView.layer.cornerRadius = cornerRadius;
    self.alertContentView.layer.masksToBounds = YES;
}

- (void)setViewOffset:(CGPoint)offsetPoint {
    
}


- (void)show {
    
    [[DJAlertViewShowHandler sharedInstance] showAlertView:self];
}

- (void)showCompletionMethods {
    // 提供给子类来重写
}


- (void)dismiss {

    [[DJAlertViewShowHandler sharedInstance] dismissAlertView:self];
}

#pragma mark - DJAbstractAlertActionViewDelegate
- (void)ActionView:(DJAbstractAlertActionView *)actionView SelectedIndex:(NSUInteger)index {
    
    BOOL isDismiss = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(AlertView:Index:)]) {
        isDismiss = [self.delegate AlertView:self Index:index];
    }
    
    if (isDismiss) {
        [self dismiss];
    }
}


#pragma mark - Getters & Setters
- (void)setShardowCorlor:(UIColor *)shardowCorlor {
    _shardowView.backgroundColor = shardowCorlor;
}

- (UIColor *)shardowCorlor {
    return _shardowView.backgroundColor;
}

#pragma mark - Notification
- (void)addKeyboardListen {
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    int keyboardHeight = 0;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    
    CGRect contentViewRect = self.alertContentView.frame;
    CGFloat alertContentViewCenterY = [UIScreen mainScreen].bounds.size.height / 2.0 - (keyboardHeight + contentViewRect.size.height / 2.0);
    if (alertContentViewCenterY < 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.alertContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                UIView *alertContentViewSupView = self.alertContentView.superview;
                make.centerY.equalTo(alertContentViewSupView).offset(alertContentViewCenterY);
            }];
            [self layoutIfNeeded];
        }];
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        // 通过修改约束的优先级, 来达到动画效果
        [self.alertContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            UIView *alertContentViewSupView = self.alertContentView.superview;
            if (alertContentViewSupView) {
                make.centerY.equalTo(alertContentViewSupView);
            }
        }];
        [self layoutIfNeeded];
    }];
}
@end
