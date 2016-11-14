//
//  NSDate+XYEXtension.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/30.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XYEXtension)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为明天
 */
- (BOOL)isTomorrow;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;


+ (NSString *)getCurrentTime;

//当前时间 标准格式
+ (NSString*)getTime;

+ (NSDate *)makeDate:(NSString *)time;

+ (NSString *)dateToString:(NSDate*)date;

-(NSString *)dateString;
-(NSString *)dateString2;
-(NSString *)dateTimeString;
-(NSString *)dateTimeString2;
-(NSString *)shortDateString;
-(NSString *)shortTimeString;
-(NSString *)longTimeString;
-(NSString *)shortDateTimeString;
-(long long)milseconds;

+(NSDate *)dateFromYYYYMMDD:(NSString *)dateString;
+(NSDate *)dateWithYear:(int)year;

+ (NSString *)getTimeDiffString:(NSDate *)temp;

@end
