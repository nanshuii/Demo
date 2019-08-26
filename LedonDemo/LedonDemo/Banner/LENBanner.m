//
//  LENBanner.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/23.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENBanner.h"
#import "Masonry.h"

@interface LENBanner()<UIScrollViewDelegate>

#define LENBannerSelected @"banner_selected"
#define LENBannerNoSelected @"banner_no_selected"

@property (nonatomic, strong) NSMutableArray *sources;

@property (nonatomic, assign) int type; // 0 image 1 url

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *selects;

@property (nonatomic, assign) int index;

@property (nonatomic, assign) int lastIndex;

@property (nonatomic, assign) BOOL scrollEnd;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LENBanner

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.sources = images;
        self.type = 0;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.width = self.frame.size.width;
    self.height = self.frame.size.height;
    self.index = 0;
    self.lastIndex = 0;
    [self imageViewsCreate];
    [self selectsCreate];
    [self timerCreate];
}

# pragma mark -- imageView集合
- (void)imageViewsCreate{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.width * self.sources.count, self.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < self.sources.count; i++) {
        UIImage *image;
        if (self.type == 0) {
            image = self.sources[i];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(i * self.width, 0, self.width, self.height);
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)sender{
    NSInteger tag = sender.view.tag;
    if (_tapBannerIndex) {
        _tapBannerIndex(tag);
    }
}

# pragma mark -- 页面标记
- (void)selectsCreate{
    CGFloat widthMax = 10;
    CGFloat widthMin = 5;
    CGFloat height = 5;
    CGFloat margin = 6;
    CGFloat selectWidth = widthMax;
    CGFloat selectX = 0;
    self.selects = [NSMutableArray arrayWithCapacity:self.sources.count];
    
    if (self.sources.count > 1) {
        selectWidth = widthMax + widthMin * (self.sources.count - 2) + margin * (self.sources.count-1);
    }
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(self.width - selectWidth - 20, self.height - height - 10, selectWidth, height)];
    [self addSubview:selectView];
    
    UIImageView *imageView = nil;
    for (int i = 0; i < self.sources.count; i++) {
        UIImage *image = [UIImage imageNamed:LENBannerNoSelected];
        CGFloat width = widthMin;
        if (i == self.index) {
            image = [UIImage imageNamed:LENBannerSelected];
            width = widthMax;
        }
        UIImageView *select = [[UIImageView alloc] initWithImage:image];
        select.frame = CGRectMake(selectX, 0, width, height);
        [selectView addSubview:select];
        if (imageView) {
            [select mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(imageView.mas_top);
                make.left.mas_equalTo(imageView.mas_right).offset(margin);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }];
        }
        [self.selects addObject:select];
        selectX = selectX + width + margin;
        imageView = select;
    }
}

- (void)selectAnimation{
    if (self.lastIndex == self.index) {
        return;
    }
    CGFloat widthMax = 10;
    CGFloat widthMin = 5;
    CGFloat height = 5;
    
    UIImageView *lastSelect = self.selects[self.lastIndex];
    lastSelect.image = [UIImage imageNamed:LENBannerNoSelected];
    [lastSelect mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthMin);
        make.height.mas_equalTo(height);
    }];
    self.selects[self.lastIndex] = lastSelect;
    
    UIImageView *select = self.selects[self.index];
    select.image = [UIImage imageNamed:LENBannerSelected];
    [select mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthMax);
        make.height.mas_equalTo(height);
    }];
    self.selects[self.index] = select;
}

# pragma mark -- timer
- (void)timerCreate{
    if (self.sources.count == 1) {
        return;
    }
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

- (void)timerAction{
    if (self.index < self.sources.count - 1) {
        self.lastIndex = self.index;
        self.index += 1;
        [self selectAnimation];
        [self.scrollView setContentOffset:CGPointMake(self.width * self.index, 0) animated:YES];
    } else {
        self.lastIndex = self.index;
        self.index = 0;
        [self selectAnimation];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)timerClose{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

# pragma mark -- scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.scrollEnd = NO;
    [self timerClose];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollEnd == NO) {
        self.scrollEnd = YES;
        scrollView.scrollEnabled = NO;
        [self endScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) {
        if (self.scrollEnd == NO) {
            self.scrollEnd = YES;
            scrollView.scrollEnabled = NO;
            [self endScroll:scrollView];
        }
    }
}

- (void)endScroll:(UIScrollView *)scrollView{
    self.scrollView.scrollEnabled = YES;
    self.lastIndex = self.index;
    self.index = scrollView.contentOffset.x / self.width;
    [self timerCreate];
    [self selectAnimation];
}

# pragma mark -- dealloc
- (void)dealloc{
    [self timerClose];
}

@end
