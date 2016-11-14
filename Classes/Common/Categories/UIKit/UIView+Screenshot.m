//
//  UIView+Screenshot.m
//  YZCommunity
//
//  Created by iamnowhere on 15/9/10.
//  Copyright (c) 2015年 压寨团队. All rights reserved.
//

#import "UIView+Screenshot.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Screenshot)

//
+ (void)savedView:(UIView*)screenshotView{
    
    UIGraphicsBeginImageContext(screenshotView.bounds.size);
    
    [screenshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //把截图保存到相册里
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

+ (UIImage *)rn_screenshot:(UIView*)screenshotView{
    
    UIGraphicsBeginImageContext(screenshotView.bounds.size);
    
    [screenshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //把截图保存到相册里
     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage *)rn_screenshot {
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //把截图保存到相册里
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}


+ (UIImage *)rn_screenshotByLayer:(CALayer*)screenshotView{
    
    UIGraphicsBeginImageContext(screenshotView.bounds.size);
    
    [screenshotView renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //把截图保存到相册里
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}


+(UIImage *)screenShot
{
    UIView * view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
 
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
   
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}


// only support iOS7 or Above
+ (UIImage *)snapshotScreenWithGL:(UIView* )view
{
    UIView *videoView = view;
    CGSize size = videoView.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = CGRectMake(videoView.frame.origin.x, videoView.frame.origin.y, videoView.bounds.size.width, videoView.bounds.size.height);
    
    // Use this method to render a snapshot of the view hierarchy into the current context. Returns NO if the snapshot is missing image data, YES if the snapshot is complete. Calling this method from layoutSubviews while the current transaction is committing will capture what is currently displayed regardless if afterUpdates is YES.
    [view drawViewHierarchyInRect:rec afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // 写入图像到相册
    
    return image;
}


@end
