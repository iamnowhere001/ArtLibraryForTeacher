//
//  UIView+XYAdd.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/20.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYAdd)

//frame accessors
/*!
 @brief 初始坐标
 */
@property (nonatomic, assign) CGPoint origin;
/*!
 @brief View大小
 */
@property (nonatomic, assign) CGSize size;
/*!
 @brief 顶部坐标值
 */
@property (nonatomic, assign) CGFloat top;
/*!
 @brief 左部坐标值
 */
@property (nonatomic, assign) CGFloat left;
/*!
 @brief 底部坐标值
 */
@property (nonatomic, assign) CGFloat bottom;
/*!
 @brief 右部坐标值
 */
@property (nonatomic, assign) CGFloat right;
/*!
 @brief 宽度值
 */
@property (nonatomic, assign) CGFloat width;
/*!
 @brief 高度值
 */
@property (nonatomic, assign) CGFloat height;
/*!
 @brief 中心点X坐标
 */
@property (nonatomic, assign) CGFloat x;
/*!
 @brief 中心点Y坐标
 */
@property (nonatomic, assign) CGFloat y;

//bounds accessors
/*!
 @brief 边界大小
 */
@property (nonatomic, assign) CGSize boundsSize;
/*!
 @brief 边界宽度
 */
@property (nonatomic, assign) CGFloat boundsWidth;
/*!
 @brief 边界高度
 */
@property (nonatomic, assign) CGFloat boundsHeight;

//content getters
/*!
 @brief 边界区域
 */
@property (nonatomic, readonly) CGRect contentBounds;
/*!
 @brief 边界中心点
 */
@property (nonatomic, readonly) CGPoint contentCenter;

/// xib获取视图
+ (id)loadFromNib;

/**
 *  查找视图的视图控制器。
 *
 *  @param view 需要查找的视图
 *
 *  @return 返回视图的控制器
 */
+(UIViewController *)getControllerFromView:(UIView *)view;


/**
 *  将UIView转换为UIImage
 *
 *  @param view 传入UIView对象
 *
 *  @return 返回UIImage对象
 */
+(UIImage *)getImageFromView:(UIView *)view;


/**
 *  截取指定View区域的屏幕
 *
 *  @param view 传入UIView对象
 *
 *  @return 返回UIImage对象
 */
+(UIImage *)screenCaptureFromView:(UIView *)view;


/**
 *  截取View区域的屏幕
 *
 *  @return 返回UIImage对象
 */
-(UIImage *)screenCapture;

/**
 *  截取指定View区域的屏幕
 *
 *  @param view 传入UIView对象
 *
 *  @return 返回UIImage对象
 */
+(UIImage *)screenCapture:(CGRect )rect  inView:(UIView *)view;

/**
 *  通过图片设置性状
 *
 *  @param maskImage 遮罩图片
 */
- (void)setShapeWithImage:(UIImage *)maskImage;

/**
 *  通过图片设置性状
 *
 *  @param maskImage 遮罩图片
 */
- (void)setShapeWithImage:(UIImage *)maskImage  withOriginalImage:(UIImage *)orignalImage;

/**
 *  通过PathRef设置性状
 *
 *  @param path PathRef
 */
- (void)setShapeWithPath:(CGPathRef)path;


@end
