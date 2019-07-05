//
//  LENCyleControlView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/1.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENCyleControlView.h"
#define LineColor [UIColor lightGrayColor].CGColor;

@interface LENCyleControlView()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) int direction; // 0 上 1 下 2 左 3 右

@property (nonatomic, assign) BOOL begin;

@end

@implementation LENCyleControlView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.width = self.frame.size.width;
    self.layer.cornerRadius = self.width / 2;
    self.layer.borderColor = LineColor;
    self.layer.borderWidth = 1;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    [self directionViewCreate];
}


# pragma mark -- 长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"开始长按");
            [self beginWithPoint:point];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"结束长按");
            [self viewHidden];
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"取消长按");
            [self viewHidden];
            break;
        default:
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)beginWithPoint:(CGPoint)point{
    self.begin = YES;
    CGFloat x = point.x;
    CGFloat y = point.y;
    NSLog(@"width = %f x = %f y = %f", self.width, x, y);
    if (x >= self.width - y) {
        // 右和下
        if (y >= x) {
            // 下
            [self bottomShow];
        } else {
            [self rightShow];
        }
    } else {
        // 左和上
        if (self.width - y >= self.width - x) {
            // 上
            [self topShow];
        } else {
            [self leftShow];
        }
    }
}

- (void)end{
    if (self.begin) {
        self.begin = NO;
        [self viewHidden];
    }
}


# pragma mark -- 四个方向视图的创建
- (void)directionViewCreate{
    CGFloat width = 0.35 * self.width;
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake((self.width - width) / 2, 0, width, width)];
    self.topView.backgroundColor = [UIColor blueColor];
    self.topView.layer.cornerRadius = width / 2;
    [self addSubview:self.topView];
    self.topView.hidden = YES;
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.width - width) / 2, width, width)];
    self.leftView.backgroundColor = [UIColor redColor];
    self.leftView.layer.cornerRadius = width / 2;
    [self addSubview:self.leftView];
    self.leftView.hidden = YES;
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake((self.width - width) / 2, self.width - width, width, width)];
    self.bottomView.backgroundColor = [UIColor yellowColor];
    self.bottomView.layer.cornerRadius = width / 2;
    [self addSubview:self.bottomView];
    self.bottomView.hidden = YES;
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(self.width - width, (self.width - width) / 2, width, width)];
    self.rightView.backgroundColor = [UIColor greenColor];
    self.rightView.layer.cornerRadius = width / 2;
    [self addSubview:self.rightView];
    self.rightView.hidden = YES;
}

- (void)topShow{
    self.topView.hidden = NO;
    self.direction = 0;
}

- (void)bottomShow{
    self.bottomView.hidden = NO;
    self.direction = 1;
}

- (void)leftShow{
    self.leftView.hidden = NO;
    self.direction = 2;
}

- (void)rightShow{
    self.rightView.hidden = NO;
    self.direction = 3;
}

- (void)viewHidden{
    self.topView.hidden = YES;
    self.bottomView.hidden = YES;
    self.leftView.hidden = YES;
    self.rightView.hidden = YES;
}



@end
