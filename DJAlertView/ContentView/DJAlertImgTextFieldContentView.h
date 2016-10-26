//
//  DJImgTextFieldContentView.h
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAbstractAlertContentView.h"

typedef NS_ENUM(NSUInteger, DJImgTextFieldContentViewLeftType) {
    DJImgTextFieldContentViewLeftTypeImg,
    DJImgTextFieldContentViewLeftTypeLabel,
    DJImgTextFieldContentViewLeftTypeNone
};

@interface DJAlertImgTextFieldContentView : DJAbstractAlertContentView

@property (nonatomic, strong) UIImage     *leftImg;
@property (nonatomic, strong) UILabel     *leftLabel;
@property (nonatomic, strong) UITextField *textField;

#pragma mark - 布局
@property (nonatomic, assign) UIEdgeInsets leftViewEdge;    // 左视图的外边距, 要设置TextField的外边距通过设置contentEdge
@property (nonatomic, assign, readonly) DJImgTextFieldContentViewLeftType leftType;

- (instancetype)initWithLeftType:(DJImgTextFieldContentViewLeftType)leftType;

@end
