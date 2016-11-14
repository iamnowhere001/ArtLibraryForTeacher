//
//  ArticleHeaderViewModel.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/9.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "ArticleHeaderViewModel.h"
#import "WorksModel.h"
#import "UILabel+XYAdd.h"
@implementation ArticleHeaderViewModel

- (void)setWorks:(WorksModel *)works {
    
    _works = works;
    
    CGFloat imageW = MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2;
    CGFloat imageH = imageW * _works.heigth /_works.width;
    
    // 作品frame
    _imageF = CGRectMake(BigCellLeftMargin, 8, imageW, imageH);
    
    // 作品标题
    _titleF = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(_imageF) + 10, MAIN_SCREEN_WIDTH - BigCellLeftMargin*2 - 40, 20);
    
    // 分享
    _shareF = CGRectMake(MAIN_SCREEN_WIDTH - BigCellLeftMargin - 30, CGRectGetMaxY(_imageF) + 11, 18, 17);
    
    // 割线
    _line1F = CGRectMake(0, CGRectGetMaxY(_titleF) + 10, MAIN_SCREEN_WIDTH, 0.5);
    
    // 作品描述
    if ([NSString isNull:_works.describe]) {
        
        _tipF = CGRectMake(0, CGRectGetMaxY(_line1F), MAIN_SCREEN_WIDTH, 30);
        
    } else {
        
        // 这种实现更优雅
        CGFloat height = [UILabel text:_works.describe heightWithFontSize:13 width:MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2 lineSpacing:2.5];
        
        _detailF = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(_line1F) + 10, MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2, height);
        
        _tipF = CGRectMake(0, CGRectGetMaxY(_detailF) + 10, MAIN_SCREEN_WIDTH, 30);
    }
    
    // view高度
    _height = CGRectGetMaxY(_tipF) - 5;// - 0.5 + 5
    
}

@end
