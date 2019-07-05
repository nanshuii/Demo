//
//  LENEasyTableViewTextCell.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENEasyTableViewTextCell.h"
#import "LENEasyTableViewTextModel.h"

@implementation LENEasyTableViewTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithTextModel:(id)model{
    LENEasyTableViewTextModel *textModel = (LENEasyTableViewTextModel *)model;
    // left image
    if (textModel.leftImageShow) {
        self.leftImageView.hidden = NO;
        self.leftImageViewWidth.constant = LENEasyTVTextLeftImageWidth;
        self.leftImageViewHeight.constant = LENEasyTVTextLeftImageHeight;
        self.leftImageViewLeft.constant = LENEasyTVTextLeftImageLeading;
        self.leftTitleLabelLeft.constant = LENEasyTVTextLeftImageLeading + LENEasyTVTextLeftImageWidth + LENEasyTVTextLeftTitleDistance;
        self.leftCenterTitleLabelLeft.constant = LENEasyTVTextLeftImageLeading + LENEasyTVTextLeftImageWidth + LENEasyTVTextLeftCenterTitleDistance;
        self.leftImageView.image = textModel.leftImage;
    } else {
        self.leftImageView.hidden = YES;
        self.leftTitleLabelLeft.constant = LENEasyTVTextLeftTitleLeading;
        self.leftCenterTitleLabelLeft.constant = LENEasyTVTextLeftCenterTitleLeading;
    }
    
    // left label
    if (textModel.leftTitle && textModel.leftSubTitle) {
        self.leftTitleLabel.hidden = NO;
        self.leftSubTitleLabel.hidden = NO;
        self.leftTitleLabel.text = textModel.leftTitle;
        self.leftTitleLabel.font = LENEasyTVTextLeftTitleFont;
        self.leftTitleLabel.textColor = LENEasyTVTextLeftTitleColor;
        self.leftTitleLabelTop.constant = LENEasyTVTextLeftTitleTop;
        self.leftSubTitleLabel.text = textModel.leftSubTitle;
        self.leftSubTitleLabel.font = LENEasyTVTextLeftSubTitleFont;
        self.leftSubTitleLabel.textColor = LENEasyTVTextLeftSubTitleColor;
        self.leftSubTitleLabelTop.constant = LENEasyTVTextLeftSubTitleTop;
    } else {
        self.leftTitleLabel.hidden = YES;
        self.leftSubTitleLabel.hidden = YES;
    }
    
    if (textModel.leftCenterTitle) {
        self.leftCenterTitleLabel.hidden = NO;
        self.leftCenterTitleLabel.text = textModel.leftCenterTitle;
        self.leftCenterTitleLabel.font = LENEasyTVTextLeftCenterTitleFont;
        self.leftCenterTitleLabel.textColor = LENEasyTVTextLeftCenterTitleColor;
    } else {
        self.leftCenterTitleLabel.hidden = YES;
    }
    
    // right label
    if (textModel.rightTitle) {
        self.rightTitleLabel.hidden = NO;
        self.rightTitleLabel.text = textModel.rightTitle;
        self.rightTitleLabel.font = LENEasyTVTextRightTitleFont;
        self.rightTitleLabel.textColor = LENEasyTVTextRightTitleColor;
    } else {
        self.rightTitleLabel.hidden = YES;
    }
    
    // right image
    if (textModel.rightImageShow) {
        self.rightImageView.hidden = NO;
        self.rightImageViewWidth.constant = LENEasyTVTextRightImageWidth;
        self.rightImageViewHeight.constant = LENEasyTVTextRightImageHeight;
        self.rightImageViewRight.constant = LENEasyTVTextRightImageTrailing;
        self.rightTitleLabelRight.constant = LENEasyTVTextRightImageTrailing + LENEasyTVTextRightImageWidth + LENEasyTVTextRightTitleDistance;
        self.rightImageView.image = textModel.rightImage;
    } else {
        self.rightImageView.hidden = YES;
        self.rightTitleLabelRight.constant = LENEasyTVTextRightTitleTrailing;
    }
    
    // right switch
    if (textModel.switchShow) {
        self.rightSwitch.hidden = NO;
        self.rightSwitchRight.constant = LENEasyTVTextSwitchTrailing;
        [self.rightSwitch setOn:textModel.switchValue];
    } else {
        self.rightSwitch.hidden = YES;
    }
}

- (IBAction)switchValueChange:(UISwitch *)sender {
    if (_switchBlock) {
        _switchBlock(sender.on);
    }
}















@end
