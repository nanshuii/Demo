//
//  LENTextTableViewCell.m
//  LedonDemo
//
//  Created by 林南水 on 2019/9/18.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENTextTableViewCell.h"

#define MaxLine 10
@interface LENTextTableViewCell()

@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation LENTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label.numberOfLines = MaxLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)configWithText:(NSString *)text{
    self.label.text = text;
}


@end
