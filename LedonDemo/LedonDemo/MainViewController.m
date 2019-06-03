//
//  MainViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/3/25.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "MainViewController.h"
#import "LENDocumentShareViewController.h"
#import "LENDocumentReceiveViewController.h"
#import "LENSquareGridViewController.h"
#import "LENQRCodeViewController.h"
#import "LENNotificationsViewController.h"

#define kStatusBarAndNavigationBarHeight (Is_Iphone_X) ? 88 : 64
#define Is_Iphone_X kFullScreenHeight >= 812.0
#define kFullScreenWidth           ([UIScreen mainScreen].bounds.size.width)
#define kFullScreenHeight          ([UIScreen mainScreen].bounds.size.height)

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) UITableView *baseTableView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titles = @[@[@"文件分享与快速预览", @"接收文件分享"],@[@"方块网格选择", @"二维码的生成和扫描", @"通知设定"]];
    [self.view addSubview:self.baseTableView];
}

# pragma mark -- TableView
- (UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, kFullScreenWidth, (kFullScreenHeight) - (kStatusBarAndNavigationBarHeight)) style:(UITableViewStyleGrouped)];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        [_baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"base"];
    }
    return _baseTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.titles[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"base"];
    NSArray *array = self.titles[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        LENDocumentShareViewController *vc = [LENDocumentShareViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        LENDocumentReceiveViewController *vc = [LENDocumentReceiveViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        LENSquareGridViewController *vc = [LENSquareGridViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        LENQRCodeViewController *vc = [LENQRCodeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        LENNotificationsViewController *vc = [LENNotificationsViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
