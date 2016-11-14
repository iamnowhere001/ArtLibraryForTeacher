//
//  UIImage+XYAdd.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYAdd)

/// 画圆图片裁剪
- (instancetype)circleImage;

+ (instancetype)circleImageNamed:(NSString *)name;

/// 图片灰度处理
//+ (UIImage*)getGrayImage:(UIImage*)sourceImage;

/// 创建一个圆形UIImage
+(UIImage *)createCircleImageWithColor:(UIColor *)color diameter:(int)diameter;

///
- (UIImage *)imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

/// 圆角
- (UIImage *)hyb_imageWithCornerRadius:(CGFloat)radius;

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)radius;

- (UIImage*)imageByRoundCornerRadius:(CGFloat)radius;

/// 裁剪图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/// 角度修正
- (UIImage *)fixOrientation;

@end
