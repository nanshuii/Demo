//
//  LENTextTableViewCell.h
//  LedonDemo
//
//  Created by 林南水 on 2019/9/18.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENTextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;


/**
 config with text

 @param text text description
 */
- (void)configWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
