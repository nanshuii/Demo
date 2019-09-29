//
//  LENTextTableView.h
//  LedonDemo
//
//  Created by 林南水 on 2019/9/18.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidSelected)(NSInteger index, NSString *text);
@interface LENTextTableView : UIView

@property (nonatomic, copy) DidSelected didSelected;

@property (nonatomic, strong) NSMutableArray *sources;

- (instancetype)initWithFrame:(CGRect)frame sources:(NSMutableArray *)sources;

- (void)reloadWithText:(NSString *)text index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
