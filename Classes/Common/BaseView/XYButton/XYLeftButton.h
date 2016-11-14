//
//  XYLeftButton.h
//  ArtLibrary
//
//  Created by JRuser on 16/6/3.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLeftButton : UIButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

-(void)setTitleColor:(UIColor*)color select:(UIColor*)select;

@end
