//
//  ViewController.m
//  DJAlertViewDemo
//
//  Created by chentengfei on 16/9/22.
//  Copyright © 2016年 chentengfei. All rights reserved.
//

#import "ViewController.h"

#import "SYAlertViewFactory.h"


@interface ViewController ()<DJAbstractAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)limitNoticeBtnClick:(UIButton *)sender {
    
    SYAlertViewFactory *factory = [[SYAlertViewFactory alloc] init];
    DJAbstractAlertView *alertView = [factory alertViewWithType:kSYAlertViewType_SYLimitNoticeAlertView];
    if ([alertView isKindOfClass:[SYLimitNoticeAlertView class]]) {
        ((SYLimitNoticeAlertView *)alertView).titleStr = @"根据太原市<车辆限行管理规定>: 小型平板、大型平板车型在市内某些路段限行, 你的订单实际里程费与预估里程可能存在偏差。如无人接单, 建议您更改车型或用车时间, 感谢您的理解与支持!";
    }
    alertView.delegate = self;
    
    [alertView show];
}


/** 加小费弹窗 */
- (IBAction)dispatchAddFreeBtnClick:(UIButton *)sender {
    
    // 新的弹窗
    SYAlertViewFactory *factory = [[SYAlertViewFactory alloc] init];
    
    SYOrderAddFreeAlertView *alertView = (SYOrderAddFreeAlertView *)[factory alertViewWithType:SYAlertViewType_SYOrderAddFreeAlertView];
    alertView.zeroEnable = YES;
    alertView.delegate = self;
    alertView.freeNums = @[@"10", @"20", @"30"];
    [alertView setDefaultTip:10];
    
    [alertView show];
}

/** 派单中加小费 */
- (IBAction)dispatchingAddFreeBtnClick:(UIButton *)sender {
    
    SYDispatchingAddFreeAlertView *belowTipAlertViewNew;
    
    SYAlertViewFactory *factory = [[SYAlertViewFactory alloc] init];
    belowTipAlertViewNew = (SYDispatchingAddFreeAlertView *)[factory alertViewWithType:kSYAlertViewType_SYDispatchingAddFreeAlertView];
    belowTipAlertViewNew.delegate = self;
    belowTipAlertViewNew.freeNums = @[@"10", @"20", @"30"];
    belowTipAlertViewNew.titleStr = @"提示: 优惠券不能抵扣小费费用";
    [belowTipAlertViewNew setDefaultTip:10];
    
    [belowTipAlertViewNew show];
}


/** 显示两个AlertView */
- (IBAction)showMoreAlertBtnClick:(UIButton *)sender {
    
    [self limitNoticeBtnClick:nil];
    [self dispatchAddFreeBtnClick:nil];
}


/** 平安理赔弹窗 */
- (IBAction)insuranceAlertBtnClick:(UIButton *)sender {
    
    SYAlertViewFactory *factory = [[SYAlertViewFactory alloc] init];
    SYInsuranceProgressAlertView *insuranceAlertView = (SYInsuranceProgressAlertView *)[factory alertViewWithType:SYAlertViewType_SYInsuranceProgressAlertView];
    
    NSString *progressStr = @"理赔中";
    insuranceAlertView.progressStr = progressStr;
    [insuranceAlertView show];
}

- (IBAction)AddFreeBtnClick:(id)sender {
    
    SYAlertViewFactory *factory = [[SYAlertViewFactory alloc] init];
    SYAddFeeAlertView *alertView = (SYAddFeeAlertView *)[factory alertViewWithType:kSYAlertViewType_SYAddFeeAlertView];
    
    [alertView show];
}

@end
