//
//  XYUserArticleCell.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleViewModel;

@interface UserArticleCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageView1;

@property (nonatomic, strong) ArticleViewModel *articleViewModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
