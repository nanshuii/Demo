//
//  LENColorSelectViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/11.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENColorSelectViewController.h"
#import "LENColorSelectView.h"

@interface LENColorSelectViewController ()

@end

@implementation LENColorSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    LENColorSelectView *selectView = [[LENColorSelectView alloc] initWithFrame:CGRectMake(0, 40, 375, 400)];
    [self.contentView addSubview:selectView];
    
    NSLog(@"%x", [self RGB:10 g:30 b:50]);
    NSLog(@"%x", [self RGB:20 g:40 b:60]);
    NSLog(@"%x", [self RGB:30 g:50 b:70]);
    NSLog(@"%x", [self RGB:40 g:60 b:80]);
    NSLog(@"%x", [self RGB:50 g:70 b:90]);
    NSLog(@"%x", [self RGB:60 g:80 b:110]);
    NSLog(@"%x", [self RGB:70 g:90 b:130]);
}

- (int)RGB:(int)r g:(int)g b:(int)b{
    return r << 16 | g << 8 | b;
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
