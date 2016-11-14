//
//  SelectedCell.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/26.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/// 自绘分割线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:215/255.0 alpha:1.0].CGColor);
    
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
