//
//  LENInstanceMQTTClientModel.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LENMQTTClientModel.h"

NS_ASSUME_NONNULL_BEGIN

#define LENMQTTInstanceClientModelStance [LENMQTTInstanceClient sharedInstance]

@interface LENInstanceMQTTClientModel : NSObject

+ (instancetype)sharedInstance;


#pragma mark - 登录 解绑
- (void)bindWithUserName:(NSString *)username password:(NSString *)password epoch:(long long)epoch;

- (void)disconnect;

- (void)reConnect;

#pragma mark - 订阅命令
/**
 订阅设备inf、res、sys三种topic
 */
- (void)subscribeTopic:(NSString *)topic;

#pragma mark - 取消订阅
/**
 取消订阅设备inf、res、sys三种topic
 */
- (void)unsubscribeTopic:(NSString *)topic;

#pragma mark - set命令 采暖炉
/**
 开关
 */
- (void)switchWithDevice;

@end

NS_ASSUME_NONNULL_END
