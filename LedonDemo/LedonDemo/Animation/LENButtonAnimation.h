//
//  LENButtonAnimation.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/26.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelBlock)();
@interface LENButtonAnimation : UIView

@property (nonatomic, copy) CancelBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
