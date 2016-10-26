//
//  DJDoubleActionView.h
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertActionView.h"

@interface DJAlertDoubleActionView : DJAbstractAlertActionView

@property (nonatomic, strong) UIButton *cancelBtn;  // 取消
@property (nonatomic, strong) UIButton *okBtn;      // 确认, 正常红色, 选中时灰色

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *centerLine;

#pragma mark - 布局 & 样式
@property (nonatomic, assign) CGFloat actionHeight;
@end
