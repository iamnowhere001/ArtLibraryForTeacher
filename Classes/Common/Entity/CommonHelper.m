//
//  CommonHelper.m
//
//  Created by iamnowhere on 15/3/9.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import "CommonHelper.h"

#import "sys/utsname.h"

@implementation CommonHelper

- (void)text {
    //设备相关信息的获取
    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"设备名称：%@", strName);
    
    // a UUID that may be used to uniquely identify the device, same across apps from a single vendor.
    NSUUID *strId = [[UIDevice currentDevice] identifierForVendor];
    NSLog(@"设备唯一标识：%@", strId);
    
    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"系统名称：%@", strSysName);
    
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"系统版本号：%@", strSysVersion);
    
    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"设备模式：%@", strModel);
    
    NSString *strLocModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"本地设备模式：%@", strLocModel);
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSLog(@"版本号：%f\n", version);
    
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    // CFShow(dicInfo);
    
    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
    NSLog(@"App应用名称：%@", strAppName);
    
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"App应用版本：%@", strAppVersion);
    
    NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleVersion"];
    NSLog(@"App应用Build版本：%@", strAppBuild);
}


#pragma mark -

// app的版本号
+ (NSString *)appVersion
{
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = dict[@"CFBundleShortVersionString"];  // 注意区分CFBundleShortVersionString和CFBundleVersion
    
    if(appVersion.length == 0){
        return @"";
    }
    
    return appVersion;
}

// 系统版本号
+ (NSString *)OSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

// 设备(iPhone)的固件版本
+ (NSString *)deviceInfo
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if (platform.length==0){
        return @"";
    }
    return platform;
}

// 获取当前的window
+ (UIWindow *)getCurrentWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(!window){
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    
    return window;
}


// 第一次使用APP时保存记号
+ (void)saveAPPFirstUserd:(BOOL)isFirst
{
    [[NSUserDefaults standardUserDefaults] setBool:isFirst forKey:@"IsFirstUserAPP"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 判断APP是否是第一次使用
+ (BOOL)isAPPFirstUsered
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"IsFirstUserAPP"];
}

// 保存服务器时间和本地时间的差值
+ (void)saveDifferenceWithServerTime:(NSString *)serverTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *serverDate = [dateFormat dateFromString:serverTime];
    NSTimeInterval server = [serverDate timeIntervalSince1970];
    
    NSDate *localDate = [NSDate date];
    NSTimeInterval local = [localDate timeIntervalSince1970];
    
    [[NSUserDefaults standardUserDefaults] setInteger:server-local forKey:@"TimeDifferenceOfLocalAndServer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


// 获取服务器时间和本地时间的差值
+ (NSTimeInterval)differenceOfLocalAndServer
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"TimeDifferenceOfLocalAndServer"];
}


// 清除字符串首尾空格
+ (NSString *)clearSpaceOfString:(NSString *)str
{
    if(str.length == 0){
        return @"";
    }
    
    NSString *string = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return string;
}

// 清除字符串所有空格
+ (NSString *)clearAllSpaceOfString:(NSString *)str
{
    if(str.length == 0){
        return @"";
    }
    NSString *string = [str stringByReplacingOccurrencesOfString:@"" withString:@" "];
    
    return string;
}

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (void)goAppStore {
    // 评分页面
    NSString *trackViewUrl = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1131518326";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


// 获取字体名称
+ (void)getFontNames {
    
    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    NSLog(@"[familyNames count]===%ld",(unsigned long)[familyNames count]);
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        
        for(indFont=0; indFont<[fontNames count]; ++indFont){
            NSLog(@"Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
}


+ (NSString *)transformToM:(NSString *)size {
    float oldSize = [size floatValue];
    float newSize = oldSize/1024.0f;
    newSize = newSize/1024.0f;
    return [NSString stringWithFormat:@"%f",newSize];//M
}

+ (float)transformToBytes:(NSString *)size {
    float totalSize=[size floatValue];
    return totalSize*1024*1024;//B
}

#pragma mark -

+ (NSString *)getFileSizeString:(NSString *)size {
    if([size floatValue]>=1024*1024){
        return [NSString stringWithFormat:@"%1.1fM",[size floatValue]/1024/1024];
    }else if([size floatValue]>=1024&&[size floatValue]<1024*1024){
        return [NSString stringWithFormat:@"%1.0fK",[size floatValue]/1024];
    }else{
        return [NSString stringWithFormat:@"%1.0fB",[size floatValue]];
    }
}

+ (float)getFileSizeNumber:(NSString *)size
{
    NSInteger indexM=[size rangeOfString:@"M"].location;
    NSInteger indexK=[size rangeOfString:@"K"].location;
    NSInteger indexB=[size rangeOfString:@"B"].location;
    
    if(indexM<1000){//是M单位的字符串
        return [[size substringToIndex:indexM] floatValue]*1024*1024;
    }else if(indexK<1000){
        return [[size substringToIndex:indexK] floatValue]*1024;
    }else if(indexB<1000){
        return [[size substringToIndex:indexB] floatValue];
    }else{//没有任何单位的数字字符串
        return [size floatValue];
    }
}

#pragma mark - 存储路径 Documents/downloads

+ (NSString *)getDocumentPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)getTargetPathWithBasepath:(NSString *)basepath subpath:(NSString *)subpath{
    
    NSString *pathstr = [[[self getDocumentPath]stringByAppendingPathComponent:basepath]stringByAppendingPathComponent:subpath];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSError *error;
    if(![fileManager fileExistsAtPath:pathstr]){
        [fileManager createDirectoryAtPath:pathstr withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error){
            NSLog(@"%@",[error description]);
        }
    }
    return pathstr;
}

+ (NSString *)getTempFolderPathWithBasepath:(NSString *)basepath{
    
    NSString *pathstr = [[[self getDocumentPath]stringByAppendingPathComponent:basepath]stringByAppendingPathComponent:@"temp"];//Documents/downloads/temp
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSError *error;
    if(![fileManager fileExistsAtPath:pathstr]){
        [fileManager createDirectoryAtPath:pathstr withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error){
            NSLog(@"%@",[error description]);
        }
    }
    return pathstr;
}

#pragma mark -
+ (BOOL)isExistFile:(NSString *)path{
    
    NSFileManager *fileManager =[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

#pragma mark - 进度 下载进度 进度条/百分数/圆环 展现形式的选择

+ (float)getProgress:(float)totalSize currentSize:(float)currentSize{
    return currentSize/totalSize;
}

#pragma mark - 磁盘可用空间

+ (uint64_t)getFreeDiskspace {
    
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
        
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalFreeSpace;
}

#pragma mark - 磁盘总空间
+ (uint64_t)getTotalDiskspace {
    
    uint64_t totalSpace = 0.0f;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalSpace;
}

#pragma mark - 磁盘空间大小信息  7.98G/12.76G
+ (NSString *)getDiskSpaceInfo{
    
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary){
        //获取系统磁盘的大小
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        //获取系统磁盘可以空间的大小
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
    }else{
        //
    }
    
    NSString *infostr = [NSString stringWithFormat:@"剩余空间:%.2fG/总共%.2fG", ((totalFreeSpace/1024.0f)/1024.0f)/1024.0f, ((totalSpace/1024.0f)/1024.0f)/1024.0f];//2进制
    
    return infostr;
}

#pragma mark - 字符串处理  类方法 不需要初始化(实例化)
+ (NSString*)getVpidString:(NSString*)vpid{
    
    NSString* message = nil;
    if ([vpid isEqualToString:@"1"]) {
        message = NSLocalizedString(@"Ultra clear", nil);
    }else if ([vpid isEqualToString:@"2"]){
        message = NSLocalizedString(@"HD", nil);
    }else if ([vpid isEqualToString:@"3"]){
        message = NSLocalizedString(@"Standard definition", nil);
    }else{
        message = NSLocalizedString(@"fluency", nil);
    }
    return message;
}

+ (NSString*)getPublishTimeString:(NSString*)createtime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:createtime];
    int time = [date timeIntervalSinceNow];
    time = -time;
    // NSCalendar  零点的问题  //2015-01-31 14:32:26
    NSString* publishTime = nil;
    if (time<-300) {
        publishTime = [createtime substringToIndex:10];
    }else if (time <= 60) {
        publishTime = NSLocalizedString(@"just now", nil);
    }else if (time<=60*60){
        publishTime = [NSString stringWithFormat:@"%d%@",time/60,NSLocalizedString(@"minute ago", nil)];
    }else if (time<24*60*60){//有问题  日历 今天
        publishTime = [NSString stringWithFormat:@"%d%@",time/3600,NSLocalizedString(@"hour ago", nil)];
    }else if (time<4*24*60*60){
        publishTime = [NSString stringWithFormat:@"%d%@",time/3600/24,NSLocalizedString(@"day ago", nil)];
    }else{
        publishTime = [createtime substringToIndex:10];
    }
    return publishTime;
}
//小学 初中 高中
+ (NSString*)getGradeString:(NSString*)grade{
    NSString* message = nil;
    if (grade.intValue<20) {
        message =NSLocalizedString(@"primary school", nil);
    }else if (grade.intValue<30){
        message =NSLocalizedString(@"junior high school", nil);
    }else{
        message =NSLocalizedString(@"senior high school", nil);
    }
    return message;
}

+ (NSString*)getTimeString:(double)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval  timeZoneOffset= [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    date = [date dateByAddingTimeInterval:timeZoneOffset];
    
    if (time/3600 >= 1)
        [formatter setDateFormat:@"HH:mm:ss"];
    else
        [formatter setDateFormat:@"mm:ss"];
    
    return [formatter stringFromDate:date];
}

+ (NSString*)getTimeString2:(double)totalSeconds
{
    int hour = 0, minute = 0, second = 0;
    
    hour = totalSeconds / 3600;
    minute = (totalSeconds - hour * 3600) / 60;
    second = totalSeconds - hour * 3600 - minute *  60;
    
    NSString* formatter = hour < 10 ? @"0%d" : @"%d";
    NSString* strHour = [NSString stringWithFormat:formatter, hour];
    
    formatter = minute < 10 ? @"0%d" : @"%d";
    NSString* strMinute = [NSString stringWithFormat:formatter, minute];
    
    formatter = second < 10 ? @"0%d" : @"%d";
    NSString* strSecond = [NSString stringWithFormat:formatter, second];
    
    return [NSString stringWithFormat:@"%@:%@:%@", strHour, strMinute, strSecond];
}



@end
