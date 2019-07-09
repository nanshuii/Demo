//
//  LENTurnTableView.h
//  LedonDemo
//
//  Created by 林南水 on 2019/7/5.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FoodBlock)(NSString *title, int index);

@interface LENTurnTableView : UIView

/**
 初始化 比率相同 并且颜色随机

 @param frame frame description
 @param titles titles description
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;


/**
 初始化 自定义比率 颜色随机

 @param frame frame description
 @param titles titles description
 @param rates rates description
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles rates:(NSArray *)rates;

/**
 初始化 比率随机 自定义颜色

 @param frame frame description
 @param titles titles description
 @param colors colors description
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles colors:(NSArray *)colors;

/**
 初始化 自定义比率 自定义颜色

 @param frame frame description
 @param titles titles description
 @param rates rates description
 @param colors colors description
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles rates:(NSArray *)rates colors:(NSArray *)colors;


@property (nonatomic, copy) FoodBlock foodBlock;


/**
 开始转圈
 */
- (void)startCycle;



@end

NS_ASSUME_NONNULL_END
