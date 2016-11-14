//
//  XYEditArticleViewController.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger,ArticleType) {
    ArticleTypeEdit = 0, // 编辑作品
    ArticleTypeAdd  = 1  //添加作品
};

@class WorksModel;

@interface ArticleEditViewController : BaseViewController

@property (nonatomic, strong) WorksModel *model;
@property (nonatomic, strong) UIImage *image;     // 编辑
@property (nonatomic, assign) ArticleType type;
@property (nonatomic, strong) NSString *classId;


@end
