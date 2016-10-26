
//
//  DJDetailHeadView.m
//  alertviewtest
//
//  Created by chentengfei on 16/9/5.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "DJAlertDetailHeadView.h"

@implementation DJAlertDetailHeadView

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
        
        _type = DJDetailHeadViewTypeTitle;
        
        // 标题Label
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        
        // 详情Label
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"详情";
        _detailLabel.numberOfLines = 0;
        
        // 布局
        _titleEdge = UIEdgeInsetsMake(0, 10, 0, 10);
        _detailEdge = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return self;
}


- (instancetype)initWithType:(DJDetailHeadViewType)type {
    self = [self init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)updateConstraints {
    
    // 标题Label
    [self addSubview:self.titleLabel];
    
    // 详情Label
    if (self.type == DJDetailHeadViewTypeDetail) {
        
        [self addSubview:self.detailLabel];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.titleEdge.top);
            make.left.equalTo(self).offset(self.titleEdge.left);
            make.right.equalTo(self).offset(-self.titleEdge.right);
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //            make.edges.equalTo(self).insets(self.detailEdge);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.titleEdge.bottom + self.detailEdge.top);
            make.left.equalTo(self).offset(self.detailEdge.left);
            make.right.equalTo(self).offset(-self.detailEdge.right);
            make.bottom.equalTo(self).offset(-self.detailEdge.bottom);
        }];
        
    } else {
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(self.titleEdge);
        }];
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width;
    self.detailLabel.preferredMaxLayoutWidth = self.detailLabel.frame.size.width;
    
    [super layoutSubviews];
}


#pragma mark - Public Methods

@end
