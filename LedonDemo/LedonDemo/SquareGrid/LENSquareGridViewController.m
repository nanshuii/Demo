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
    self.sgView = [[LENSquareGridView alloc] initWithFrame:CGRectMake(0, 88, 414, 232) horizontal:20 vertical:20 nums:[NSMutableArray new]];
    [self.view addSubview:self.sgView];
    
    UIButton *clearButton = [UIButton new];
    clearButton.frame = CGRectMake(20, 480, 80, 30);
    clearButton.backgroundColor = [UIColor redColor];
    [clearButton setTitle:@"Clear" forState:(UIControlStateNormal)];
    [clearButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [clearButton addTarget:self action:@selector(clear) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:clearButton];
    
    UIButton *closureButton = [UIButton new];
    closureButton.frame = CGRectMake(120, 480, 80, 30);
    closureButton.backgroundColor = [UIColor blueColor];
    [closureButton setTitle:@"Closure" forState:(UIControlStateNormal)];
    [closureButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [closureButton addTarget:self action:@selector(closure) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:closureButton];
    
    UIButton *commitButton = [UIButton new];
    commitButton.frame = CGRectMake(220, 480, 80, 30);
    commitButton.backgroundColor = [UIColor greenColor];
    [commitButton setTitle:@"Commit" forState:(UIControlStateNormal)];
    [commitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [commitButton addTarget:self action:@selector(commit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:commitButton];
    
    UIButton *eraserButton = [UIButton new];
    eraserButton.frame = CGRectMake(320, 480, 80, 30);
    eraserButton.backgroundColor = [UIColor redColor];
    [eraserButton setTitle:@"Eraser" forState:(UIControlStateNormal)];
    [eraserButton setTitle:@"Brush" forState:(UIControlStateSelected)];
    [eraserButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [eraserButton addTarget:self action:@selector(eraser:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:eraserButton];
}

- (void)clear{
    [self.sgView clear];
}

- (void)commit{
    [self.sgView commit];
}

- (void)closure{
    [self.sgView closure];
}

- (void)eraser:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.sgView eraser];
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
