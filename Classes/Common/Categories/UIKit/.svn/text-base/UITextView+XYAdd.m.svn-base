//
//  UITextView+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/1.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UITextView+XYAdd.h"

@implementation UITextView (XYAdd)

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}


+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    // 因为默认的 UITextView 有一点 inset，所以计算文本高度的方法要跟 UILabel 分开。
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    textView.font = [UIFont systemFontOfSize:fontSize];
    [textView setText:text lineSpacing:lineSpacing];
    [textView sizeToFit];
    
    return textView.height;
}

/// 精准限制文本输入长度
+ (void)setTextLength:(int)length notify:(NSNotification *)notification {
    
    // 最大输入长度,中英文字符都按一个字符计算
    //static int kMaxLength = 150;
    int kMaxLength = length;
    UITextView *textView = (UITextView *)notification.object;
    NSString *toBeString = textView.text;
    
    // 获取键盘输入模式
    // NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    NSString *lang = [[[UIApplication sharedApplication]textInputMode]primaryLanguage];
    
    /*
     中文输入的时候,需要判断有没有markedText(简体拼音输入的时候,输入的拼音还没有选择对应的汉字时,输入框中的输入的拼音是选中的高亮状态,这串拼音就是markedText),对这种状态要做特殊处理,因为这个拼音字符串还没有转换成汉字字符串,不需要做处理,当用户选择了拼音对应的汉字时,就需要判断输入框的文字进行处理了
     */
    
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                // 截取子串
                textView.text = [toBeString substringToIndex:kMaxLength];
                [SVProgressHUD showInfoWithStatus:@"最多输入150字符"];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
           // NSLog(@"======== %@",position);
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            // 截取子串
            textView.text = [toBeString substringToIndex:kMaxLength];
            [SVProgressHUD showInfoWithStatus:@"最多输入150字符"];
        }
    }

}

@end
