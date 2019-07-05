//
//  UITableView+LENEasy.h
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LENEasyTableViewCells.h"

NS_ASSUME_NONNULL_BEGIN



@interface UITableView (LENEasy)

/**
 根据类型数组注册cell

 @param types types description
 */
- (void)registerNibWithTypes:(NSArray *)types;

@end

NS_ASSUME_NONNULL_END
