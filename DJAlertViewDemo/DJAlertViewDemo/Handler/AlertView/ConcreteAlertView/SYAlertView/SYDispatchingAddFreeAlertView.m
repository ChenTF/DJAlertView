//
//  SYDispatchingAddFreeAlertView.m
//  alertviewtest
//
//  Created by chentengfei on 16/9/13.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "SYDispatchingAddFreeAlertView.h"

#import "DJAlertDetailHeadView.h"
#import "SYAlertDispatchingAddFreeContentView.h"
#import "DJAlertDoubleActionView.h"

#import "UIColor+Hex.h"

@implementation SYDispatchingAddFreeAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}


- (void)setUpView {
    
    DJAlertDetailHeadView *headView = [[DJAlertDetailHeadView alloc] initWithType:DJDetailHeadViewTypeTitle];
    headView.titleLabel.textAlignment = NSTextAlignmentLeft;
    headView.titleLabel.text = @"目前周围用车需求较多, 可应答司机少。您可选择增加小费以尽快出发, 小费归司机所有。";
    headView.titleLabel.textColor = [UIColor ColorOfHex:0x666666];
    headView.titleLabel.font = [UIFont systemFontOfSize:15.0];
    headView.titleEdge = UIEdgeInsetsMake(20, 15, 12, 15);
    
    headView.detailEdge = UIEdgeInsetsMake(0, 15, 15, 15);
    headView.detailLabel.textColor = [UIColor ColorOfHex:0x666666];
    headView.detailLabel.font = [UIFont systemFontOfSize:15.0];
    headView.detailLabel.text = @"加小费金额 :";
    self.headView = headView;
    
    SYAlertDispatchingAddFreeContentView *contentView = [[SYAlertDispatchingAddFreeContentView alloc] initWithFreeNums:self.freeNums
                                                                                               HaveTextField:NO];
    contentView.contentEdge = UIEdgeInsetsMake(0, 15, 20, 15);
    self.contentView = contentView;
    
    
    DJAlertDoubleActionView *actionView = [[DJAlertDoubleActionView alloc] initWithDelegate:self];
    [actionView.cancelBtn setTitle:@"不加，再等等" forState:UIControlStateNormal];
    [actionView.okBtn setTitle:@"加小费" forState:UIControlStateNormal];
    self.actionView = actionView;
}

#pragma mark - Outer Method

- (NSString *)fetchTipResult {
    return [((SYAlertDispatchingAddFreeContentView *)self.contentView) fetchTipResult];
}

- (void)setDefaultTip:(NSInteger)tip {
    if (tip > 0) {
        [((SYAlertDispatchingAddFreeContentView *)self.contentView) setDefaultTipStr:[NSString stringWithFormat:@"%zd", tip]];
    }
}

#pragma mark - Getters & Setters
- (void)setTitleStr:(NSString *)titleStr {
    titleStr = (titleStr == nil ? @" " : titleStr);

    _titleStr = [titleStr copy];
    ((DJAlertDetailHeadView *)self.headView).titleLabel.text = [titleStr copy];
}

- (void)setTitleAttributedStr:(NSString *)titleAttributedStr {
    titleAttributedStr = (titleAttributedStr == nil ? @" " : titleAttributedStr);

    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:titleAttributedStr];
    // 字体和颜色
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, titleAttributedStr.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor ColorOfHex:0x666666] range:NSMakeRange(0, titleAttributedStr.length)];
    // 主标题行间距
    NSMutableParagraphStyle  *styleLineSpace =[[ NSMutableParagraphStyle alloc ] init];
    styleLineSpace.lineSpacing  = 9;
    styleLineSpace.alignment = NSTextAlignmentLeft;
    styleLineSpace.lineBreakMode = NSLineBreakByCharWrapping;
    [attriString addAttribute:NSParagraphStyleAttributeName
                        value:styleLineSpace
                        range:NSMakeRange(0, [titleAttributedStr length])];
    
    
    _titleAttributedStr = [attriString copy];
    ((DJAlertDetailHeadView *)self.headView).titleLabel.attributedText = (NSAttributedString *)_titleAttributedStr;
}

-(void)setDetailStr:(NSString *)detailStr {
    _detailStr = [detailStr copy];
    DJAlertDetailHeadView *headView = (DJAlertDetailHeadView *)self.headView;
    headView.type = DJDetailHeadViewTypeDetail;
    headView.detailLabel.text = [detailStr copy];
}

- (void)setDetailAttributedStr:(NSString *)detailAttributedStr {
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:detailAttributedStr];
    // 字体和颜色
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, detailAttributedStr.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor ColorOfHex:0x666666] range:NSMakeRange(0, detailAttributedStr.length)];
    // 主标题行间距
    NSMutableParagraphStyle  *styleLineSpace =[[ NSMutableParagraphStyle alloc ] init];
    styleLineSpace.lineSpacing  = 9;
    styleLineSpace.alignment = NSTextAlignmentLeft;
    styleLineSpace.lineBreakMode = NSLineBreakByCharWrapping;
    [attriString addAttribute:NSParagraphStyleAttributeName
                        value:styleLineSpace
                        range:NSMakeRange(0, [detailAttributedStr length])];
    
    _detailAttributedStr = [attriString copy];
    
    DJAlertDetailHeadView *headView = (DJAlertDetailHeadView *)self.headView;
    headView.type = DJDetailHeadViewTypeDetail;
    headView.detailLabel.attributedText = (NSAttributedString *)_detailAttributedStr;
}

- (void)setFreeNums:(NSArray *)freeNums {
    _freeNums = freeNums;
    ((SYAlertDispatchingAddFreeContentView *)self.contentView).freeNums = freeNums;
}


@end
