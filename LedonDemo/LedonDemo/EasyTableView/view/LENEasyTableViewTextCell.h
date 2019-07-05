//
//  LENEasyTableViewTextCell.h
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SwitchBlock)(BOOL value);

@interface LENEasyTableViewTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTitleLabelLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTitleLabelTop;

@property (weak, nonatomic) IBOutlet UILabel *leftSubTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSubTitleLabelTop;

@property (weak, nonatomic) IBOutlet UILabel *leftCenterTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCenterTitleLabelLeft;

@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTitleLabelRight;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewHeight;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSwitchRight;

@property (nonatomic, copy) SwitchBlock switchBlock;




- (void)configWithTextModel:(id)model;


@end

NS_ASSUME_NONNULL_END
