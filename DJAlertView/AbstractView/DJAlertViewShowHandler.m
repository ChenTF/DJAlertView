//
//  DJAlertViewShowHandler.m
//  alertviewtest
//
//  Created by 陈腾飞 on 16/9/19.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAlertViewShowHandler.h"

@interface DJAbstractAlertView ()
@property (nonatomic, strong) UIView *alertContentView;
@end


@interface DJAlertViewShowHandler ()

@property (atomic, strong) NSMutableArray *alertQueue;
@property (atomic, strong) DJAbstractAlertView *showAlertView;

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation DJAlertViewShowHandler

#pragma mark - Public Methods
static DJAlertViewShowHandler *instance;
+ (DJAlertViewShowHandler *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DJAlertViewShowHandler alloc] init];
        instance.alertQueue = [NSMutableArray arrayWithCapacity:10];
        instance.showAlertView = nil;
    });
    return instance;
};

- (void)showAlertView:(DJAbstractAlertView *)alertView {
    
    if ([self.alertQueue containsObject:alertView] == NO) {
        [self.alertQueue addObject:alertView];
    }
    
    if (self.showAlertView) {
        NSLog(@"已经有正在显示的AlertView, 所以取消");
        return;
    }
    
    // 获取要显示的AlertView
    self.showAlertView = [self.alertQueue firstObject];
    [self.showAlertView setFrame:[UIScreen mainScreen].bounds];
    if (self.showAlertView == nil) {
        return;
    }
    
    // 显示
//    self.alertWindow.hidden = NO;
    [self.showAlertView setFrame:[UIScreen mainScreen].bounds];
    [self.alertWindow addSubview:self.showAlertView];
    [self.showAlertView updateConstraints];
    
    // 从上向中 动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.showAlertView.alpha = 1;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            // 通过修改约束的优先级, 来达到动画效果
            [self.showAlertView.alertContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                UIView *alertContentViewSupView = self.showAlertView.alertContentView.superview;
                make.centerY.equalTo(alertContentViewSupView).with.priorityHigh();
                make.bottom.equalTo(alertContentViewSupView.mas_top).with.priorityLow();
                
            }];
            [self.showAlertView layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [self.showAlertView showCompletionMethods];
        }];
        
    });
}

- (void)showNextAlertView {
    
    if (self.showAlertView) {
        NSLog(@"已经有正在显示的AlertView, 所以取消");
        return;
    }
    
    if (self.alertQueue.count > 0) {
        [self showAlertView:[self.alertQueue firstObject]];
    }
}

- (void)dismissAlertView:(DJAbstractAlertView *)alertView {
    
    // 如果要取消的不是当前显示的AlertView, 则提供取消以后显示的逻辑
    if (self.showAlertView != alertView) {
        [self.alertQueue removeObject:alertView];
        return;
    }
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.showAlertView.alertContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            UIView *alertContentViewSupView = self.showAlertView.alertContentView.superview;
            make.centerY.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        }];
        [self.showAlertView layoutIfNeeded];
        
    } completion:^(BOOL finished) {

        
        [self.showAlertView endEditing:YES];
        [self.showAlertView removeFromSuperview];
        [self.alertQueue removeObject:self.showAlertView];
        self.showAlertView = nil;
        
        [self showNextAlertView];
    }];
}

#pragma mark - Getters & Setters
- (UIWindow *)alertWindow {
    /* 如果使用自定义的window, 则有TextField时无法弹出键盘
    if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert - 1;
        UIViewController *vc = [[UIViewController alloc] init];
        _alertWindow.rootViewController = vc;
        _alertWindow.hidden = YES;
    }
    return _alertWindow;
     */
    return [UIApplication sharedApplication].keyWindow;
}

@end
