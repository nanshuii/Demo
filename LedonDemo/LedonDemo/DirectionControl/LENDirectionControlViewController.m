//
//  LENDirectionControlViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/6/11.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENDirectionControlViewController.h"
#import "StakeView.h"

@interface LENDirectionControlViewController ()<StakeDelegate>

@end

@implementation LENDirectionControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    StakeView *s = [[StakeView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    s.delegate = self;
    [self.view addSubview:s];
}

- (void)stakeDidChange:(CGPoint)offset{
    NSLog(@"point x = %f y = %f", offset.x, offset.y);
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
