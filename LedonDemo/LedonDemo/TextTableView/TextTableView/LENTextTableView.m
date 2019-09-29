//
//  LENTextTableView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/18.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENTextTableView.h"
#import "LENTextTableViewCell.h"

@interface LENTextTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger lastIndex; // 上一次编辑的index

@end

@implementation LENTextTableView

- (instancetype)initWithFrame:(CGRect)frame sources:(NSMutableArray *)sources{
    self = [super initWithFrame:frame];
    if (self) {
        self.sources = sources;
        self.lastIndex = -1;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.tableView];
}

- (void)reloadWithText:(NSString *)text index:(NSInteger)index{
    self.sources[index] = text;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
}

# pragma mark -- tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LENTextTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LENTextTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LENTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LENTextTableViewCell class])];
    [cell configWithText:self.sources[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text = self.sources[indexPath.row];
    if (_didSelected) {
        _didSelected(indexPath.row, text);
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
