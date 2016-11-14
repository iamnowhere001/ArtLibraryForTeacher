//
//  XYSearchView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/5.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "XYSearchView.h"

@interface XYSearchView ()
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *line2;
@end

@implementation XYSearchView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _searchTextField = [[XYTextField alloc] init];
        _searchTextField.placeholder = @"搜索作品关键字或学生姓名";
        //_searchTextField.font = [UIFont fontWithName:@"" size:12];
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.textColor = [UIColor blackColor];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.enablesReturnKeyAutomatically = YES;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _searchTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        _searchTextField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:_searchTextField];
        
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = SeparatorLineColor;
        [self addSubview:self.line];
        
        self.line2 = [[UILabel alloc] init];
        self.line2.backgroundColor = SeparatorLineColor;
        [self addSubview:self.line2];
    }
    return self;
}

- (void)layoutSubviews {
    _searchTextField.frame = CGRectMake(15, 11, MAIN_SCREEN_WIDTH - 30, 34);
    _line.frame = CGRectMake(0, self.frame.size.height - 4, MAIN_SCREEN_WIDTH, 4);
    _line2.frame = CGRectMake(0, 1, MAIN_SCREEN_WIDTH, 0.5);
}

@end
