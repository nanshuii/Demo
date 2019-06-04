//
//  LENCycleProgressViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/6/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENCycleProgressViewController.h"
#import "LENCycleProgressView.h"

@interface LENCycleProgressViewController ()

@property (nonatomic, strong) LENCycleProgressView *progressView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger allTime;

@property (nonatomic, assign) NSInteger currentTime;

@end

@implementation LENCycleProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.title = @"环形加载圈";
    self.allTime = 60;
    self.currentTime = 0;
    self.progressView = [[LENCycleProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.cycleView addSubview:self.progressView];
}

# pragma mark -- 开始
- (IBAction)start:(id)sender {
    [self timerCreate];
}

# pragma mark -- 暂停
- (IBAction)stop:(id)sender {
    [self timerStop];
}

# pragma mark -- 结束
- (IBAction)end:(id)sender {
    [self timerStop];
    self.currentTime = 0;
    [self progressAnimation];
}

# pragma mark -- timer
- (void)timerCreate{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

- (void)timerAction{
    self.currentTime += 1;
    NSLog(@"current time = %li", (long)self.currentTime);
    [self progressAnimation];
    if (self.currentTime >= self.allTime) {
        [self timerStop];
        self.currentTime = 0;
    }
}

- (void)timerStop{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)progressAnimation{
    NSString *timeString = [self timeStringSetting];
    self.timeLabel.text = timeString;
    CGFloat single = 10000 / self.allTime;
    CGFloat value = single * self.currentTime / 10000;
    NSLog(@"value = %f", value);
    [self.progressView circleAnimationWithValue:value];
}

- (NSString *)timeStringSetting{
    NSInteger time = self.allTime - self.currentTime;
    NSInteger minute = time / 60;
    NSString *minuteString = [NSString stringWithFormat:@"%li", (long)minute];
    if (minute < 10) {
        minuteString = [NSString stringWithFormat:@"0%@", minuteString];
    }
    NSInteger second = time % 60;
    NSString *secondString = [NSString stringWithFormat:@"%li", (long)second];
    if (second < 10) {
        secondString = [NSString stringWithFormat:@"0%@", secondString];
    }
    NSString *timeString = [NSString stringWithFormat:@"%@:%@", minuteString, secondString];
    return timeString;
}















/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
