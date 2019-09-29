//
//  LENTextTableEditViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/29.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENTextTableEditViewController.h"

@interface LENTextTableEditViewController ()

@end

@implementation LENTextTableEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.textView.text = self.text;
}

- (IBAction)done:(id)sender {
    [self.textView resignFirstResponder];
    NSDictionary *dict = @{
                           @"text": self.textView.text,
                           @"index": @(self.index),
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLENTextTableEditDoneNotification" object:dict];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
