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

@property (nonatomic, strong) NSMutableArray *tempIndexs;

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
            int index = i * self.horizontal + j;
            //
            int number = [self.nums[index] intValue];
            if (number == 1) {
                [self.indexs addObject:@(index)];
                view.backgroundColor = DefaultColor;
            }
            [self addSubview:view];
            [self.views addObject:view];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch begin");
    self.tempIndexs = [NSMutableArray array];
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
    // 结算这次的区域
    [self closure];
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
    if (xIndex >= self.horizontal || xIndex < 0) {
        return;
    }
    if (yIndex >= self.vertical || yIndex < 0) {
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
            [self.tempIndexs addObject:@(index)];
        }
    }
}

# pragma mark -- 闭合
- (void)closure{
    NSLog(@"开始闭合");
    int lastIndex = -1;
    int lastIndexMax = -1;
    int lastHorizontal = -1;
    int tempHorizontal = -1;
    int horizontal = -1;
    int n = 0;
    [self.tempIndexs sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if ([obj1 intValue] < [obj2 intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    if (self.tempIndexs.count > 0) {
        for (NSNumber *number in self.tempIndexs) {
            int index = [number intValue];
            horizontal = (index) / self.horizontal;
            if (lastIndex == -1 || lastHorizontal == -1 || lastIndexMax == -1) {
                lastIndex = index;
                lastHorizontal = horizontal;
                lastIndexMax = index;
            } else {
                NSLog(@"horizontal = %i last horizontal = %i", horizontal, lastHorizontal);
                if (lastHorizontal == horizontal) {
                    // 同一行
                    lastIndexMax = index;
                    n += 1;
                } else {
                    // 不是同一行 判断是否一行有两个
                    if (lastIndexMax - lastIndex > 1) {
                        NSMutableArray *temp = [self tempIndexHorizontalCreate:lastIndex max:lastIndexMax];
                        // 加入到数组中
                        [self tempArrayInsertToIndexs:temp];
                    }
                    tempHorizontal = lastHorizontal;
                    lastIndex = index;
                    lastHorizontal = horizontal;
                    n = 0;
//                    lastIndexMax = index;
                }
            }
        }
    }
    // 判断最后一行有几个
    if (n >= 1) {
        if (lastIndexMax - lastIndex > 1) {
            NSMutableArray *temp = [self tempIndexHorizontalCreate:lastIndex max:lastIndexMax];
            // 加入到数组中
            [self tempArrayInsertToIndexs:temp];
        }
    }
    
    [self.tempIndexs removeAllObjects];
}

- (NSMutableArray *)tempIndexHorizontalCreate:(int)min max:(int)max{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < max - min - 1; i++) {
        [array addObject:@(min+i+1)];
    }
    return array;
}

- (void)tempArrayInsertToIndexs:(NSMutableArray *)array{
    NSLog(@"temps = %@", array.description);
    for (NSNumber *number in array) {
        if ([self.indexs containsObject:number]) {
            
        } else {
            int index = [number intValue];
            NSLog(@"insert temp = %i", index);
            UIView *view = self.views[index];
            view.backgroundColor = DefaultColor;
            self.views[index] = view;
            [self.indexs addObject:number];
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
- (NSMutableArray *)commit{
    NSLog(@"index = %@", self.indexs.description);
    return self.indexs;
}



# pragma mark -- 开始橡皮擦模式/画笔模式
- (void)eraser{
    self.eraserMode = !self.eraserMode;
}



@end
