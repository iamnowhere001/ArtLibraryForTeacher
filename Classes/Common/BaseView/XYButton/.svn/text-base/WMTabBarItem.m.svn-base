//
//  WMTabBarItem.m
//  EduClass
//
//  Created by anyv on 14-10-16.
//  Copyright (c) 2014年 anyv. All rights reserved.
//

#import "WMTabBarItem.h"
#import "UIColor+Additions.h"

#define itemTitleFont [UIFont boldSystemFontOfSize:10] //标题字体大小
#define itemTitleHeight 10

#define itemImageWidth  27
#define itemImageHeight 27

#define marginWithLableAndImageView 2

@implementation WMTabBarItem

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initial];
    }
    return self;
}

-(void)initial
{
    UIColor* color = [UIColor colorWithHex:@"#5d5d5d"]; //[UIColor colorWithRed:115.0/255 green:115.0/255 blue:115.0/255 alpha:1];
    UIColor* hlColor = [UIColor colorWithHex:@"#000000"]; //[UIColor colorWithRed:1.0/255 green:161.0/255 blue:1 alpha:1];

    self.titleLabel.font = itemTitleFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode =  UIViewContentModeScaleAspectFit;
    [self setTitleColor:color select:hlColor];
}

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if (self) {
        [self initial];
    
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:selectedImage forState:UIControlStateSelected];
        [self setImage:selectedImage forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)setTitleColor:(UIColor *)color select:(UIColor *)select
{
    if (color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateHighlighted];
    }
    
    if (select) {
        [self setTitleColor:select forState:UIControlStateSelected];
    }
}

-(CGFloat)topAndBottomMargin:(CGRect)contentRect
{
    return fabs((contentRect.size.height - itemTitleHeight - itemImageHeight - marginWithLableAndImageView ) / 2);
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = itemTitleHeight;
    CGFloat titleY = contentRect.size.height - titleHeight - [self topAndBottomMargin:contentRect];
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (contentRect.size.width - itemImageWidth ) / 2;
    CGFloat imageY = [self topAndBottomMargin:contentRect];
    CGFloat imageWidth = itemImageWidth;
    CGFloat imageHeight = itemImageHeight;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"draw rect--");
    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //设置背景色
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGRect arect = CGRectMake(0, 0, 20, 20);
//    CGContextFillEllipseInRect(context, arect);

}
*/


@end
