//
//  XYLeftButton.m
//  ArtLibrary
//
//  Created by JRuser on 16/6/3.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "XYLeftButton.h"

#define itemTitleFont [UIFont boldSystemFontOfSize:17] //标题字体大小

#define itemTitleWidth 10
#define itemTitleHeight 5

#define itemImageWidth  18
#define itemImageHeight 5

#define marginWithLableAndImageView 2


@implementation XYLeftButton

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

//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self initial];
//    }
//    return self;
//}

-(void)initial
{
    //    UIColor* color = [UIColor colorWithRed:115.0/255 green:115.0/255 blue:115.0/255 alpha:1];
    //    UIColor* hlColor = [UIColor colorWithRed:1.0/255 green:161.0/255 blue:1 alpha:1];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageView.contentMode =  UIViewContentModeLeft;
    //[self setTitleColor:color select:hlColor];
}



- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    
    self = [super init];
    if (self) {
        [self initial];
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    return self;
    
}

-(void)setTitleColor:(UIColor*)color select:(UIColor*)select{
    
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

-(CGFloat)leftAndRightMargin:(CGRect)contentRect
{
    return fabs((contentRect.size.width -itemTitleWidth-itemImageWidth-marginWithLableAndImageView )/2);
    
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸

// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 18;
    CGFloat titleY = 0;
    CGFloat titleWidth = contentRect.size.width - 18;
    CGFloat titleHeight = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width - 40;
    CGFloat imageHeight = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}



@end
