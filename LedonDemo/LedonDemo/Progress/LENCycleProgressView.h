//
//  LENCycleProgressView.h
//  LedonDemo
//
//  Created by 林南水 on 2019/6/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENCycleProgressView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)circleAnimationWithValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
