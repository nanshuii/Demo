//
//  LENNetworkUtil.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENNetworkUtil.h"

#define HostOfApple @"www.apple.com"

@interface LENNetworkUtilDelegateObject : NSObject

@property (weak, nonatomic) id<LENNetworkUtilDelegate> delegate;

- (instancetype)initWithDelegate:(id<LENNetworkUtilDelegate>)delegate;

@end

@implementation LENNetworkUtilDelegateObject

- (instancetype)initWithDelegate:(id<LENNetworkUtilDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

@end

@interface LENNetworkUtil ()
{
    NSMutableArray *delegateQueue;
    LENReachability * reachability;
}

@end

@implementation LENNetworkUtil

/**
 * 单例
 */
+ (instancetype)sharedInstance {
    static LENNetworkUtil *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [LENNetworkUtil new];
    });
    return singleton;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [delegateQueue removeAllObjects];
}

/**
 * 初始化
 */
- (instancetype)init {
    if (self = [super init]) {
        delegateQueue = [NSMutableArray array];
        reachability = [LENReachability reachabilityWithHostName:HostOfApple];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification object:reachability];
        [reachability startNotifier];
    }
    return self;
}

/**
 * 网络代理
 */
/**
 * 添加代理
 * 移除代理
 */
- (void)addDelegate:(id<LENNetworkUtilDelegate>)delegate {
    if (!delegate) return;     // 非法值
    
    for (LENNetworkUtilDelegateObject *delegateObject in delegateQueue)
        if (delegate == delegateObject.delegate) return;    // 已经添加过了
    
    LENNetworkUtilDelegateObject *delegateObject = [[LENNetworkUtilDelegateObject alloc] initWithDelegate:delegate];
    [delegateQueue addObject:delegateObject];
}
- (void)removeDelegate:(id<LENNetworkUtilDelegate>)delegate {
    if (!delegate) return;     // 非法值
    
    for (int i = (int)delegateQueue.count - 1; i >= 0; -- i) {
        LENNetworkUtilDelegateObject *delegateObject = [delegateQueue objectAtIndex:i];
        
        if (delegateObject.delegate == nil) [delegateQueue removeObject:delegateObject];
        
        if (!(delegate == delegateObject.delegate)) continue;  // 找到删除
        
        [delegateQueue removeObject:delegateObject]; break;
    }
}

/**
 * 网络切换通知
 */
- (void)reachabilityChanged:(NSNotification *)note {
    for (int i = (int)delegateQueue.count - 1; i >= 0; -- i) {
        LENNetworkUtilDelegateObject *delegateObject = [delegateQueue objectAtIndex:i];
        
        if (delegateObject.delegate == nil) {
            [delegateQueue removeObject:delegateObject];
        } else if ([delegateObject.delegate respondsToSelector:@selector(networkUtil:networkStatusChanged:)]) {
            [delegateObject.delegate networkUtil:self networkStatusChanged:[self networkStatus]];
        }
    }
}

/**
 * 网络状态
 */
- (BOOL)isNetworkEnable {
    return !(reachability.currentReachabilityStatus == LENNetworkStatusNotReachable);
}

- (LENNetworkStatus)networkStatus {
    return reachability.currentReachabilityStatus;
}


@end
