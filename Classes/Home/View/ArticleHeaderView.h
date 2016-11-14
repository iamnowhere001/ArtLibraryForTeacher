//
//  XYDetailHeaderView.h
//  ArtLibrary
//
//  Created by JRuser on 16/5/25.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleHeaderViewModel;

@interface ArticleHeaderView : UIView

@property (nonatomic, copy) void (^SelectHeaderCompleteHandler)(NSInteger tag);

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) ArticleHeaderViewModel *viewModel;

@end
