//
//  LENDocumentReceiveCollectionViewCell.m
//  LedonDemo
//
//  Created by 林南水 on 2019/4/29.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENDocumentReceiveCollectionViewCell.h"

@implementation LENDocumentReceiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellWithName:(NSString *)name{
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.text = name;
}

@end
