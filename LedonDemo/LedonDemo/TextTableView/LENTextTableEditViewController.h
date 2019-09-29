//
//  LENTextTableEditViewController.h
//  LedonDemo
//
//  Created by 林南水 on 2019/9/29.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENTextTableEditViewController : UIViewController

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

NS_ASSUME_NONNULL_END
