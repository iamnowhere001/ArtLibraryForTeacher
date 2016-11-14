//
//  YMHDefine.h
//  ArtLibrary
//
//  Created by JRuser on 16/5/30.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#ifndef YMHDefine_h
#define YMHDefine_h

// iOS的字体
/**
 
 2016-06-06 16:02:49.625 ArtLibrary[3609:206605] Family name: Futura
 2016-06-06 16:02:49.625 ArtLibrary[3609:206605] Font name: Futura-CondensedMedium
 2016-06-06 16:02:49.625 ArtLibrary[3609:206605] Font name: Futura-CondensedExtraBold
 2016-06-06 16:02:49.625 ArtLibrary[3609:206605] Font name: Futura-Medium
 2016-06-06 16:02:49.625 ArtLibrary[3609:206605] Font name: Futura-MediumItalic
 
 */

// 方正兰亭中细
#define XYFont(_size_) [UIFont fontWithName:@"Futura-Medium" size:_size_]
//#define XYFont(_size_) [UIFont fontWithName:@"FZLanTingHei-L-GBK" size:_size_]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)  [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)      [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// RGB颜色
#define XYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define XYRandomColor  XYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 获得RGB颜色
#define RGBA(r, g, b, a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)       RGBA(r, g, b, 1.0f)

// 2016.5.23 花瓣 dedef2 223 223 226
// 界面背景色
#define BackgroundColor [UIColor colorWithRed:223/255.0 green:223/255.0 blue:226/255.0 alpha:1.0]
#define BackgroundColor2 [UIColor colorWithHex:@"#FFFFFF"]

// 文字颜色
#define TextColor [UIColor colorWithRed:110/255.0 green:110/255.0 blue:112/255.0 alpha:1.0]
#define TextColor2 [UIColor colorWithHex:@"#404040"]

// 默认红色
#define DefaultRedColor [UIColor colorWithRed:210/255.0 green:21/255.0 blue:24/255.0 alpha:1.0]
#define DefaultRedColor2 [UIColor colorWithRed:150/255.0 green:21/255.0 blue:24/255.0 alpha:0.95]

// 默认灰色
#define DefaultGrayColor [UIColor colorWithRed:113/255.0 green:112/255.0 blue:113/255.0 alpha:1.0]

// 选项卡颜色 选择蓝色
#define TabBarTitleColor [UIColor colorWithHex:@"#0098e1"]
#define TabBarTitleColor2 [UIColor colorWithHex:@"#717071"]

// 割线颜色
#define SeparatorLineColor [UIColor colorWithWhite:0.6 alpha:0.5]


//--------------- 间距 ----------------
// 返回
#define CGrectBackBtn CGRectMake(0, 0, 10, 18)

// 大图间距
#define BigCellLeftMargin 24

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 屏幕大小尺寸
#define MAIN_SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height  //!< 屏幕的Height
#define MAIN_SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width   //!< 屏幕的Width

//---------------- 默认图片 ----------

// 默认用户头像 区分各种尺寸
#define kPlaceholderUserImage  [UIImage imageNamed:@"icon-default"]
#define kPlaceholderUserImage_48  [UIImage imageNamed:@"icon-default"]
#define kPlaceholderUserImage_100  [UIImage imageNamed:@"icon-default"]

//--------------- 用户信息 ------------


//------------------------------------
// 是否显示欢迎页  版本更新 有新的引导页 可以添加新的标志位
#define RUNTIMES       @"runTimes"

///
#define AppId   @"1131518326"


//获取应用当前版本  //内部版本号
#define kCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//appStore id 字符串 URL  获取服务器版本号 优化
//ipad
#define IPAD_ID @"http://itunes.apple.com/lookup?id=763327410"
//iPhone
#define IPHONE_ID @"http://itunes.apple.com/lookup?id=598103109"


#endif /* YMHDefine_h */
