//
//  CommonHelper.h
//
//  Created by iamnowhere on 15/3/9.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject


// app的版本号
+ (NSString *)appVersion;

// 系统版本号
+ (NSString *)OSVersion;

// 设备(iPhone)的固件版本
+ (NSString *)deviceInfo;

// 获取当前的window
+ (UIWindow *)getCurrentWindow;

// 第一次使用APP时保存记号
+ (void)saveAPPFirstUserd:(BOOL)isFirst;


// 判断APP是否是第一次使用
+ (BOOL)isAPPFirstUsered;


// 保存服务器时间和本地时间的差值
+ (void)saveDifferenceWithServerTime:(NSString *)serverTime;


// 获取服务器时间和本地时间的差值
+ (NSTimeInterval)differenceOfLocalAndServer;

// ----- 新添加

// 清除字符串首尾空格
+ (NSString *)clearSpaceOfString:(NSString *)str;

// 清除字符串所有空格
+ (NSString *)clearAllSpaceOfString:(NSString *)str;

/// 应用版本号
+ (NSString *)getAppVersion;

/// 评分页面
+ (void)goAppStore;

/// 根据文字内容文字大小 获取文字的尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

/// 获取字体名称
+ (void)getFontNames;

/// 存储路径 Documents/downloads
+ (NSString *)getDocumentPath;
/// 缓存中文件路径
+ (NSString *)getTempFolderPathWithBasepath:(NSString *)basepath;
/// 已缓存文件路径
+ (NSString *)getTargetPathWithBasepath:(NSString *)basepath subpath:(NSString *)subpath;

+ (BOOL)isExistFile:(NSString *)path;

/// 传入文件总大小和当前大小，得到文件的下载进度
+ (float)getProgress:(float)totalSize currentSize:(float)currentSize;

/// 将字节转化成M单位，不附带M
+ (NSString *)transformToM:(NSString *)size;
/// 将不M的字符串转化成字节
+ (float)transformToBytes:(NSString *)size;

//将文件大小转化成M单位或者B单位
+ (NSString *)getFileSizeString:(NSString *)size;
//经文件大小转化成不带单位ied数字
+ (float)getFileSizeNumber:(NSString *)size;

#pragma mark - 磁盘空间使用信息
//磁盘空闲空间
+ (uint64_t)getFreeDiskspace;
//磁盘总空间
+ (uint64_t)getTotalDiskspace;
//剩余空间:7.98G/总共:12.76GB
+ (NSString *)getDiskSpaceInfo;

#pragma mark - 字符串处理  类方法 不需要实例化
//视频分辨率
+(NSString*)getVpidString:(NSString*)vpid;
//课件发布时间
+(NSString*)getPublishTimeString:(NSString*)createtime;
//视频属性 年级
+(NSString*)getGradeString:(NSString*)grade;
//时间格式转换
+(NSString*)getTimeString:(double)time;

+(NSString*)getTimeString2:(double)totalSeconds;

@end
