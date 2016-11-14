//
//  ZFAvatarBrowser.m
//  loseweight
//
//  Created by zhangzifei on 16/1/27.
//  Copyright © 2016年 com.gohoc. All rights reserved.
//

#import "ZFAvatarBrowser.h"
#import "XYActionSheet.h"

static CGRect oldframe;
@interface ZFAvatarBrowser ()
@end

@implementation ZFAvatarBrowser

+ (void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    UILongPressGestureRecognizer *longPressTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    [backgroundView addGestureRecognizer:longPressTap];
    // 重置
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kActionSheetDismiss"];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    tap2.numberOfTapsRequired = 2;
    [backgroundView addGestureRecognizer: tap2];
    [tap requireGestureRecognizerToFail:tap2];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)hideImage:(UITapGestureRecognizer *)tap{
    
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

+ (void)saveImage:(UILongPressGestureRecognizer *)tap {
    
    BOOL isDismiss = [[NSUserDefaults standardUserDefaults]boolForKey:@"kActionSheetDismiss"];
    if (!isDismiss) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kActionSheetDismiss"];

    if (tap.state == UIGestureRecognizerStateBegan) {
        
        UIView *backgroundView = tap.view;
        UIImageView *imageView = [tap.view subviews][0];
        
        XYActionSheet *sheet = [[XYActionSheet alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) titleArr:@[@"保存到相册"]];
       
        sheet.Click = ^(NSInteger clickIndex) {
            switch (clickIndex) {
                case 0:{
                    UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
                    [SVProgressHUD showSuccessWithStatus:@"图片已保存"]; // 不严谨 若磁盘空间不足可能失败
                }
                    break;
                default:
                    break;
            }
        };
        
        [backgroundView addSubview:sheet];
    }
}

@end
