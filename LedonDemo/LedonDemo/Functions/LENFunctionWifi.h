//
//  LENFunctionWifi.h
//  LedonDemo
//
//  Created by 林南水 on 2019/7/24.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENFunctionWifi : NSObject

/**
 获取当前wifi的ssid

 @return 没获取到返回error
 */
+ (NSString *)currentWifiSSID;

/**
 获取当前wifi的ip

 @return 没获取到返回error
 */
+ (NSString *)currentWifiIp;

@end

NS_ASSUME_NONNULL_END
