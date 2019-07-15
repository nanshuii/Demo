//
//  LENColorSelectView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/11.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENColorSelectView.h"
#import "LENColorDefine.h"

@implementation LENColorSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    CGFloat width = self.frame.size.width / 16;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < 16; i++) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(i * width, 0, width, height);
        CGPoint startPoint = CGPointMake(0.0, 0.0);
        CGPoint endPoint = CGPointMake(0.0, 1.0);
        layer.startPoint = startPoint;
        layer.endPoint = endPoint;
        int f = 1048575;
        int end_f = i * (pow(16, 5)) + f;
        int start_f = i * (pow(16, 5));
        layer.colors = @[(__bridge id)UIColorFromHex(start_f).CGColor,  (__bridge id)UIColorFromHex(end_f).CGColor];
        [self.layer addSublayer:layer];
    }
}



@end
