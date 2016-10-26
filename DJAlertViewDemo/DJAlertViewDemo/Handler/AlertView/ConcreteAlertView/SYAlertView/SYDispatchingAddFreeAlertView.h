//
//  SYDispatchingAddFreeAlertView.h
//  alertviewtest
//
//  Created by chentengfei on 16/9/13.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertView.h"

/**
 *  速运派单中加小费AlertView
 */
@interface SYDispatchingAddFreeAlertView : DJAbstractAlertView

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *titleAttributedStr;

@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *detailAttributedStr;

@property (nonatomic, strong) NSArray *freeNums;

/**
 *  设置默认小费金额
 *  @param tip 小费金额
 */
- (void)setDefaultTip:(NSInteger)tip;

/**
 *  获取小费最终值
 *  @return 小费结果
 */
- (NSString *)fetchTipResult;

@end
