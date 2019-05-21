//
//  LENQRCodeViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/5/21.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENQRCodeViewController.h"
#import <CoreImage/CoreImage.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LENQRCodeScanViewController.h"

@interface LENQRCodeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation LENQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.title = @"二维码的生成和扫描";
    [self createQRCode];
}

# pragma mark -- 生成二维码
- (void)createQRCode{
    NSString *string = @"我是一个小天才";
    //创建名为"CIQRCodeGenerator"的CIFilter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //将filter所有属性设置为默认值
    [filter setDefaults];
    
    //将所需尽心转为UTF8的数据，并设置给filter
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //拿到二维码图片，此时的图片不是很清晰，需要二次加工
    CIImage *outPutImage = [filter outputImage];
    UIImage *code = [self getHDImgWithCIImage:outPutImage size:CGSizeMake(240, 240)];
    self.codeImage.image = code;
}

- (UIImage *)getHDImgWithCIImage:(CIImage *)img size:(CGSize)size {
    
    CGRect extent = CGRectIntegral(img.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //清晰的二维码图片
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    return outputImage;
}

# pragma mark -- 保存二维码
- (IBAction)save:(UIButton *)sender {
    UIImage *image = [self makeImageWithView:self.codeView withSize:CGSizeMake(300, 300)];
    if (image) {
        ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
        [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"Save video fail:%@",error);
            }else{
                NSLog(@"Save video succeed.");
            }
        }];
    } else {
        //
    }
}

- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    /**
     1.第一个参数表示区域大小
     2.第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES
     3.第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale
     */
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    //渲染view.layer
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存图片到照片库
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
}


# pragma mark -- 扫描二维码
- (IBAction)scan:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"扫一扫" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        LENQRCodeScanViewController *vc = [LENQRCodeScanViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *pickedImage = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    CIImage *detectImage = [CIImage imageWithData:UIImagePNGRepresentation(pickedImage)];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    CIQRCodeFeature *feature = (CIQRCodeFeature *)[detector featuresInImage:detectImage options:nil].firstObject;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (feature.messageString) {
            [self handleCodeString:feature.messageString];
        }
    }];
}

- (void)handleCodeString:(NSString *)codeString {
    NSLog(@"codeString = %@", codeString);
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
