//
//  UIButton+XYAdd.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/3.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XYAdd)
+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed;

+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector;

/**
 *  创建一个图片的Button
 *
 *  @param Frame            Frame
 *  @param normalImage      正常的背景图
 *  @param highlightedImage 高亮的背景图
 *
 *  @return Button
 */
+ (UIButton*) createButtonWithFrame:(CGRect)frame normalBackgroundImage:(NSString *)normalBackgroundImage highlightedBackgroundImage:(NSString *)highlightedBackgroundImage;


/**
 *  创建一个只有文字标题的UIButton
 *
 *  @param frame    frame
 *  @param title    标题
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithFrame:(CGRect)frame title:(NSString *)title;


/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param frame                 Frame
 *  @param title                 标题
 *  @param normalBackgroundImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithFrame:(CGRect)frame title:(NSString *)title normalBackgroundImage:(NSString *)normalBackgroundImage;


/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param title                 标题
 *  @param normalBackgroundImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithTitle:(NSString *)title normalBackgroundImage:(NSString *)normalBackgroundImage;


/**
 *  创建一个文字+背景图片的UIButton
 *
 *  @param title       标题
 *  @param normalImage 背景图
 *
 *  @return UIButton
 */
+ (UIButton *) createButtonWithTitle:(NSString *)title normalImage:(UIImage *)normalImage;


@end
