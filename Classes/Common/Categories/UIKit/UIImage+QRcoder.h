//
//  UIImage+QRcoder.h
//  YZCommunity
//
//  Created by iamnowhere on 15/9/10.
//  Copyright (c) 2015年 压寨团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRcoder)

#pragma mark - 二维码生成 字符串 CIFilter

/**********************  CIFilter自定义生成二维码  ************************/

//+ (UIImage*)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
//
//+ (CIImage *)createQRForString:(NSString *)qrString;
//
//+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
