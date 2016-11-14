//
//  SearchBarView.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/23.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "XYSearchBarView.h"

#define TopMargin 5
#define FieldWidth 34

@interface XYSearchBarView ()

@property (nonatomic, strong) UIImageView *searchBackgroundImgView;

@end

@implementation XYSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _searchBackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,5,MAIN_SCREEN_WIDTH - 60 ,34)];
        _searchBackgroundImgView.userInteractionEnabled = NO;
        _searchBackgroundImgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _searchBackgroundImgView.layer.cornerRadius = 6;
        _searchBackgroundImgView.layer.masksToBounds = YES;
        [self addSubview:_searchBackgroundImgView];
        
        _searchTextField = [[UITextField alloc]init];
        _searchTextField.placeholder = @"搜索";
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.textColor = [UIColor blackColor];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.enablesReturnKeyAutomatically = YES;
        self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_searchTextField];
        
        _searchCancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_searchCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_searchCancelBtn setTintColor:[UIColor colorWithRed:0 green:141/255.0 blue:221/255.0 alpha:1.0]];
        [self addSubview:_searchCancelBtn];
        [_searchCancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    
    _searchBackgroundImgView.frame = CGRectMake(10,13,MAIN_SCREEN_WIDTH - 60 ,34);
    _searchTextField.frame = CGRectMake(20, 13, MAIN_SCREEN_WIDTH - 70, 34);
    _searchCancelBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH - 45, 13, 40 , 34);
}

- (void)cancelBtnClick {
    
    [self.searchTextField resignFirstResponder];
    if (self.buttonClickedOperationBlock) {
        self.buttonClickedOperationBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
