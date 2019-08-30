//
//  LENButtonAnimation.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/26.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENButtonAnimation.h"
#import "Masonry.h"

#define FullScreenWidth           ([UIScreen mainScreen].bounds.size.width)
#define FullScreenHeight          ([UIScreen mainScreen].bounds.size.height)
@interface LENButtonAnimation()

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, assign) CGRect leftFrame;

@property (nonatomic, assign) CGRect rightFrame;

@property (nonatomic, assign) CGRect originFrame;

@end

@implementation LENButtonAnimation

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    background.image = [UIImage imageNamed:@"background"];
    background.userInteractionEnabled = YES;
    [self addSubview:background];
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundView)];
    [background addGestureRecognizer:tapBackground];
    
    CGFloat cancelBottom = 37;
    CGFloat cancelWidth = 42;
    if (FullScreenHeight >= 812) {
        cancelBottom += 83;
    } else {
        cancelBottom += 49;
    }
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(FullScreenWidth / 2 - cancelWidth / 2, FullScreenHeight - cancelBottom - cancelWidth, cancelWidth, cancelWidth)];
    [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.cancelButton];
    
    self.originFrame = self.cancelButton.frame;
    
    CGFloat buttonWidth = 66;
    CGFloat buttonMargin = 35;
    self.leftView  = [[UIView alloc] initWithFrame:CGRectMake(self.originFrame.origin.x - buttonMargin - buttonWidth, self.originFrame.origin.y - buttonMargin, buttonWidth, buttonWidth)];
    self.leftFrame = self.leftView.frame;
    self.leftView.alpha = 1;
    [self addSubview:self.leftView];
    
    
    
    self.leftView.frame = self.originFrame;
}


# pragma mark -- cancel
- (void)tapBackgroundView{
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)cancel{
    if (_cancelBlock) {
        _cancelBlock();
    }
}



@end
