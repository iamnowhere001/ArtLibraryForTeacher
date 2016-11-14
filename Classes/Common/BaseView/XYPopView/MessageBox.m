//
//  MessageBox.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/23.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "MessageBox.h"
#import "UIColor+Additions.h"

#define MAIN_SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height  //!< 屏幕的Height
#define MAIN_SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width   //!< 屏幕的Width

@implementation MessageBox {
    UIView *_DialogView;
    NSTimer *_timer;
}

#pragma mark - 公开方法

+(void)showDialog:(NSString*)message height:(CGFloat)height{
    [self showDialog:message autoDismiss:YES height:height];
}

+(void)showDialog:(NSString*)message autoDismiss:(BOOL)autoDismiss height:(CGFloat)height {
    // 通过类方法调用单列
    [[MessageBox shareDialog] showDialog:message autoDismiss:autoDismiss height:height];
}

+(void)dismissDialog {
    [[MessageBox shareDialog] dismissDialog];
}

#pragma mark - 

+ (MessageBox *)shareDialog {
    static MessageBox *dialogView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dialogView = [[MessageBox alloc] init];
    });
    return dialogView;
}

-(void)showDialog:(NSString*)message autoDismiss:(BOOL)autoDismiss height:(CGFloat)height {
    if(_DialogView){
        [_DialogView removeFromSuperview];
    }
    if (height == 0) {
        height = MAIN_SCREEN_HEIGHT - 49-20;
    }
    
    CGFloat edgeInsets = 8;
    CGFloat fontSize = 12;
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]}];
    
    // DialogView
    UIView *dialogView = [[UIView alloc] init];
    dialogView.layer.cornerRadius = 6;
    dialogView.layer.masksToBounds = YES;
    CGRect frame = dialogView.frame;
    frame.size = CGSizeMake(size.width + edgeInsets * 6, size.height + edgeInsets * 2);
    dialogView.frame = frame;
    dialogView.backgroundColor = [[UIColor colorWithHex:@"#2C2C2C"]colorWithAlphaComponent:0.8];
    
    dialogView.center = CGPointMake(MAIN_SCREEN_WIDTH * 0.5, height); //0.55 MAIN_SCREEN_HEIGHT - 49-20
    
    // 消息Label
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.text = message;
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    msgLabel.numberOfLines = 0;
    [msgLabel sizeToFit];
    msgLabel.center = CGPointMake(dialogView.frame.size.width/2, dialogView.frame.size.height/2);
    [dialogView addSubview:msgLabel];
    
    [[UIApplication sharedApplication].keyWindow addSubview:dialogView];
    
    _DialogView = dialogView;
    
   _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(dismiss:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

-(void)dismiss:(NSTimer *)timer {
    [timer invalidate];
    if(_DialogView){
        [_DialogView removeFromSuperview];
    }
}

- (void)dismissDialog {
    if(_DialogView){
        [_DialogView removeFromSuperview];
    }
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
