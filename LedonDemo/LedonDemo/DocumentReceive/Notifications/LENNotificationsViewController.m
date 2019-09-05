//
//  LENNotificationsViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/6/3.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENNotificationsViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface LENNotificationsViewController ()

@end

@implementation LENNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI{
    self.title = @"通知设定";
}

- (IBAction)add:(id)sender {
    [self addNotification];
}

- (IBAction)delete:(id)sender {
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"identifier-test"]];
}




# pragma mark -- 添加一个通知
- (void)addNotification{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"测试通知标题";
    content.subtitle = @"测试通知副标题";
    content.body = @"测试通知的具体内容";
    content.sound = [UNNotificationSound defaultSound];
    for (int i = 1; i < 8; i++) {
        NSString *identifier = @"identifier-test";
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.weekday = 1; // 周日
        components.hour = 1; // 01:00
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES]; // 设置是否重复
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        // 4、将请求加入通知中心
        [center addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"已成功加推送%@",notificationRequest.identifier);
            } else {
                NSLog(@"error = %@", error);
            }
        }];
    }
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
