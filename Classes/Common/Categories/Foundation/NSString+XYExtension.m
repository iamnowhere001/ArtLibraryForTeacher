//
//  NSString+XYExtension.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "NSString+XYExtension.h"

@implementation NSString (XYExtension)

+ (BOOL)isNull:(NSString *)str {
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
//    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
//        return YES;
//    }
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isMobileNumber:(NSString *)mobile {
    // 空值判断
    if ([NSString isNull:mobile]) {
        return NO;
    }
    // 判断是否为1开头的11为数字
    NSString *moblie = @"^1\\d{10}$";
    //正则判断
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moblie];
    return [regextestMobile evaluateWithObject:mobile];
}

- (unsigned long long)fileSize{
    
    // 获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 标记是否为文件夹
    BOOL isDirectory = NO;
    
    // 首先判断路径是否存在
    BOOL exisit = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 路径不存在是马上返回
    if (!exisit) return 0;
    
    // 如果是文件夹
    if (isDirectory) {
        // 文件总大小
        unsigned long long fileSize = 0;
        // 遍历所有文件
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 拼接完整路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件夹下所有文件
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return fileSize;
    }
    
    // 如果是文件
    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    
}

//电话号码格式标准化（字符串13798580599）
+(NSString*)getPhoneNumber:(NSString*)phone{
    
    NSString *str = phone;
    
    if ([str containsString:@" "]) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([str containsString:@"("]) {
        str =  [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    if ([str containsString:@")"]) {
        str =  [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    if ([str containsString:@"-"]) {
        str =  [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([str containsString:@"+86"]) {
        str = [str stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    return str;
}


+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


//+ (NSString *)imageBase64:(UIImage *)image
//{
//    image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
//    NSData *data = nil;//[NSData data];
//    if (UIImagePNGRepresentation(image)) {
//        //返回为png图像。
//        data = UIImagePNGRepresentation(image);
//    }else {
//        //返回为JPEG图像。
//        data = UIImageJPEGRepresentation(image, 0.5);
//    }
//    NSString *base64ImageStr = [data base64EncodedStringWithOptions:0];
//    base64ImageStr = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                   (CFStringRef)base64ImageStr,
//                                                                                   NULL,
//                                                                                   CFSTR("="),
//                                                                                   kCFStringEncodingUTF8);
//    return base64ImageStr;
//}

/**
 *  调整发图片大小
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

/**
 *  返回单行文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize
{
    return [self titleSizeWithfontSize:fontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

/**
 *  返回文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;
{
    CGSize size =   [self boundingRectWithSize:maxSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : XYFont(fontSize)}
                                       context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

+ (NSString *)dateStringWithCreateTimeFromString:(NSString *)createTime
{
    NSString *dateString = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *create_date = [NSDate dateWithTimeIntervalSince1970:[createTime longLongValue]];
    
//    if ([create_date rx_isToday])
//    {
//        formatter.dateFormat = @"HH:mm";
//        dateString = [formatter stringFromDate:create_date];
//    } else {
        formatter.dateFormat = @"YYYY-MM-dd";
        dateString = [formatter stringFromDate:create_date];
//    }
    
    return dateString;
}


/**
 *  根据时间戳字符串返回指定格式的年月日字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)nyrDateStringWithCreateTimeFromString:(NSString *)createTime
{
    if (createTime.length) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSDate *create_date = [NSDate dateWithTimeIntervalSince1970:[createTime longLongValue]];
        formatter.dateFormat = @"YYYY年MM月dd日";
        NSString *dateString = [formatter stringFromDate:create_date];
        
        return dateString;
    }
    return @"";
}

/**
 *  根据指定格式的年月日字符串返回时间戳字符串
 *
 *  @param nyrDateString 年月日时间字符串
 *
 *  @return 返回时间字符串
 */
+ (NSString *)createDateStringWithNYRDateString:(NSString *)nyrDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:nyrDateString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp);
    return timeSp;
}

@end
