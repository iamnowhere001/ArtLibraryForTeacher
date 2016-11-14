//
//  UIView+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/20.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UIView+XYAdd.h"

@implementation UIView (XYAdd)

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.center.x;
}

- (void)setX:(CGFloat)x
{
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)y
{
    return self.center.y;
}

- (void)setY:(CGFloat)y
{
    self.center = CGPointMake(self.center.x, y);
}

//bounds accessors

- (CGSize)boundsSize
{
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size
{
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth
{
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight
{
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

//content getters

- (CGRect)contentBounds
{
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter
{
    return CGPointMake(self.boundsWidth/2.0f, self.boundsHeight/2.0f);
}

/// 
+ (id)loadFromNib {
    
    NSString *xibName = NSStringFromClass([self class]);
    UIView *xibView  = [[[NSBundle mainBundle]loadNibNamed:xibName owner:nil options:nil] firstObject];
    return xibView;
}

/**
 *  查找视图的视图控制器。
 */
+(UIViewController *)getControllerFromView:(UIView *)view{
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    }
    // 如果没有找到则返回nil
    return nil;
}


/**
 *  将UIView转换为UIImage
 */
+(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 *  截取指定View区域的屏幕
 */
+(UIImage *)screenCaptureFromView:(UIView *)view
{
    // 获取当前Controller的View
    UIView *ctrlView = [self getControllerFromView:view].view;
    
    // 截取屏幕图片
    UIGraphicsBeginImageContextWithOptions(ctrlView.bounds.size, NO, [UIScreen mainScreen].scale);
    [ctrlView drawViewHierarchyInRect:ctrlView.bounds afterScreenUpdates:YES];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(screenImage, nil, nil, nil); // 写入图像到相册
    
    // 获取view在ctrlView中的坐标
    CGRect viewRect = [ctrlView convertRect:view.frame fromView:view.superview];
    
    // 计算剪切Rect
    CGRect cutRect = CGRectMake(viewRect.origin.x * screenImage.scale,
                                viewRect.origin.y * screenImage.scale,
                                viewRect.size.width * screenImage.scale,
                                viewRect.size.height * screenImage.scale);
    
    // 剪切图片
    CGImageRef imageRef = CGImageCreateWithImageInRect(screenImage.CGImage, cutRect);
    UIImage *cutImage = [UIImage imageWithCGImage:imageRef scale:screenImage.scale orientation:screenImage.imageOrientation];
    CGImageRelease(imageRef);
    
    return cutImage;
}


/**
 *  截取指定View区域的屏幕
 */
+(UIImage *)screenCapture:(CGRect )rect  inView:(UIView *)view
{
    // 截取屏幕图片
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(screenImage, nil, nil, nil); // 写入图像到相册
    
    // 获取view在ctrlView中的坐标
    CGRect viewRect = rect;
    // 计算剪切Rect
    CGRect cutRect = CGRectMake(viewRect.origin.x * screenImage.scale,
                                viewRect.origin.y * screenImage.scale,
                                viewRect.size.width * screenImage.scale,
                                viewRect.size.height * screenImage.scale);
    
    // 剪切图片
    CGImageRef imageRef = CGImageCreateWithImageInRect(screenImage.CGImage, cutRect);
    UIImage *cutImage = [UIImage imageWithCGImage:imageRef scale:screenImage.scale orientation:screenImage.imageOrientation];
    CGImageRelease(imageRef);
    
    return cutImage;
}


/**
 *  截取View区域的屏幕
 */
-(UIImage *)screenCapture
{
    return [UIView screenCaptureFromView:self];
}


/**
 *  通过图片设置性状
 */
- (void)setShapeWithImage:(UIImage *)maskImage {
    CAShapeLayer *maskLayer  = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.contentsScale = [UIScreen mainScreen].scale;
    maskLayer.contents = (id)maskImage.CGImage;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

/**
 *  通过图片设置性状
 */
- (void)setShapeWithImage:(UIImage *)maskImage  withOriginalImage:(UIImage *)orignalImage {
    CAShapeLayer *maskLayer  = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.contentsScale = [UIScreen mainScreen].scale;
    maskLayer.contents = (id)orignalImage.CGImage;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

/**
 *  通过PathRef设置性状
 */
- (void)setShapeWithPath:(CGPathRef)path {
    CAShapeLayer *maskLayer  = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.contentsScale = [UIScreen mainScreen].scale;
    maskLayer.path = path;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}


@end
