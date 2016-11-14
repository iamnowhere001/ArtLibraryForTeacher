//
//  NSDictionary+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "NSDictionary+XYAdd.h"

@implementation NSDictionary (XYAdd)

+ (NSDictionary *)encodeUTF8WithDictionary:(NSDictionary *)dict {
    // 判断空值
    if (!dict) {
        return dict;
    }
    // 将字典转NSData
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    // 将NSData转字符串
    NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
    
    // 将加号编码替换为空格(真正的加号编码为%2B)
    dictStr = [dictStr stringByReplacingOccurrencesOfString:@"+"withString:@" "];
    //    dictStr = [dictStr stringByReplacingOccurrencesOfString:@"%22" withString:@"\\\""];
    
    // 将字符串转为UTF8编码
    NSString *utf8Str = [dictStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 过滤制表符、换行符
    utf8Str = [utf8Str stringByReplacingOccurrencesOfString:@"\r\n"withString:@""];
    utf8Str = [utf8Str stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    utf8Str = [utf8Str stringByReplacingOccurrencesOfString:@"\t"withString:@""];
    
    // 将字符串转NSData
    NSData *utf8Data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    // 将NSData转字典
    NSError * error = nil;
    NSDictionary *utf8Dict = [NSJSONSerialization JSONObjectWithData:utf8Data options:NSJSONReadingMutableLeaves error:&error];
    if (!error) {
        NSLog(@"-----error--%@------",error);
    }
    // 返回UTF8编码的字典
    return utf8Dict;
}

+(void)printUTF8WithDict:(NSDictionary *)dict {
    NSString *tempStr1 = [[dict description] stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *strUTF8 = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    NSString *strUTF8 = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    NSLog(@"DictUTF8:%@",strUTF8);
}



- (NSDictionary *)encodeUTF8WithDictionary {
    // 将字典转NSData
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    // 将NSData转字符串
    NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
    // 将字符串转为UTF8编码
    NSString *utf8Str = [dictStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 将字符串转NSData
    NSData *utf8Data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    // 将NSData转字典
    NSDictionary *utf8Dict = [NSJSONSerialization JSONObjectWithData:utf8Data options:NSJSONReadingMutableContainers error:nil];
    // 返回UTF8编码的字典
    return utf8Dict;
}


-(void)printUTF8 {
    
    NSString *tempStr1 = [[self description] stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *strUTF8 = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    NSString *strUTF8 = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    NSLog(@"DictUTF8:%@",strUTF8);
}

@end
