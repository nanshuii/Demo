//
//  LENMQTTServer.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/2.
//  Copyright © 2019 ledon. All rights reserved.
//

#ifndef Service_CocoaAsyncSocket
#define Service_CocoaAsyncSocket

#endif /** Service_CocoaAsyncSocket **/

#ifndef Service_Protocol
#define Service_Protocol



static NSString *const AddressOfMQTTServer      = @"172.16.6.108";  // MQTT服务器地址
static UInt16   const PortOfMQTTServer          = 1883;  // MQTT服务器端口
static UInt16   const PortOfMQTTServerWithSSL          = 1883;  // MQTT服务器端口


static UInt16 const DefaultDeviceAuthor         = 0x0000; // 设备默认授权码


#pragma mark - 项目相关主题
//topic
static NSString *const HeadTopic           = @"xxxx/xx/01/xx/";




#endif /* Service_Protocol */


#ifndef Service_Main_Safe
#define Service_Main_Safe

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* Service_Main_Safe */


