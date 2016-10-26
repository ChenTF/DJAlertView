//
//  SYOrderAddFreeAlertView.m
//  Pods
//
//  Created by chentengfei on 16/9/23.
//
//

#import "SYOrderAddFreeAlertView.h"
#import "UIColor+Hex.h"
#import "NSString+DJStrUtils.h"

@interface SYOrderAddFreeAlertView()<UITextFieldDelegate>

@end

@implementation SYOrderAddFreeAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [self.contentView removeObserver:self forKeyPath:@"hasButtonSelected"];
    
}

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
    headView.titleLabel.text = @"提示: 优惠券不能抵扣小费费用";
    headView.titleLabel.textColor = [UIColor ColorOfHex:0x666666];
    headView.titleLabel.font = [UIFont systemFontOfSize:15.0];
    headView.titleEdge = UIEdgeInsetsMake(20, 15, 10, 15);
    self.headView = headView;
    
    SYAlertDispatchingAddFreeContentView *contentView = [[SYAlertDispatchingAddFreeContentView alloc] initWithFreeNums:self.freeNums
                                                                                                         HaveTextField:YES];
    contentView.contentEdge = UIEdgeInsetsMake(0, 15, 15, 15);
    [contentView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    contentView.textField.delegate = self;
    
    [contentView addObserver:self forKeyPath:@"hasButtonSelected" options:NSKeyValueObservingOptionNew context:nil];
    
    self.contentView = contentView;
    
    
    DJAlertDoubleActionView *doubleActionView = [[DJAlertDoubleActionView alloc] initWithDelegate:self];
    self.actionView = doubleActionView;
    // 默认不可用
    [((DJAlertDoubleActionView *)self.actionView).okBtn setSelected:NO];
    ((DJAlertDoubleActionView *)self.actionView).okBtn.userInteractionEnabled = NO;
}

- (void)setFreeNums:(NSArray *)freeNums {
    _freeNums = freeNums;
    ((SYAlertDispatchingAddFreeContentView *)self.contentView).freeNums = freeNums;
}

- (void)showCompletionMethods {
    [((SYAlertDispatchingAddFreeContentView *)self.contentView).textField becomeFirstResponder];
}

- (void)show {
    [super show];
}

#pragma mark - Outer Method

- (NSString *)fetchTipResult {
    return [((SYAlertDispatchingAddFreeContentView *)self.contentView) fetchTipResult];
}

- (void)setDefaultTip:(NSInteger)tip {
    if (tip > 0) {
        [((SYAlertDispatchingAddFreeContentView *)self.contentView) setDefaultTipStr:[NSString stringWithFormat:@"%zd", tip]];
        [self configOkButtonState:YES];
    }
}

#pragma mark - TextField text change

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    SYAlertDispatchingAddFreeContentView *contentView = (SYAlertDispatchingAddFreeContentView *)self.contentView;
    [contentView cancelTipSelectedButton];
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (![self validateNumber:textField.text]) {
        textField.text = @"";
    } else {
        if ([textField.text floatValue] > 200.0) {
            textField.text = @"200";
        }
    }
    
    SYAlertDispatchingAddFreeContentView *contentView = (SYAlertDispatchingAddFreeContentView *)self.contentView;
    
    if ((textField.text.length < 2 && [textField.text isEqualToString:@"0"]) || textField.text.length == 0) {
        if (self.zeroEnable) {
            if ([textField.text isEqualToString:@"0"]) {
                [contentView cancelTipSelectedButton];
                [contentView configTextFieldActive:YES];
                [self configOkButtonState:YES];
                return;
            }
        }
        textField.text = @"";
        [self configOkButtonState:NO];
        [contentView configTextFieldActive:NO];
        
    } else{
        [contentView cancelTipSelectedButton];
        [contentView configTextFieldActive:YES];
        [self configOkButtonState:YES];
    }
    if (textField.text.length > 1 && [textField.text substringToIndex:1].intValue == 0) {
        textField.text = [textField.text substringWithRange:NSMakeRange(1,1)];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hasButtonSelected"]) {
        BOOL hasButtonSelected = [[change valueForKey:NSKeyValueChangeNewKey] boolValue];
        
        SYAlertDispatchingAddFreeContentView *contentView = (SYAlertDispatchingAddFreeContentView *)self.contentView;
        if ([NSString isEmptyString: contentView.textField.text]) {
            if (hasButtonSelected) {
                [self configOkButtonState:YES];
            } else {
                [self configOkButtonState:NO];
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Tools

- (void)configOkButtonState:(BOOL)canClick {
    if (self.zeroTipOkButtonCanClick) { // 如果开启可用，则不继续进行逻辑。
        return;
    }
    UIButton * okButton = ((DJAlertDoubleActionView *)self.actionView).okBtn;
    if (canClick) {
        [okButton setSelected:YES];
        [okButton setUserInteractionEnabled:YES];
    } else {
        [okButton setUserInteractionEnabled:NO];
        [okButton setSelected:NO];
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end
