//
//  ArticleHeaderViewModel.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/9.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorksModel;

@interface ArticleHeaderViewModel : NSObject

@property (nonatomic, assign, readonly) CGRect imageF;      ///< 图片
@property (nonatomic, assign, readonly) CGRect titleF;      ///< 名称
@property (nonatomic, assign, readonly) CGRect shareF;      ///< 分享
@property (nonatomic, assign, readonly) CGRect line1F;      ///< 割线1
@property (nonatomic, assign, readonly) CGRect detailF;     ///< 详细信息
@property (nonatomic, assign, readonly) CGRect iconF;       ///< 图像
@property (nonatomic, assign, readonly) CGRect nameF;       ///< 作者
@property (nonatomic, assign, readonly) CGRect tipF;        ///< 提示

@property (nonatomic, assign, readonly) CGFloat height;    ///< header高度

@property (nonatomic, strong) WorksModel * works;

@end
