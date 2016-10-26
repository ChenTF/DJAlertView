//
//  SYOrderAddFreeAlertView.h
//  Pods
//
//  Created by chentengfei on 16/9/23.
//
//

#import "DJAbstractAlertView.h"
#import "DJAlertDetailHeadView.h"
#import "SYAlertDispatchingAddFreeContentView.h"
#import "DJAlertDoubleActionView.h"

@interface SYOrderAddFreeAlertView : DJAbstractAlertView

@property (nonatomic, strong) NSArray *freeNums;

/** 小费为零或空时，确定按钮是否可用 */
@property (nonatomic, assign) BOOL zeroTipOkButtonCanClick;

/** 订单确认页弹框允许输入零 */
@property (nonatomic, assign)BOOL zeroEnable;

/**
 *  获取小费最终值
 *  @return 小费结果
 */
- (NSString *)fetchTipResult;

/**
 *  设置默认小费金额
 *  @param tip 小费金额
 */
- (void)setDefaultTip:(NSInteger)tip;

@end
