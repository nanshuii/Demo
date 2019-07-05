//
//  UITableViewCell+LENEasy.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "UITableViewCell+LENEasy.h"

@implementation UITableViewCell (LENEasy)

+ (NSString *)identifierGet{
    return NSStringFromClass([self class]);
}

+ (UINib *)nibGet{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
