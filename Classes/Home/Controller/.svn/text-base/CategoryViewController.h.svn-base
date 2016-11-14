//
//  CategoryViewController.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/25.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class WorksModel;

typedef NS_ENUM(NSUInteger, CategoryType) {
    CategoryTypeEdit = 0,           // 编辑
    CategoryTypeAdd = 1,           // 添加
};

@protocol CategoryViewDelegate <NSObject>
@optional
- (void)saveArticleCategory:(NSArray *)array;
@end

@interface CategoryViewController : BaseViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) WorksModel *model;
@property (nonatomic, copy) NSString *categoryCid;
@property (nonatomic, copy) NSString *categoryname;

@property (nonatomic, assign) CategoryType categoryType;

@property (nonatomic, weak) id<CategoryViewDelegate>delegate;

@end
