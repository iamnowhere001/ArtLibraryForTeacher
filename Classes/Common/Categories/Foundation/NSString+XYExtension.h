//
//  NSString+XYExtension.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYExtension)

/**
 *  判断字符串是否为空
 */
+ (BOOL)isNull:(NSString *)str;


/**
 *  判断是否为手机号
 */
+ (BOOL)isMobileNumber:(NSString *)mobile;

/**
 *  根据一个字符串路径，获得这个路径的文件大小
 */
- (unsigned long long)fileSize;

//电话号码格式标准化（形式 字符串13798580599）
+(NSString*)getPhoneNumber:(NSString*)phone;

/**
 *  根据文字内容获取文字的高宽尺寸
 *  @param text    文字内容
 *  @param font    文字字体大小
 *  @param maxSize 文字内容最大宽度
 *  @return 文字尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  将image进行base64编码
 */
//+ (NSString *)imageBase64:(UIImage *)image;

/**
 *  返回单行文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize;

/**
 *  返回文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

/**
 *  根据时间戳字符串返回指定格式的时间字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)dateStringWithCreateTimeFromString:(NSString *)createTime;

/**
 *  根据时间戳字符串返回指定格式的年月日字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)nyrDateStringWithCreateTimeFromString:(NSString *)createTime;

/**
 *  根据指定格式的年月日字符串返回时间戳字符串
 *
 *  @param nyrDateString 年月日时间字符串
 *
 *  @return 返回时间字符串
 */
+ (NSString *)createDateStringWithNYRDateString:(NSString *)nyrDateString;

@end
