//
//  LENSquareGridView.h
//  LedonDemo
//
//  Created by 林南水 on 2019/5/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENSquareGridView : UIView

/**
 初始化

 @param frame 初始化
 @param horizontal x轴
 @param vertical y轴
 @param nums nums description
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame horizontal:(int)horizontal vertical:(int)vertical nums:(NSMutableArray *)nums;

/**
 清除所有内容
 */
- (void)clear;

/**
 提交
 */
- (void)commit;

/**
 闭合选中的部分
 */
- (void)closure;

/**
 开始橡皮擦模式/画笔模式
 */
- (void)eraser;

@end

NS_ASSUME_NONNULL_END
