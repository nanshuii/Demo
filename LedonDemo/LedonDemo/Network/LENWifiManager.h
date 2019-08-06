//
//  LENWifiManager.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LENReachability.h"

NS_ASSUME_NONNULL_BEGIN

#define LENWifiManagerInstance [LENWifiManager sharedInstance]

/**
 * 本地wifi变化时代理
 */
@class LENWifiManager;
@protocol LENWifiManagerDelegate <NSObject>

@optional
- (void)manager:(LENWifiManager *)manager reachabilityChanged:(LENNetworkStatus)status;

@end

@interface LENWifiManager : NSObject

/**
 * wifi管理只保留一个wifi名和密码
 */
@property (strong, nonatomic) NSString *wifiName;       // wifi名

@property (strong, nonatomic) NSString *broadAddress;   // 广播地址

/**
 * 单例方法
 */
+ (instancetype)sharedInstance;

/**
 * 添加代理
 * 移除代理
 */
- (void)addDelegate:(id<LENWifiManagerDelegate>)delegate;

- (void)removeDelegate:(id<LENWifiManagerDelegate>)delegate;

/**
 * 网络可达性测试
 */
- (LENNetworkStatus)networkStatus;

-(BOOL)isWifiEnable;

/**
 * 获取路由器的广播地址
 */
- (NSString *)broadAddress;

/**
 * 获取当前wifi名
 */
- (NSString *)wifiName;


@end

NS_ASSUME_NONNULL_END
