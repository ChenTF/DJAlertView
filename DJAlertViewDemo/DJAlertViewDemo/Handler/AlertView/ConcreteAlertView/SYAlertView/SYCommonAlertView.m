//
//  SYCommonAlertView.m
//  Pods
//
//  Created by chentengfei on 16/9/23.
//
//

#import "SYCommonAlertView.h"


@implementation SYCommonAlertView

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
    self.headView = headView;
    
    
    DJAlertDoubleActionView *actionView = [[DJAlertDoubleActionView alloc] initWithDelegate:self];
    self.actionView = actionView;
}

- (void)setStyle:(SYCommonAlertViewStyle)style {
    _style = style;
    
    switch (style) {
        case SYCommonAlertViewStyleLimitCity:
        {
            // TODO:添加限制弹窗的样式设置
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters & Setters
- (void)setTitleStr:(NSString *)titleStr {
    ((DJAlertDetailHeadView *)self.headView).titleLabel.text = titleStr;
    
    _titleStr = [titleStr copy];
}

- (void)setTitleAttributeStr:(NSMutableAttributedString *)titleAttributeStr {
    ((DJAlertDetailHeadView *)self.headView).titleLabel.attributedText = [titleAttributeStr copy];
    
    _titleAttributeStr = [titleAttributeStr copy];
}

- (void)setDetailStr:(NSString *)detailStr {
    DJAlertDetailHeadView * headView = (DJAlertDetailHeadView *)self.headView;
    headView.type = DJDetailHeadViewTypeDetail;
    headView.detailLabel.text = [detailStr copy];
    
    _detailStr = [detailStr copy];
}

- (void)setDetailAttributeStr:(NSMutableAttributedString *)detailAttributeStr {
    DJAlertDetailHeadView * headView = (DJAlertDetailHeadView *)self.headView;
    headView.type = DJDetailHeadViewTypeDetail;
    headView.detailLabel.attributedText = [detailAttributeStr copy];
    
    _detailAttributeStr = [detailAttributeStr copy];
}
@end
