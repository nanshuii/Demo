//
//  LENEasyTableViewTextModel.m
//  LedonDemo
//
//  Created by 林南水 on 2019/7/4.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENEasyTableViewTextModel.h"

@interface LENEasyTableViewTextModel()

@end

@implementation LENEasyTableViewTextModel

# pragma mark -- 初始化LENEasyTableViewTextModel
- (instancetype)initWithCenterTitle:(NSString *)centerTitle{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:nil leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                         rightTitle:(NSString *)rightTitle{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:rightTitle leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                         rightTitle:(NSString *)rightTitle
                          leftImage:(UIImage *)leftImage{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:rightTitle leftImageShow:YES leftImage:leftImage rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                         rightTitle:(NSString *)rightTitle
                          leftImage:(UIImage *)leftImage
                         rightImage:(UIImage *)rightImage{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:rightTitle leftImageShow:YES leftImage:leftImage rightImageShow:YES rightImage:rightImage switchShow:NO switchValue:NO];
}

- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                        switchValue:(BOOL)switchValue{
     return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:nil leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:YES switchValue:switchValue];
}

- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                          leftImage:(UIImage *)leftImage
                        switchValue:(BOOL)switchValue{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:nil leftSubTitle:nil leftCenterTitle:centerTitle rightTitle:nil leftImageShow:YES leftImage:leftImage rightImageShow:NO rightImage:nil switchShow:YES switchValue:switchValue];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:nil leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle
                       rightTitle:(NSString *)rightTitle{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:rightTitle leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle
                       rightTitle:(NSString *)rightTitle
                        leftImage:(UIImage *)leftImage{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:rightTitle leftImageShow:YES leftImage:leftImage rightImageShow:NO rightImage:nil switchShow:NO switchValue:NO];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle
                       rightTitle:(NSString *)rightTitle
                        leftImage:(UIImage *)leftImage
                       rightImage:(UIImage *)rightImage{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:rightTitle leftImageShow:YES leftImage:leftImage rightImageShow:YES rightImage:rightImage switchShow:NO switchValue:NO];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle
                      switchValue:(BOOL)switchValue{
     return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:nil leftImageShow:NO leftImage:nil rightImageShow:NO rightImage:nil switchShow:YES switchValue:switchValue];
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle
                         subTitle:(NSString *)subTitle
                        leftImage:(UIImage *)leftImage
                      switchValue:(BOOL)switchValue{
    return [self initWithType:LENEasyTableViewCellTypeText leftTitle:leftTitle leftSubTitle:subTitle leftCenterTitle:nil rightTitle:nil leftImageShow:YES leftImage:leftImage rightImageShow:NO rightImage:nil switchShow:YES switchValue:switchValue];
}


- (instancetype)initWithType:(LENEasyTableViewCellType)type
                   leftTitle:(nullable NSString *)leftTitle
                leftSubTitle:(nullable NSString *)leftSubTitle
             leftCenterTitle:(nullable NSString *)leftCenterTitle
                  rightTitle:(nullable NSString *)rightTitle
               leftImageShow:(BOOL)leftImageShow
                   leftImage:(nullable UIImage *)leftImage
              rightImageShow:(BOOL)rightImageShow
                  rightImage:(nullable UIImage *)rightImage
                  switchShow:(BOOL)switchShow
                 switchValue:(BOOL)switchValue{
    if (self = [super init]) {
        self.type = type;
        self.leftTitle = leftTitle;
        self.leftSubTitle = leftSubTitle;
        self.rightTitle = rightTitle;
        self.leftCenterTitle = leftCenterTitle;
        self.leftImageShow = leftImageShow;
        self.leftImage = leftImage;
        self.rightImageShow = rightImageShow;
        self.rightImage = rightImage;
        self.switchShow = switchShow;
        self.switchValue = switchValue;
    }
    return self;
}

@end
