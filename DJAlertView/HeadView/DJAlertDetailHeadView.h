//
//  DJDetailHeadView.h
//  alertviewtest
//
//  Created by chentengfei on 16/9/5.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractHeadView.h"

typedef NS_ENUM(NSUInteger, DJDetailHeadViewType) {
    DJDetailHeadViewTypeTitle,  // 纯标题
    DJDetailHeadViewTypeDetail, // 标题+详情
};

@interface DJAlertDetailHeadView : DJAbstractHeadView

@property (nonatomic, assign) DJDetailHeadViewType type;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) UIEdgeInsets titleEdge; // default : (0, 10, 0, 10)

// 详情
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) UIEdgeInsets detailEdge; // default : (0, 10, 0, 10)


- (instancetype)initWithType:(DJDetailHeadViewType)type;
@end
