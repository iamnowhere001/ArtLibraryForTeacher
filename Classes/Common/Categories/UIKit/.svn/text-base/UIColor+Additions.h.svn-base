//
//  UIColor+Additions.h
//  yazhai
//
//  Created by iamnowhere on 15/8/31.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

/**
 *  随机色
 */
+ (UIColor *)randomColor;

/**
 *  item背景色
 */
+ (UIColor *)randomBackgroundColor;

#pragma mark —— 扩展十六进制颜色转换

/**
 *  转换十六进制颜色、默认alpha值为1
 *
 *  @param color 十六进制颜色的字符串,支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(NSString *)hexColor;


/**
 *  转换十六进制颜色
 *
 *  @param color 十六进制颜色的字符串,支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha;


#pragma mark —— 扩展RGB颜色转换

/**
 *  转换RGB颜色，默认alpha值为1
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWith256RedValue:(CGFloat)red greenValue:(CGFloat)green blueValue:(CGFloat)blue;

/**
 *  转换RGB颜色
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *  @param alpha 透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWith256RedValue:(CGFloat)red greenValue:(CGFloat)green blueValue:(CGFloat)blue alpha:(CGFloat)alpha;


#pragma mark - 使用上面的十六进制方法
//16进制的颜色，转化成rgb表示 
//+ (UIColor *)getColor:(NSString *)hexColor;

@end
