//
//  LENBanner.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/23.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapBannerIndex)(NSInteger index);
@interface LENBanner : UIView

@property (nonatomic, copy) TapBannerIndex tapBannerIndex;

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images;

@end

NS_ASSUME_NONNULL_END
