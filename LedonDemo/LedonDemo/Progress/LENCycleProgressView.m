//
//  LENCycleProgressView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/6/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENCycleProgressView.h"

#define OutLineWidth 10.0f
#define InLineWidth 10.0f
#define OutFillColor [UIColor clearColor].CGColor
#define InFillColor [UIColor clearColor].CGColor
#define OutStrokeColor [UIColor grayColor].CGColor
#define InStrokeColor [UIColor orangeColor].CGColor
@interface LENCycleProgressView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, assign) CGFloat width;

@end

@implementation LENCycleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self.frame = frame;
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.width = self.frame.size.width / 2;
    [self setUpLayer];
}

- (void)setUpLayer{
    // 设置第一条背景线
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = InFillColor; // 设置填充颜色
    self.shapeLayer.lineWidth = InLineWidth; // 线条宽度
    self.shapeLayer.strokeColor = InStrokeColor; // 线条颜色
    // 用贝塞尔曲线画出一个圆
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(self.width, 0)]; // 初始线段起点
    [path addArcWithCenter:CGPointMake(self.width, self.width) radius:self.width - OutLineWidth/2 startAngle:1.5*M_PI endAngle:3.5*M_PI clockwise:YES]; // 画出圆弧
    // 设置第二条背景线
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.fillColor = OutFillColor;
    self.shapeLayer2.lineWidth = OutLineWidth;
    self.shapeLayer2.strokeColor = OutStrokeColor;
    //
    self.shapeLayer2.path = path.CGPath;
    self.shapeLayer.path = path.CGPath;
    // 设置起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    [self.layer addSublayer:self.shapeLayer2];
    [self.layer addSublayer:self.shapeLayer];
}

- (void)circleAnimationWithValue:(CGFloat)value{
    self.shapeLayer.strokeEnd = value;
}




@end
