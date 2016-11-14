//
//  UIView+Screenshot.h
//  YZCommunity
//
//  Created by iamnowhere on 15/9/10.
//  Copyright (c) 2015年 压寨团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)


//保存到相册
+ (void)savedView:(UIView*)screenshotView;

//截取某一个区域
+ (UIImage *)rn_screenshot:(UIView*)screenshotView;

//截取全屏幕
- (UIImage *)rn_screenshot;


+ (UIImage *)rn_screenshotByLayer:(CALayer*)screenshotView;

#pragma mark - openGL 截屏
// only support iOS7 or Above
+ (UIImage *)snapshotScreenWithGL:(UIView *)view;

@end
