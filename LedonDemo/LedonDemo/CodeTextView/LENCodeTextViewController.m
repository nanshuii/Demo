//
//  LENCodeTextViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/5.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENCodeTextViewController.h"
#import "HWTFCodeView.h"
#import "HWTFCodeBView.h"
#import "HWTextCodeView.h"

@interface LENCodeTextViewController ()

@property (nonatomic, weak) HWTFCodeView *code1View;

@property (nonatomic, weak) HWTFCodeBView *code2View;

@property (nonatomic, weak) HWTextCodeView *code3View;

@end

@implementation LENCodeTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.title = @"验证码输入";
    
    CGFloat x = 30;
    CGFloat w = [UIScreen mainScreen].bounds.size.width - x * 2;
    NSLog(@"width = %f", w);
    CGFloat h = 50;
    CGFloat y = 100;
    
    // --------------------------------------------------------------------
    
    UILabel *labA = [UILabel new];
    labA.textColor = [UIColor orangeColor];
    labA.font = [UIFont systemFontOfSize:13];
    labA.text = @"基本实现原理 - 下划线";
    labA.frame = CGRectMake(x, y, 200, 15);
    [self.view addSubview:labA];
    
    y = CGRectGetMaxY(labA.frame) + 10;
    
    HWTFCodeView *code1View = [[HWTFCodeView alloc] initWithCount:6 margin:20];
    code1View.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:code1View];
    self.code1View = code1View;
    [self.code1View setCodeDone:^(NSString * _Nonnull code) {
        NSLog(@"code1View code = %@", code);
    }];
    
    
    // --------------------------------------------------------------------
    
    y = CGRectGetMaxY(code1View.frame) + 80;
    
    UILabel *labB = [UILabel new];
    labB.textColor = [UIColor orangeColor];
    labB.font = [UIFont systemFontOfSize:13];
    labB.text = @"基本实现原理 - 方块";
    labB.frame = CGRectMake(x, y, 200, 15);
    [self.view addSubview:labB];
    
    y = CGRectGetMaxY(labB.frame) + 30;
    
    HWTFCodeBView *code2View = [[HWTFCodeBView alloc] initWithCount:6 margin:20];
    code2View.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:code2View];
    self.code2View = code2View;
    [self.code2View setCodeDone:^(NSString * _Nonnull code) {
        NSLog(@"code2View code = %@", code);
    }];
    
    
    // --------------------------------------------------------------------
    
    y = CGRectGetMaxY(code2View.frame) + 80;
    
    UILabel *labC = [UILabel new];
    labC.textColor = [UIColor orangeColor];
    labC.font = [UIFont systemFontOfSize:13];
    labC.text = @"完善版 - 加入动画 - 下划线";
    labC.frame = CGRectMake(x, y, 200, 15);
    [self.view addSubview:labC];
    
    y = CGRectGetMaxY(labC.frame) + 30;
    
    HWTextCodeView *code3View = [[HWTextCodeView alloc] initWithCount:6 margin:20];
    code3View.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:code3View];
    self.code3View = code3View;
    [self.code3View setCodeDone:^(NSString * _Nonnull code) {
        NSLog(@"code3View code = %@", code);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
