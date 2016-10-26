//
//  SYDispatchingAddFreeContentView.h
//  alertviewtest
//
//  Created by chentengfei on 16/9/13.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertContentView.h"
#import "DJAlertViewShowHandler.h"

@interface DJAlertTextField : UITextField

@end

@interface SYAlertDispatchingAddFreeContentView : DJAbstractAlertContentView

@property (nonatomic, strong) UITextField *textField;

#pragma mark - 数据
@property (nonatomic, copy) NSArray *freeNums; // 按钮选项数据
@property (nonatomic, assign) BOOL isHaveTextField; // 默认无

#pragma mark - 布局 & 样式
@property (nonatomic, assign) CGFloat freeNumInterval; // 小费选项的间距
@property (nonatomic, assign) CGSize freeNumSize; // 小费选项的宽高

@property (nonatomic, assign) CGFloat freeNumAndTextFieldInterval; // 小费选项与TextField的垂直间隔
@property (nonatomic, assign) CGFloat textFieldHeight;
/** 记录点击的按钮 */
@property (nonatomic, strong) UIButton *curSelectedButton;

/** 标注是否有按钮选中 */
@property (nonatomic, assign) BOOL hasButtonSelected;

/** 标记需要反选的tip */
@property (nonatomic, copy) NSString *defaultTipStr;

- (instancetype)initWithFreeNums:(NSArray *)freeNums HaveTextField:(BOOL)haveTextField;


/**
 *  取消选中的按钮
 */
- (void)cancelTipSelectedButton;

/**
 *  设置输入框样式
 *  @param isActive 是否处于激活状态
 */
- (void)configTextFieldActive:(BOOL)isActive;


/**
 *  获取小费最终值
 *  @return 小费结果
 */
- (NSString *)fetchTipResult;


@end
