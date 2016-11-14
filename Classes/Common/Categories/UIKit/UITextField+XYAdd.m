//
//  UITextField+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/1.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UITextField+XYAdd.h"

static NSString * const CYXPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (XYAdd)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    if (placeholderColor == nil) {
        // [self setValue:CYXGrayColor(255 * 0.65) forKeyPath:CYXPlaceholderColorKey];
    }else{
        // 保存之前的占位文字
        NSString *placeholder = self.placeholder;
        // 保证placeholder被创建
        self.placeholder = @" ";
        [self setValue:placeholderColor forUndefinedKey:CYXPlaceholderColorKey];
        // 恢复之前的占位文字
        self.placeholder = placeholder;
    }
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)placeholderColor{
    return [self valueForKeyPath:CYXPlaceholderColorKey];
}

/// 精准限制文本输入长度
+ (void)setTextLength:(int)length notify:(NSNotification *)notification {
    
    // 最大输入长度,中英文字符都按一个字符计算
    //static int kMaxLength = 150;
    int kMaxLength = length;
    UITextField *textField = (UITextField *)notification.object;
    NSString *toBeString = textField.text;
    
    // 获取键盘输入模式
    // NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    NSString *lang = [[[UIApplication sharedApplication]textInputMode]primaryLanguage];
    
    /*
     中文输入的时候,需要判断有没有markedText(简体拼音输入的时候,输入的拼音还没有选择对应的汉字时,输入框中的输入的拼音是选中的高亮状态,这串拼音就是markedText),对这种状态要做特殊处理,因为这个拼音字符串还没有转换成汉字字符串,不需要做处理,当用户选择了拼音对应的汉字时,就需要判断输入框的文字进行处理了
     */
    
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                // 截取子串
                textField.text = [toBeString substringToIndex:kMaxLength];
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多输入%d字符",length]];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
           // NSLog(@"======== %@",position);
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            // 截取子串
            textField.text = [toBeString substringToIndex:kMaxLength];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多输入%d字符",length]];
        }
    }
    
}


@end
