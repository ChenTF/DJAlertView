//
//  SYCommonAlertView.h
//  Pods
//
//  Created by chentengfei on 16/9/23.
//
//

#import "DJAbstractAlertView.h"
#import "DJAlertDetailHeadView.h"
#import "DJAlertDoubleActionView.h"

typedef NS_ENUM(NSUInteger, SYCommonAlertViewStyle) {
    SYCommonAlertViewStyleLimitCity,
};


@interface SYCommonAlertView : DJAbstractAlertView

#pragma mark - 样式 & 数据
@property (nonatomic, assign) SYCommonAlertViewStyle style;

// 标题数据
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSMutableAttributedString *titleAttributeStr;

// 详情数据, 如果不设置则只显示标题
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSMutableAttributedString *detailAttributeStr;

@end
