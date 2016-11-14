//
//  NSDate+XYEXtension.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/30.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "NSDate+XYEXtension.h"

@implementation NSDate (XYEXtension)

/**
 *  是否为今天
 */
- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfCmps.year == nowCmps.year
    && selfCmps.month == nowCmps.month
    && selfCmps.day == nowCmps.day;
    
    //    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //    fmt.dateFormat = @"yyyy-MM-dd";
    //
    //    NSString *selfYear = [fmt stringFromDate:self];
    //    NSString *nowYear = [fmt stringFromDate:[NSDate date]];
    //
    //    return [selfYear isEqualToString:nowYear];
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2015-04-01 10:10:10 -> 2015-04-10 00:00:00
    // 2015-03-31 23:50:40 -> 2015-03-31 00:00:00
    
    // 生成年月日的日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/**
 *  是否为明天
 */
- (BOOL)isTomorrow
{
    // 生成只有年月日的日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == nowYear;
    //    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //    fmt.dateFormat = @"yyyy";
    //
    //    NSString *selfYear = [fmt stringFromDate:self];
    //    NSString *nowYear = [fmt stringFromDate:[NSDate date]];
    //
    //    return [selfYear isEqualToString:nowYear];
}

+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -

+ (NSString*)getTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSDate *)makeDate:(NSString *)time{
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM.dd HH:mm"];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[df dateFromString:time];
    NSLog(@"%@",date);
    return date;
}

+ (NSString *)dateToString:(NSDate*)date{
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM.dd HH:mm"];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [df stringFromDate:date];
    return datestr;
}


+(NSDateFormatter *)dateFormatter2{
    
    static NSDateFormatter *dateFormatter2 = nil;
    if (dateFormatter2 == nil) {
        dateFormatter2 = [NSDateFormatter new];
        [dateFormatter2 setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd"]];
        [dateFormatter2 setLocale:[NSLocale currentLocale]];
    }
    return dateFormatter2;
}

-(NSString *)dateString{
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd"]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    return [dateFormatter stringFromDate:self];
}

-(NSString *)dateString2 {
    
    return [[NSDate dateFormatter2] stringFromDate:self];
}

-(NSString *)dateTimeString {
    
    static NSDateFormatter *dateTimeFormatter = nil;
    if (dateTimeFormatter == nil) {
        dateTimeFormatter = [NSDateFormatter new];
        [dateTimeFormatter setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd HH:mm"]];
        [dateTimeFormatter setLocale:[NSLocale currentLocale]];
    }
    return [dateTimeFormatter stringFromDate:self];
}

-(NSString *)dateTimeString2 {
    
    static NSDateFormatter *dateTimeFormatter2 = nil;
    if (dateTimeFormatter2 == nil) {
        dateTimeFormatter2 = [NSDateFormatter new];
        [dateTimeFormatter2 setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm"]];
        [dateTimeFormatter2 setLocale:[NSLocale currentLocale]];
    }
    return [dateTimeFormatter2 stringFromDate:self];
    
}
-(NSString *)shortDateString {
    static NSDateFormatter *shortDateFormatter = nil;
    if (shortDateFormatter == nil) {
        shortDateFormatter = [NSDateFormatter new];
        [shortDateFormatter setDateFormat:[NSString stringWithFormat:@"MM.dd"]];
        [shortDateFormatter setLocale:[NSLocale currentLocale]];
    }
    return [shortDateFormatter stringFromDate:self];
    
}
-(NSString *)shortDateTimeString {
    static NSDateFormatter *shortDatetimeFormatter = nil;
    if (shortDatetimeFormatter == nil) {
        shortDatetimeFormatter = [NSDateFormatter new];
        [shortDatetimeFormatter setDateFormat:[NSString stringWithFormat:@"M月d日 H:mm"]];
        [shortDatetimeFormatter setLocale:[NSLocale currentLocale]];
    }
    return [shortDatetimeFormatter stringFromDate:self];
    
}

-(NSString *)shortTimeString {
    static NSDateFormatter *shortTimeFormatter = nil;
    if (shortTimeFormatter == nil) {
        shortTimeFormatter = [NSDateFormatter new];
        [shortTimeFormatter setDateFormat:[NSString stringWithFormat:@"HH:mm"]];
        [shortTimeFormatter setLocale:[NSLocale currentLocale]];
    }
    return [shortTimeFormatter stringFromDate:self];
    
}

-(NSString *)longTimeString {
    static NSDateFormatter *longTimeFormatter = nil;
    if (longTimeFormatter == nil) {
        longTimeFormatter = [NSDateFormatter new];
        [longTimeFormatter setDateFormat:[NSString stringWithFormat:@"HH:mm:ss"]];
        [longTimeFormatter setLocale:[NSLocale currentLocale]];
    }
    return [longTimeFormatter stringFromDate:self];
    
}

-(long long)milseconds {
    NSTimeInterval timeInteval = [self timeIntervalSince1970]*1000;
    return [[NSNumber numberWithDouble:timeInteval] longLongValue];
}

+(NSDate *)dateFromYYYYMMDD:(NSString *)dateString {
    return [[self dateFormatter2] dateFromString:dateString];
}

+(NSDate *)dateWithYear:(int)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    [components setYear:year];
    return [calendar dateFromComponents:components];
}

#pragma mark -
+ (NSString *)getTimeDiffString:(NSDate *)temp {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlag = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *gap = [cal components:unitFlag fromDate:today toDate:temp options:0];//计算时间差
    
    if (ABS([gap day]) > 0)
    {
        return [NSString stringWithFormat:@"%@",[temp shortDateTimeString]];
        //        return [NSString stringWithFormat:@"%d天前", ABS([gap day])];
    }else if(ABS([gap hour]) > 0)
    {
        return [NSString stringWithFormat:@"%ld小时前", ABS([gap hour])];
    }else{
        if (ABS([gap minute])==0) {
            return [NSString stringWithFormat:@"刚刚"];
        }
        return [NSString stringWithFormat:@"%ld分钟前",  ABS([gap minute])];
    }
}

/*
 
 NSDate 日期
 NSDate存储的是时间信息，默认存储的是世界标准时间(UTC)，输出时需要根据时区转换为本地时间。中国大陆、香港、澳门、台湾…的时间增均与UTC时间差为+8，也就是UTC+8。
 NSDate* date = [[NSDate alloc]init];//初始化 得到当前的时间
 NSDate*date2= [NSDate dateWithTimeIntervalSinceNow:30];//得到一个时间，和当前比延迟30秒
 NSTimeInterval second = [date timeIntervalSince1970];//和当前时间对比 返回秒数
 NSDate* earlierDate = [date earlierDate:date2]; //比较两个时间 哪个更早
 
 NSDate* laterDate = [date laterDate:date2];//比较两个时间 哪个更晚
 
 */

/*
 NSDate *date = [NSDate date];
 NSString timeStamp = [date hyb_toTimeStamp];
 
 NSDate *date = [NSDate hyb_toDateWithTimeStamp:timeStamp];
 */

// 将NSDate对象转换成时间戳
- (NSString *)hyb_toTimeStamp {
    return [NSString stringWithFormat:@"%lf", [self timeIntervalSince1970]];
}

// 将时间戳转换成NSDate对象
+ (NSDate *)hyb_toDateWithTimeStamp:(NSString *)timeStamp {
//    NSString *arg = timeStamp;
    
//    if (![timeStamp isKindOfClass:[NSString class]]) {
//        arg = [NSString stringWithFormat:@"%@", timeStamp];
//    }
    
    NSTimeInterval time = [timeStamp doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:time];
}

//- (void)year {
//    
//    //下面是得到当前的年，月，日，时，分，秒。
//    NSDate *date = [NSDate date];
//    
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    
//    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    
//    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
//    int y = (int)[dd year];
//    int m = (int)[dd month];
//    int d = (int)[dd day];
//    int h = (int)[dd hour];
//    
//    NSLog(@"--y %d m %d d%d h%d",y,m,d,h);//--y 2015 m 2 d11 h10
//    
//}

- (void)test {
    
    //得到当前的UTC时间 和我们时间相差8个小时
    NSDate* date = [[NSDate alloc]init];
    NSLog(@"date:%@",date);
    //相隔的时间 单位：秒
    NSDate* tomorrow = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    NSDate* yesterday = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    NSLog(@"tomorrow:%@",tomorrow);
    NSLog(@"yesterday:%@",yesterday);
    
    //日期模板对象
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    //设置日期模板 日期输出的格式
    //hh小时:mm分钟:ss秒 yyyy年:MM月:dd日
    //hh12小时制 HH24小时制
    dateFormatter.dateFormat = @"MM月dd日yyyy年 hh:mm:ss";
    //通过日期模板对象，将指定的日期转换为：
    //处理好时区、显示格式的字符串
    NSString* dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"dateStr:%@",dateStr);
    //求差
    NSString* str = @"10";
    int s1 = [str intValue];//对象类型解封为基本类型
    NSString* str2 = @"5";
    int s2 = [str2 intValue];
    int i = s1-s2;
    NSLog(@"i:%d",i);//i:5
   
    
    //获得世界标准时间
    NSDate *today = [[NSDate alloc] init];
    NSLog(@"%@", today);
    //获得本地时间
    NSDateFormatter *dFormatter = [[NSDateFormatter alloc] init];
    dFormatter.dateFormat = @"yyyy年MM月dd日 hh:mm:ss";
    NSLog(@"%@", [dFormatter stringFromDate:today]);
    
    //获得当前时间的前后若干秒的时间值
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:-60];
    NSLog(@"%@", date1);
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:60];
    NSLog(@"%@", date2);
    
    //获得自1970年1月1日0时到现在已经过去的秒数
    NSTimeInterval seconds = [today timeIntervalSince1970];
    NSLog(@"%f", seconds);
    
    //获得指定时间距现在的秒数
    NSTimeInterval seconds1 = [date2 timeIntervalSinceNow];
    NSLog(@"%f", seconds1);
    
    //获得两个指定时间之间的秒数
    NSTimeInterval seconds2 = [date1 timeIntervalSinceDate:date2];
    NSLog(@"%f", seconds2);
    
    //比较两个时间，哪个更早
    NSDate* earlierDate = [date1 earlierDate:date2];
    NSLog(@"%@", earlierDate);
    //哪个更晚
    NSDate* laterDate = [date1 laterDate:date2];
    NSLog(@"%@", laterDate);
    //是否相同
    if ([date1 isEqualToDate:date2] == YES) {
        NSLog(@"是同一时间");
    }else {
        NSLog(@"不是同一时间");
    }
}



@end
