//
//  LENMQTTViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/2.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENMQTTViewController.h"
#import <MQTTClient/MQTTClient.h>

@interface LENMQTTViewController ()<MQTTSessionDelegate>

@property (nonatomic, strong) MQTTSession *mySession;

@end

@implementation LENMQTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = @"172.16.6.108";
    transport.port = 1883;
    
    self.mySession = [[MQTTSession alloc] init];
    self.mySession.transport = transport;
    self.mySession.delegate = self;
    [self.mySession setUserName:@"juyi"];
    [self.mySession setPassword:@"test"];
    
    [self.mySession connectAndWaitTimeout:5];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)setUpUI{
    self.title = @"MQTT";
   
}

- (IBAction)test:(id)sender {
    [self subscribeTopic:self.mySession topic:@"test"];
}

- (void)subscribeTopic:(MQTTSession *)session topic:(NSString *)topicUrl{
    [session subscribeToTopic:topicUrl atLevel:MQTTQosLevelAtMostOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
        if (error) {
            NSLog(@"连接失败 %@", error.localizedDescription);
        } else {
            NSLog(@"连接成功 %@", gQoss.description);
        }
    }];
}

- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
//    MQTTSessionEventConnected,
//    MQTTSessionEventConnectionRefused,
//    MQTTSessionEventConnectionClosed,
//    MQTTSessionEventConnectionError,
//    MQTTSessionEventProtocolError,
//    MQTTSessionEventConnectionClosedByBroker
    
    NSLog(@"event code = %li", eventCode);
}

@end
