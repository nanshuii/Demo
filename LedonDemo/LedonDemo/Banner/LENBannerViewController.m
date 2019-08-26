//
//  LENBannerViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/23.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENBannerViewController.h"
#import "LENBanner.h"

@interface LENBannerViewController ()

@end

@implementation LENBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [UIImage imageNamed:@"zhu"];
    NSMutableArray *images = [NSMutableArray arrayWithObjects:image, image, image, image, image, nil];
    LENBanner *bannerView = [[LENBanner alloc] initWithFrame:CGRectMake(20, 100, 300, 200) images:images];
    [bannerView setTapBannerIndex:^(NSInteger index) {
        NSLog(@"tap index = %li", index);
    }];
    [self.view addSubview:bannerView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
