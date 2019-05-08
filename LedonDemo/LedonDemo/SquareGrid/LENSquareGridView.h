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

- (instancetype)initWithFrame:(CGRect)frame horizontal:(int)horizontal vertical:(int)vertical nums:(NSMutableArray *)nums;

- (void)clear;

- (void)commit;

@end

NS_ASSUME_NONNULL_END
