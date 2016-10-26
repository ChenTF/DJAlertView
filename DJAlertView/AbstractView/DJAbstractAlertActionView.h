//
//  DJAbstractAlertActionView.h
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@protocol DJAbstractAlertActionViewDelegate;


@interface DJAbstractAlertActionView : UIView

@property (nonatomic, assign) id<DJAbstractAlertActionViewDelegate> delegate;


- (instancetype)initWithDelegate:(id<DJAbstractAlertActionViewDelegate>)delegate;

/**
 *  设置选中的下标
 */
- (void)setSelectedIndex:(NSUInteger)index;

@end


@protocol DJAbstractAlertActionViewDelegate <NSObject>

/**
 选项选中回调

 @param actionView 当前的actionView对象
 @param index      下标
 */
- (void)ActionView:(DJAbstractAlertActionView *)actionView SelectedIndex:(NSUInteger)index;

@end
