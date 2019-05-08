//
//  LENSquareGridViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/5/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENSquareGridViewController.h"
#import "LENSquareGridView.h"

@interface LENSquareGridViewController ()

@property (nonatomic, strong) LENSquareGridView *sgView;

@end

@implementation LENSquareGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"方块网格绘制";
    self.sgView = [[LENSquareGridView alloc] initWithFrame:CGRectMake(0, 88, 414, 414) horizontal:7 vertical:8 nums:[NSMutableArray new]];
    [self.view addSubview:self.sgView];
    
    UIButton *clearButton = [UIButton new];
    clearButton.frame = CGRectMake(10, 512, 60, 30);
    clearButton.backgroundColor = [UIColor redColor];
    [clearButton setTitle:@"Clear" forState:(UIControlStateNormal)];
    [clearButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [clearButton addTarget:self action:@selector(clear) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:clearButton];
    
    UIButton *commitButton = [UIButton new];
    commitButton.frame = CGRectMake(344, 512, 60, 30);
    commitButton.backgroundColor = [UIColor greenColor];
    [commitButton setTitle:@"Commit" forState:(UIControlStateNormal)];
    [commitButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [commitButton addTarget:self action:@selector(commit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:commitButton];
}

- (void)clear{
    [self.sgView clear];
}

- (void)commit{
    [self.sgView commit];
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
