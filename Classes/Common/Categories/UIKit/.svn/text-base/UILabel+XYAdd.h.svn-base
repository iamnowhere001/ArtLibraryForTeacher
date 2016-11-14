//
//  UILabel+XYAdd.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/1.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

/**
 *  以前总是很烦设计师非要说，让『把行距调大一点点』，因为在 iOS 这个对文字处理各种不友好的系统里，改行距并不像改字号那么简单，只调『一点点』也得多写好几行。
    不过自从我写了下面这些工具方法，调行距也就回归到它本来应该的样子：一行代码的事。
 */

#import <UIKit/UIKit.h>

@interface UILabel (XYAdd)

/// 设置行距
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

/// 计算行高
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

/// 返回高度
- (CGFloat)paragraphLabelHeightWithText:(NSString *)text
                               maxWidth:(CGFloat)maxWidth
                            lineSpacing:(CGFloat)lineSpacing;

@end
