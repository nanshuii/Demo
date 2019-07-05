//
//  LENDirectionControlViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/6/11.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENDirectionControlViewController.h"
#import "LENCyleControlView.h"

@interface LENDirectionControlViewController ()

@end

@implementation LENDirectionControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    LENCyleControlView *control = [[LENCyleControlView alloc] initWithFrame:CGRectMake(0, 200, 400, 400)];
    [self.view addSubview:control];
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
