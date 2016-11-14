//
//  UIButton+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/3.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UIButton+XYAdd.h"

@implementation UIButton (XYAdd)
//title and image
+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *newPressedImage = [UIImage imageNamed: imagePressed];
    [button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//only title
+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 *  创建一个图片的Button
 *
 *  @param Frame            Frame
 *  @param normalImage      正常的背景图
 *  @param highlightedImage 高亮的背景图
 *
 *  @return Button
 */
+ (UIButton*) createButtonWithFrame:(CGRect)frame normalBackgroundImage:(NSString *)normalBackgroundImage highlightedBackgroundImage:(NSString *)highlightedBackgroundImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置Frame
    [button setFrame:frame];
    // 设置NormalImage
    UIImage *normalImage = [UIImage imageNamed: normalBackgroundImage];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    // 设置HighlightedImage
    UIImage *highlightedImage = [UIImage imageNamed: highlightedBackgroundImage];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

/**
 *  创建一个只有文字标题的UIButton
 *
 *  @param frame    frame
 *  @param title    标题
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithFrame:(CGRect)frame title:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // 设置Frame
    [button setFrame:frame];
    // 设置Title
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
}


/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param frame                 Frame
 *  @param title                 标题
 *  @param normalBackgroundImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithFrame:(CGRect)frame title:(NSString *)title normalBackgroundImage:(NSString *)normalBackgroundImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // 设置Frame
    [button setFrame:frame];
    // 设置Title
    [button setTitle:title forState:UIControlStateNormal];
    // 设置NormalImage
    UIImage *normalImage = [UIImage imageNamed: normalBackgroundImage];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    return button;
}


/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param title                 标题
 *  @param normalBackgroundImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithTitle:(NSString *)title normalBackgroundImage:(NSString *)normalBackgroundImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // 清除背景色
    button.backgroundColor = [UIColor clearColor];
    // 设置Title
    [button setTitle:title forState:UIControlStateNormal];
    // 设置NormalImage
    UIImage *normalImage = [UIImage imageNamed: normalBackgroundImage];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    return button;
}

/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param title       标题
 *  @param normalImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithTitle:(NSString *)title normalImage:(UIImage *)normalImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 清除背景色
    button.backgroundColor = [UIColor clearColor];
    // 设置Title
    [button setTitle:title forState:UIControlStateNormal];
    // 设置NormalImage
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    return button;
}

@end
