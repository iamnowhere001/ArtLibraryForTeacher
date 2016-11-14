//
//  ArticleViewModel.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorksModel;
@interface ArticleViewModel : NSObject

@property (nonatomic, assign, readonly) CGRect imageF;      ///< 图片
@property (nonatomic, assign, readonly) CGRect titleF;      ///< 名称
@property (nonatomic, assign, readonly) CGRect line1F;      ///< 割线1
@property (nonatomic, assign, readonly) CGRect detailF;     ///< 详细信息
@property (nonatomic, assign, readonly) CGRect line2F;      ///< 割线2
@property (nonatomic, assign, readonly) CGRect nameF;       ///< 作者
@property (nonatomic, assign, readonly) CGFloat cellHeight; ///< cell高度


@property (nonatomic, strong) WorksModel * works;           ///< model

@end
