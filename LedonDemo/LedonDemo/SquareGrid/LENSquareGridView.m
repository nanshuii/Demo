//
//  LENSquareGridView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/5/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENSquareGridView.h"

#define DefaultColor [UIColor redColor]
@interface LENSquareGridView()

@property (nonatomic, strong) NSMutableArray *nums; // 双重数组

@property (nonatomic, strong) NSMutableArray *views;

@property (nonatomic, strong) NSMutableArray *indexs;

@property (nonatomic, assign) int horizontal;

@property (nonatomic, assign) int vertical;

@end

@implementation LENSquareGridView

- (instancetype)initWithFrame:(CGRect)frame horizontal:(int)horizontal vertical:(int)vertical nums:(NSMutableArray *)nums{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.nums = nums;
        self.horizontal = horizontal;
        self.vertical = vertical;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor lightGrayColor];
    self.views = [NSMutableArray new];
    self.indexs = [NSMutableArray new];
    CGFloat width = self.frame.size.width / self.horizontal;
    CGFloat height = self.frame.size.height / self.vertical;
    for (int i = 0; i < self.vertical; i++) {
        for (int j = 0; j < self.horizontal; j++) {
            UIView *view = [UIView new];
            view.frame = CGRectMake(width * j, height * i, width, height);
            view.backgroundColor = [UIColor clearColor];
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 0.5;
            view.tag = i * self.horizontal + j;
            [self addSubview:view];
            [self.views addObject:view];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch begin");
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        NSLog(@"x = %f y = %f", point.x, point.y);
        [self calForPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch end");
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        NSLog(@"x = %f y = %f", point.x, point.y);
        [self calForPoint:point];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"move");
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        NSLog(@"x = %f y = %f", point.x, point.y);
        [self calForPoint:point];
    }
}

- (void)calForPoint:(CGPoint)point{
    CGFloat x = point.x;
    CGFloat y = point.y;
    CGFloat width = self.frame.size.width / self.horizontal;
    CGFloat height = self.frame.size.height / self.vertical;
    int xIndex = x / width;
    int yIndex = y / height;
    int index = yIndex * self.horizontal + xIndex;
    if ([self.indexs containsObject:@(index)]) {
        
    } else {
        UIView *view = self.views[index];
        view.backgroundColor = DefaultColor;
        self.views[index] = view;
        [self.indexs addObject:@(index)];
    }
}

# pragma mark -- 全部清空
- (void)clear{
    for (NSNumber *num in self.indexs) {
        int index = [num intValue];
        UIView *view = self.views[index];
        view.backgroundColor = [UIColor clearColor];
        self.views[index] = view;
    }
    [self.indexs removeAllObjects];
}

# pragma mark -- 数据提交
- (void)commit{
    NSLog(@"index = %@", self.indexs.description);
}



@end
