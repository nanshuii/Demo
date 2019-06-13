//
//  LENSquareGridView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/5/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENSquareGridView.h"

#define DefaultColor [UIColor redColor]
#define OriginalColor [UIColor clearColor]
@interface LENSquareGridView()

@property (nonatomic, strong) NSMutableArray *nums; // 双重数组

@property (nonatomic, strong) NSMutableArray *views;

@property (nonatomic, strong) NSMutableArray *indexs;

@property (nonatomic, assign) int horizontal;

@property (nonatomic, assign) int vertical;

@property (nonatomic, assign) BOOL eraserMode;

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
            view.backgroundColor = OriginalColor;
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 0.3;
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
    if (xIndex >= self.horizontal - 1 || xIndex < 0) {
        return;
    }
    if (yIndex >= self.vertical - 1 || yIndex < 0) {
        return;
    }
    int index = yIndex * self.horizontal + xIndex;
    if (self.eraserMode) {
        if ([self.indexs containsObject:@(index)]) {
            UIView *view = self.views[index];
            view.backgroundColor = OriginalColor;
            self.views[index] = view;
            [self.indexs removeObject:@(index)];
        } else {
            
        }
    } else {
        if ([self.indexs containsObject:@(index)]) {
            
        } else {
            UIView *view = self.views[index];
            view.backgroundColor = DefaultColor;
            self.views[index] = view;
            [self.indexs addObject:@(index)];
        }
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

# pragma mark -- 闭合
- (void)closure{
    NSLog(@"开始闭合");
}

# pragma mark -- 开始橡皮擦模式/画笔模式
- (void)eraser{
    self.eraserMode = !self.eraserMode;
}



@end
