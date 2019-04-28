//
//  LENDocumentShareViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/4/28.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENDocumentShareViewController.h"

@interface LENDocumentShareViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation LENDocumentShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"文件分享";
    self.documentController = [UIDocumentInteractionController new];
    self.documentController.delegate = self;
}


- (void)setDocumentFilePath:(NSString *)filePath{
    // 设置filePath
    [self.documentController setURL:[NSURL fileURLWithPath:filePath]];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    // 设置快速预览的福页面
    return self;
}

# pragma mark -- 分享一个pdf
- (IBAction)sharePDF:(UIButton *)sender {
    // 显示菜单
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"pdf"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

# pragma mark -- 快速预览想要分享的pdf
- (IBAction)showPDF:(UIButton *)sender {
    // 快速预览
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"pdf"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentPreviewAnimated:YES];
}

# pragma mark -- 分享JPEG
- (IBAction)sharePNG:(UIButton *)sender {
    // 显示菜单
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"jpeg"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

# pragma mark -- 快速预览JPEG
- (IBAction)showPNG:(UIButton *)sender {
    // 快速预览
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"jpeg"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentPreviewAnimated:YES];
}

# pragma mark -- 分享H264
- (IBAction)shareH264:(UIButton *)sender {
    // 显示菜单
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest2" ofType:@"MOV"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

# pragma mark -- 快速预览h264
- (IBAction)showH264:(UIButton *)sender {
    // 快速预览
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest2" ofType:@"MOV"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentPreviewAnimated:YES];
}

# pragma mark -- 分享H265
- (IBAction)shareH265:(UIButton *)sender {
    // 显示菜单
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"MOV"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

# pragma mark -- 快速预览h265
- (IBAction)showH265:(UIButton *)sender {
    // 快速预览
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DocumentShareTest" ofType:@"MOV"];
    [self setDocumentFilePath:filePath];
    [self.documentController presentPreviewAnimated:YES];
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
