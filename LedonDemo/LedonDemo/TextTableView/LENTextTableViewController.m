//
//  LENTextTableViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/18.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENTextTableViewController.h"
#import "LENTextTableView.h"
#import "LENTextTableEditViewController.h"

@interface LENTextTableViewController ()

@property (nonatomic, strong) LENTextTableView *tableView;

@end

@implementation LENTextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editDone:) name:@"kLENTextTableEditDoneNotification" object:nil];
    [self setUpUI];
}

- (void)setUpUI{
    NSArray *array = @[@"福建省法律框架卅六块腹肌轮廓撒娇福利开始就\n离开房间里\n上课就犯困洛杉矶附近阿斯科利飞机卡拉斯京分开了撒娇风口浪尖卅六块腹肌时刻垃圾分类开始就分开了", @"fsdfsafsd", @"fsdfjaslkfjklsjfkljsklfjsflkasjflkjskldfjlkjflksdjlkf"];
    self.tableView = [[LENTextTableView alloc] initWithFrame:CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) sources:[NSMutableArray arrayWithArray:array]];
    [self.tableView setDidSelected:^(NSInteger index, NSString *text) {
        LENTextTableEditViewController *vc = [LENTextTableEditViewController new];
        vc.text = text;
        vc.index = index;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [self.view addSubview:self.tableView];
}

# pragma mark -- edit done
- (void)editDone:(NSNotification *)notification{
    NSDictionary *dict = (NSDictionary *)notification.object;
    NSInteger index = [[dict valueForKey:@"index"] integerValue];
    NSString *text = [dict valueForKey:@"text"];
    [self.tableView reloadWithText:text index:index];
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
