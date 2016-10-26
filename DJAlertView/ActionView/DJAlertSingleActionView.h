//
//  DJAlertSingleActionView.h
//  Pods
//
//  Created by chentengfei on 16/9/29.
//
//

#import "DJAbstractAlertActionView.h"

@interface DJAlertSingleActionView : DJAbstractAlertActionView

@property (nonatomic, strong) UIButton *actionBtn;  // 取消
@property (nonatomic, strong) UIView *topLine;

#pragma mark - 布局 & 样式
@property (nonatomic, assign) CGFloat actionHeight;
@end
