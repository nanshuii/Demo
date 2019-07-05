//
//  LENEasyTableViewTextModel.h
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENEasyTableViewModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LENEasyTableViewTextModel : LENEasyTableViewModel

@property (nonatomic, copy) NSString *leftTitle; // 左边的主title

@property (nonatomic, copy) NSString *leftSubTitle; // 左边的副title

@property (nonatomic, copy) NSString *leftCenterTitle; // 左边的居中title

@property (nonatomic, copy) NSString *rightTitle; // 右边的title

@property (nonatomic, assign) BOOL leftImageShow;

@property (nonatomic, assign) BOOL rightImageShow;

@property (nonatomic, strong) UIImage *leftImage;

@property (nonatomic, strong) UIImage *rightImage;

@property (nonatomic, assign) BOOL switchShow;

@property (nonatomic, assign) BOOL switchValue;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle switchValue:(BOOL)switchValue;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle leftImage:(UIImage *)leftImage switchValue:(BOOL)switchValue;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle switchValue:(BOOL)switchValue;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle leftImage:(UIImage *)leftImage switchValue:(BOOL)switchValue;





@end

NS_ASSUME_NONNULL_END
