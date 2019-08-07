//
//  LENCodeNetworkViewController.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENCodeNetworkViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel2;


@property (weak, nonatomic) IBOutlet UIImageView *codeImage;


@end

NS_ASSUME_NONNULL_END
