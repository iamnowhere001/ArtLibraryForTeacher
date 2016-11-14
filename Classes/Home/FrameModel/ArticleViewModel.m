//
//  YMMArticleViewModel.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "ArticleViewModel.h"
#import "WorksModel.h"
#import "UILabel+XYAdd.h"
@implementation ArticleViewModel

- (void)setWorks:(WorksModel *)works {
    
    _works = works;
    
    CGFloat cellWidth = MAIN_SCREEN_WIDTH - 10;
    
    if (!_works.width || _works.width == 0 || !_works.heigth || _works.heigth == 0) {
        _works.width  = 90;
        _works.heigth = 160;
    }
    
    // 作品frame
    _imageF = CGRectMake(0, 0, cellWidth, cellWidth * _works.heigth / _works.width);
    
    // 作品标题
    if ([NSString isNull:_works.title]) {
        
        _titleF = CGRectMake(5, CGRectGetMaxY(_imageF), cellWidth - 10, 1);
        
    } else {
        _titleF = CGRectMake(5, CGRectGetMaxY(_imageF) + 10, cellWidth - 10, 20); // 换行
        _line1F = CGRectMake(0, CGRectGetMaxY(_titleF) + 10, cellWidth, 0.5);
    }
    
    // 作品描述
    if ([NSString isNull:_works.describe]) {
        _cellHeight = CGRectGetMaxY(_line1F);
        
    } else {
        
        // 这种实现更优雅
        CGFloat height = [UILabel text:_works.describe heightWithFontSize:13 width:cellWidth - 20 lineSpacing:2.5];
        _detailF = CGRectMake(5, CGRectGetMaxY(_line1F) + 5, cellWidth - 20, height + 10);
        
        _cellHeight = CGRectGetMaxY(_detailF) + 10;
        
    }
    
    
}
@end
