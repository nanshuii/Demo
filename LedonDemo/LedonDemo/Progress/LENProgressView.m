//
//  LENProgressView.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENProgressView.h"

@interface LENProgressView()

@property (nonatomic, strong) CALayer *bgLayer;

@end


@implementation LENProgressView

- (instancetype)initWithFrame:(CGRect)frame type:(LENProgressType)type colors:(NSArray *)colors{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    [self bgLayer];
}

# pragma mark -- 背景
- (void)setBgShow:(BOOL)bgShow{
    if (_bgShow != bgShow) {
        _bgShow = bgShow;
    }
}

- (void)bgLayerCreate{
    
}


@end
