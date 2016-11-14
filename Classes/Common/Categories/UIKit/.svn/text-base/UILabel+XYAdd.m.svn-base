//
//  UILabel+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/1.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UILabel+XYAdd.h"

@implementation UILabel (XYAdd)

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    
    /**
     
    - 作为一个四处使用的工具方法，前面的nil检查很有必要加。因为[[NSMutableAttributedString alloc] initWithString:text] 不接受 nil 参数，会直接 crash。
     
    - 生成的 paragraphStyle 除了配行距之外，还带上了 label 原有的一些常用属性。如果有其他需要，也可以加在这里。
     
    - 代码传参数进去的行距与设计图上量出来的行距是有区别的，代码上要少几个像素，而减少的量跟字体大小有关。
     
     font size  font.lineHeight（近似） 差值
     
     10             12              2
     
     11             13              2
     
     12             14              2
     
     13             15.5            2.5
     
     14             17              3
     
     15             18              3
     
     16             19              3
     
     17             20              3
     
     18             21.5            3.5
     
     19             23              4
     
     20             24              4
     
      - 为了计算效率高，我们就不在运行时现算这个差值了；直接把设计图上量出的行距减去上面这个表里几个像素的差值，作为参数传进去即可。例如：14 号字的 label，设计图上量出的行距是 5 个像素，那就减去 3 个像素，写[label setText:text lineSpacing:2.0f];。不要忘了计算行高的时候也要用同样的参数~
    
     */
    
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}

+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    
    // 自定义行距之后，计算文本高度的方法也得相应改。很简单，只要利用 sizeToFit、sizeThatFits 之类的方法就可以了。
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    
    return label.height;
}

- (CGFloat)paragraphLabelHeightWithText:(NSString *)text
                               maxWidth:(CGFloat)maxWidth
                            lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpacing];
    
    NSInteger leng = maxWidth;
    
    if (attStr.length < maxWidth)  leng = attStr.length;
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, leng)];
    
    self.attributedText = attStr;
    CGSize labelSize = [self sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
    
    return labelSize.height;
}

@end
