//
//  UITableView+LENEasy.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "UITableView+LENEasy.h"

@implementation UITableView (LENEasy)

# pragma mark -- 根据类型数组注册cell
- (void)registerNibWithTypes:(NSArray *)types{
    for (NSNumber *number in types) {
        LENEasyTableViewCellType type = [number intValue];
        switch (type) {
            case LENEasyTableViewCellTypeText:
                [self registerNib:[LENEasyTableViewTextCell nibGet] forCellReuseIdentifier:[LENEasyTableViewTextCell identifierGet]];
                break;
                
            default:
                break;
        }
    }
}

@end
