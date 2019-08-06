//
//  LENNetworkUtil.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LENReachability.h"

NS_ASSUME_NONNULL_BEGIN

#define LENNetworkUtilInstance [LENNetworkUtil sharedInstance]

/**
 * 网络发生变化时回调
 */
@class LENNetworkUtil;

@protocol LENNetworkUtilDelegate <NSObject>

@required
- (void)networkUtil:(LENNetworkUtil *)util networkStatusChanged:(LENNetworkStatus)status;

@end

@interface LENNetworkUtil : NSObject

+ (instancetype)sharedInstance;

/**
 * 网络代理
 */
- (void)addDelegate:(id<LENNetworkUtilDelegate>)delegate;

- (void)removeDelegate:(id<LENNetworkUtilDelegate>)delegate;

/**
 * 网络状态
 */
- (BOOL)isNetworkEnable;

- (LENNetworkStatus)networkStatus;

@end

NS_ASSUME_NONNULL_END
