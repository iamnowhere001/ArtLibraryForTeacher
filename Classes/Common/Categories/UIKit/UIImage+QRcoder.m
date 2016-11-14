//
//  UIImage+QRcoder.m
//  YZCommunity
//
//  Created by iamnowhere on 15/9/10.
//  Copyright (c) 2015年 压寨团队. All rights reserved.
//

#import "UIImage+QRcoder.h"

@implementation UIImage (QRcoder)

/**********************  CIFilter自定义生成二维码  ************************/

//LZ用了下微信和新浪微博的扫一扫,发现那个扫描框是忽悠人的,也就是你没拿它对准二维码,只要二维码进入手机摄像头范围,就能够解码成功

#pragma mark - QRCodeGenerator

//1.首先是二维码的生成，使用CIFilter很简单，直接传入生成二维码的字符串即可
//使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
//+ (CIImage *)createQRForString:(NSString *)qrString {
//    
//    // Need to convert the string to a UTF-8 encoded NSData object
//    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    // Create the filter
//    // 创建filter
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    
//    // Set the message content and error-correction level
//    // 设置内容和纠错级别
//    [qrFilter setValue:stringData forKey:@"inputMessage"];
//    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];//M 设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
//    
//    // Send the image back
//    // 返回CIImage
//    return qrFilter.outputImage;
//}

#pragma mark - InterpolatedUIImage
//2.因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage
//+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
//    
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    
//    // create a bitmap image that we'll draw into a bitmap context at the desired size;
//    // 创建bitmap
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);//8,0
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    
//    // Create an image with the contents of our bitmap
//    // 保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    // Cleanup
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    
//    return [UIImage imageWithCGImage:scaledImage];
//}



#pragma mark - imageToTransparent

//3.因为生成的二维码是黑白的，所以还要对二维码进行颜色填充，并转换为透明背景，使用遍历图片像素来更改图片颜色，因为使用的是CGContext，速度非常快
//void ProviderReleaseData (void *info, const void *data, size_t size){
//    
//    free((void*)data);
//}
//
//+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
//    
//    const int imageWidth = image.size.width;
//    const int imageHeight = image.size.height;
//    size_t      bytesPerRow = imageWidth * 4;
//    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
//    // create context
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
//                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
//    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
//    
//    // traverse pixe
//    // 遍历像素
//    int pixelNum = imageWidth * imageHeight;
//    uint32_t* pCurPtr = rgbImageBuf;
//    for (int i = 0; i < pixelNum; i++, pCurPtr++){
//        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
//            // change color
//            // 将白色变成透明
//            // 改成下面的代码，会将图片转成想要的颜色
//            uint8_t* ptr = (uint8_t*)pCurPtr;
//            ptr[3] = red; //0~255
//            ptr[2] = green;
//            ptr[1] = blue;
//        }else{
//            uint8_t* ptr = (uint8_t*)pCurPtr;
//            ptr[0] = 0;
//        }
//    }
//    
//    // context to image
//    // 输出图片
//    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
//    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
//                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
//                                        NULL, true, kCGRenderingIntentDefault);
//    CGDataProviderRelease(dataProvider);
//    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
//    
//    // release
//    // 清理空间
//    CGImageRelease(imageRef);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    
//    return resultUIImage;
//}

/**********************  CIFilter自定义生成二维码  ************************/

@end
