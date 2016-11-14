//
//  XYButton.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/23.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "XYButton.h"

@implementation XYButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    // 若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.8 * widthDelta, -0.8 * heightDelta);
    
    // 经测试表明，该方法并没有扩大自定义按钮的frame值，只是单纯的将点击热区放大,不影响界面展示
    return CGRectContainsPoint(bounds, point);
}

@end
