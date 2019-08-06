//
//  LENMQTTClientModel.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/2.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LENMQTTServer.h"
#import "LENMQTTPackage.h"
#import <MQTTClient/MQTTClient.h>

NS_ASSUME_NONNULL_BEGIN

#define LENMQTTClientModelStance [LENMQTTClientModel sharedInstance]

@protocol LENMQTTClientModelDelegate <NSObject>

@optional
- (void)MQTTClientModel_handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained;
@end

@interface LENMQTTClientModel : NSObject

@property (nonatomic, assign) BOOL isDiscontent;

@property (nonatomic, weak) id <LENMQTTClientModelDelegate> delegate;

@property (nonatomic, strong, nullable) MQTTSessionManager *mySessionManager;

+ (instancetype)sharedInstance;


- (void)bindWithUserName:(NSString *)username password:(NSString *)password cliendId:(NSString *)cliendId isSSL:(BOOL)isSSL;

- (void)disconnect;

- (void)reConnect;

/**
 订阅主题
 
 @param topic 主题
 */
typedef void (^SubscribeTopicHandler)(NSString *topic, BOOL success);

- (void)subscribeTopic:(NSString *)topic;

/**
 取消订阅
 
 @param topic 主题
 */
- (void)unsubscribeTopic:(NSString *)topic;

/**
 发布消息
 */
- (void)sendDataToTopic:(NSString *)topic dict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
