//
//  DJImgTextFieldContentView.m
//  alertviewtest
//
//  Created by chentengfei on 16/8/29.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAlertImgTextFieldContentView.h"

@interface DJAlertImgTextFieldContentView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation DJAlertImgTextFieldContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        
        _leftType = DJImgTextFieldContentViewLeftTypeNone;
        _leftViewEdge = UIEdgeInsetsZero;
        self.contentEdge = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return self;
}

- (instancetype)initWithLeftType:(DJImgTextFieldContentViewLeftType)leftType {
    self = [self init];
    if (self) {
        
        _leftType = leftType;
        switch (leftType) {
            case DJImgTextFieldContentViewLeftTypeNone:
            {
            }
                break;
            case DJImgTextFieldContentViewLeftTypeLabel:
            {
                _leftLabel = [[UILabel alloc] init];
                _leftView = [[UIView alloc] init];
                [_leftView addSubview:_leftLabel];
            }
                break;
            case DJImgTextFieldContentViewLeftTypeImg:
            {
                _leftImageView = [[UIImageView alloc] init];
                _leftView = [[UIView alloc] init];
                [_leftView addSubview:_leftImageView];
            }
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)updateConstraints {
    
    self.textField.leftView = self.leftView;
    [self addSubview:self.textField];
    
    switch (self.leftType) {
        case DJImgTextFieldContentViewLeftTypeLabel:
        {
            
            
            [self.leftLabel sizeToFit];
            [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.leftView).insets(self.leftViewEdge);
            }];
            
            CGFloat leftViewWidth = self.leftLabel.bounds.size.width + self.leftViewEdge.left + self.leftViewEdge.right;
            CGFloat leftViewHeight = self.leftLabel.bounds.size.height + self.leftViewEdge.top + self.leftViewEdge.bottom;
            [self.leftView setFrame:CGRectMake(0, 0, leftViewWidth, leftViewHeight)];
            
            
            self.textField.leftView = self.leftView;
            self.textField.leftViewMode = UITextFieldViewModeAlways;
//            [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                UIView *leftViewSupView = self.leftView.superview;
//                make.top.left.mas_offset(0);
//                make.width.mas_offset(leftViewWidth);
//                make.height.mas_offset(leftViewHeight);
//            }];
            
        }
            break;
            
        case DJImgTextFieldContentViewLeftTypeImg:
        {
            self.textField.leftView = self.leftView;
            self.textField.leftViewMode = UITextFieldViewModeAlways;
            
            self.leftImageView.image = self.leftImg;
            [self.leftImageView sizeToFit];
            [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.leftView).insets(self.leftViewEdge);
            }];
            
            CGFloat leftViewWidth = self.leftImageView.bounds.size.width + self.leftViewEdge.left + self.leftViewEdge.right;
            CGFloat leftViewHeight = self.leftImageView.bounds.size.height + self.leftViewEdge.top + self.leftViewEdge.bottom;
            [self.leftView setFrame:CGRectMake(0, 0, leftViewWidth, leftViewHeight)];
//            [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                UIView *leftViewSupView = self.leftView.superview;
//                make.top.left.equalTo(leftViewSupView);
//                make.width.mas_offset(leftViewWidth);
//                make.height.mas_offset(leftViewHeight);
//            }];
            
        }
            break;
            
        case DJImgTextFieldContentViewLeftTypeNone:
        {
            self.textField.leftView = nil;
            self.textField.leftViewMode = UITextFieldViewModeNever;
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    
    // TextField
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.contentEdge);
    }];
    
    [super updateConstraints];
}



#pragma mark - Getters & Setters

- (void)setLeftImg:(UIImage *)leftImg {
    _leftImg = leftImg;
    self.leftImageView.image = _leftImg;
}

- (CGFloat)leftImgWidth {
    
    if (self.leftImg == nil) {
        return 0;
    } else {
        return self.leftImg.size.width;
    }
}
@end
