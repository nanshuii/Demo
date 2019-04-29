//
//  LENDocumentReceiveCollectionViewCell.h
//  LedonDemo
//
//  Created by 林南水 on 2019/4/29.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENDocumentReceiveCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)cellWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
