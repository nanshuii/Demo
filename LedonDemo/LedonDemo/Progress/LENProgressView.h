//
//  LENProgressView.h
//  LedonDemo
//
//  Created by 林南水 on 2019/9/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    LENProgressTypeNormal,
    LENProgressTypeCircle,
} LENProgressType;

@interface LENProgressView : UIView

@property (nonatomic, assign) BOOL bgShow; // 是否显示背景

@property (nonatomic, strong) UIColor *bgColor; // 背景颜色

- (instancetype)initWithFrame:(CGRect)frame type:(LENProgressType)type colors:(NSArray *)colors;

@end

NS_ASSUME_NONNULL_END
