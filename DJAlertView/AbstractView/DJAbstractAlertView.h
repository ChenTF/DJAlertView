//
//  AbstractAlertView.h
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "DJAbstractHeadView.h"
#import "DJAbstractAlertContentView.h"
#import "DJAbstractAlertActionView.h"

@protocol DJAbstractAlertViewDelegate;

@interface DJAbstractAlertView : UIView<DJAbstractAlertActionViewDelegate>

@property (nonatomic, strong) DJAbstractHeadView          *headView; // 头部试图
@property (nonatomic, strong) DJAbstractAlertContentView  *contentView; //中间试图
@property (nonatomic, strong) DJAbstractAlertActionView   *actionView; // 底部选项试图
@property (nonatomic, strong) UIImageView                 *backgroundImageView; // 背景图片

@property (nonatomic, weak) id<DJAbstractAlertViewDelegate> delegate;


#pragma mark - 布局 & 样式
@property (nonatomic, assign) CGFloat alertViewPadding; // alertView 距离屏幕两侧的距离
@property (nonatomic, strong) UIColor *shardowCorlor;   // 背景阴影的颜色

- (void)setLayerCornerRadius:(CGFloat)cornerRadius;

#pragma mark - Public Methods
- (void)show;
- (void)dismiss;

/**
 show之后的逻辑处理
 */
- (void)showCompletionMethods;

/**
 *  设置AlertView的位置偏移
 */
- (void)setViewOffset:(CGPoint)offsetPoint;


@end



@protocol DJAbstractAlertViewDelegate <NSObject>

/**
 *  选中下标回调, 返回YES则弹窗消失(默认YES)
 */
- (BOOL)AlertView:(DJAbstractAlertView *)alertView Index:(NSUInteger)index;

@end
