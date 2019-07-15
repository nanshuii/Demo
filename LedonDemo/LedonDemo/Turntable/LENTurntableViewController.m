//
//  LENTurntableViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/5.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENTurntableViewController.h"
#import "LENTurnTableView.h"

@interface LENTurntableViewController ()

@property (nonatomic, strong) LENTurnTableView *turnTV;

@end

@implementation LENTurntableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.label.text = @"吃什么饭？";
    self.turnTV = [[LENTurnTableView alloc] initWithFrame:CGRectMake(10, 0, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20) titles:@[@"快餐", @"沙县", @"炒菜", @"兰州拉面", @"陕西面", @"扈四爷"]];
    [self.turnTV setFoodBlock:^(NSString * _Nonnull title, int index) {
        self.label.text = title;
    }];
    [self.contentView addSubview:self.turnTV];
    
}

- (IBAction)run:(id)sender {
    [self.turnTV startCycle];
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
