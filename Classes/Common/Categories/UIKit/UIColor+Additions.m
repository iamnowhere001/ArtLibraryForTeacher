//
//  UIColor+Additions.m
//  yazhai
//
//  Created by iamnowhere on 15/8/31.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; // 0.5
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}

+ (UIColor *)randomBackgroundColor {
    
//    NSArray *headPicBackgroundImage = @[@"TableViewCell_Head_Pink",@"TableViewCell_Head_Yellow",@"TableViewCell_Head_Blue",@"TableViewCell_Head_Green",@"TableViewCell_Head_Purple"];
//    
//    return [UIImage imageNamed:[NSString stringWithFormat:@"%@",headPicBackgroundImage[arc4random() % 5]]];
    
    // ebd8cd e3b29d 9e7367 9fc9c2 d5f2e5 e7c5e0 566199
//    UIColor *color1 = [UIColor colorWithHex:@"#ebd8cd"];
    
    NSArray *backgroundColors = @[@"ebd8cd",@"e3b29d",@"9e7367",@"9fc9c2",@"d5f2e5",@"e7c5e0",@"566199",];
    
    return [UIColor colorWithHex:[NSString stringWithFormat:@"#%@",backgroundColors[arc4random() % 7]]];
    
}

#pragma mark —— 扩展十六进制颜色转换

+ (UIColor *)colorWithHex:(NSString *)color{
    return [self colorWithHex:color alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha{
    
    //!< 删除字符串中的空格
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //!< 字符串应该是6或8个字符
    if ([colorStr length] < 6){
        return [UIColor clearColor];
    }
    
    //!< 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"0X"]){
        colorStr = [colorStr substringFromIndex:2];
    }
    
    //!< 如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"#"]){
        colorStr = [colorStr substringFromIndex:1];
    }
    
    //!< 最后判断字符串是否为六位字符
    if ([colorStr length] != 6){
        return [UIColor clearColor];
    }
    
    /**
     *  分离成R、G、B子字符串
     */
    NSString *redStr = [colorStr substringWithRange:NSMakeRange(0, 2)];    //!< red字符串
    NSString *greenStr = [colorStr substringWithRange:NSMakeRange(2, 2)];    //!< green字符串
    NSString *blueStr = [colorStr substringWithRange:NSMakeRange(4, 2)];    //!< blue字符串
    
    /**
     *  将十六进制的R、G、B转换为Int
     */
    unsigned int redInt, greenInt, blueInt;
    [[NSScanner scannerWithString:redStr] scanHexInt:&redInt];
    [[NSScanner scannerWithString:greenStr] scanHexInt:&greenInt];
    [[NSScanner scannerWithString:blueStr] scanHexInt:&blueInt];
    
    //!< 返回颜色值
    //return [UIColor colorWithRed:(redInt / 255.0f) green:(greenInt / 255.0f) blue:(blueInt / 255.0f) alpha:alpha];
    return [UIColor colorWith256RedValue:redInt greenValue:greenInt blueValue:blueInt alpha:alpha];
}

#pragma mark —— 扩展RGB颜色转换

+ (UIColor *)colorWith256RedValue:(CGFloat)red greenValue:(CGFloat)green blueValue:(CGFloat)blue{
    return [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWith256RedValue:(CGFloat)red greenValue:(CGFloat)green blueValue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:alpha];
}

#pragma mark - 使用上面的十六进制方法
+ (UIColor *) getColor:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}


@end
