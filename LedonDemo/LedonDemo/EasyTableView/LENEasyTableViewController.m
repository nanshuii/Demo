//
//  LENEasyTableViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENEasyTableViewController.h"
#import "UITableView+LENEasy.h"
#import "LENEasyTableViewTextModel.h"

@interface LENEasyTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation LENEasyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"EasyTableView";
    [self setUpUI];
}

- (void)setUpUI{
    [self faker];
    [self.contentView addSubview:self.tableView];
}

- (void)faker{
    self.models = [NSMutableArray new];
    LENEasyTableViewTextModel *model1 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"single center title"];
    LENEasyTableViewTextModel *model2 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"center title + switch YES" switchValue:YES];
    LENEasyTableViewTextModel *model3 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"center title + switch NO" switchValue:NO];
    LENEasyTableViewTextModel *model4 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"center title" rightTitle:@"right title"];
    LENEasyTableViewTextModel *model5 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"center title" rightTitle:@"right title" leftImage:[UIImage imageNamed:@"zhu_right"]];
    LENEasyTableViewTextModel *model6 = [[LENEasyTableViewTextModel alloc] initWithCenterTitle:@"center title" rightTitle:@"right title" leftImage:[UIImage imageNamed:@"zhu"] rightImage:[UIImage imageNamed:@"zhu_right"]];
    LENEasyTableViewTextModel *model7 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title"];
    LENEasyTableViewTextModel *model8 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title" rightTitle:@"right title"];
    LENEasyTableViewTextModel *model9 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title" rightTitle:@"right title" leftImage:[UIImage imageNamed:@"zhu"]];
    LENEasyTableViewTextModel *model10 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title" rightTitle:@"right title" leftImage:[UIImage imageNamed:@"zhu"] rightImage:[UIImage imageNamed:@"zhu_right"]];
    LENEasyTableViewTextModel *model11 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title" switchValue:YES];
    LENEasyTableViewTextModel *model12 = [[LENEasyTableViewTextModel alloc] initWithLeftTitle:@"left title" subTitle:@"sub title" switchValue:NO];
    NSArray *models = @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12];
    [self.models addObject:models];
}

# pragma mark -- tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) style:(UITableViewStyleGrouped)];
        NSArray *types = @[@(LENEasyTableViewCellTypeText)];
        [_tableView registerNibWithTypes:types];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *models = self.models[section];
    NSLog(@"count = %li", models.count);
    return models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *models = self.models[indexPath.section];
    LENEasyTableViewModel *model = models[indexPath.row];
    LENEasyTableViewCellType type = model.type;
    if (type == LENEasyTableViewCellTypeText) {
        LENEasyTableViewTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[LENEasyTableViewTextCell identifierGet] forIndexPath:indexPath];
        [cell configWithTextModel:model];
        [cell setSwitchBlock:^(BOOL value) {
            NSLog(@"switch value = %i", value);
        }];
        return cell;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"TextCell";
    }
    return @"";
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
