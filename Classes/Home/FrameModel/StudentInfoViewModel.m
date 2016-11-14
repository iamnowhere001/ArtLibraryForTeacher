//
//  StudentInfoViewModel.m
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/8/31.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "StudentInfoViewModel.h"
#import "StudentInfoModel.h"

@implementation StudentInfoViewModel

- (void)setUserInfo:(StudentInfoModel *)userInfo {
    _userInfo = userInfo;
    
    _imageF = CGRectMake(25, 20, 100, 100);
    
    CGSize nameSize = [_userInfo.studentName sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont systemFontOfSize:18]}];
    
    _nameF = CGRectMake(CGRectGetMaxX(_imageF) + 25, CGRectGetMaxY(_imageF) - 70, nameSize.width, 20);
    
    _tagF = CGRectMake(CGRectGetMaxX(_nameF) + 10, CGRectGetMinY(_nameF), 120, 20);
    
    _infoF = CGRectMake(CGRectGetMaxX(_imageF) + 25, CGRectGetMaxY(_nameF) + 5, 200, 20);
    
     _resumeF = CGRectMake(CGRectGetMaxX(_imageF) + 25, CGRectGetMaxY(_infoF) + 5, 71, 26);
    
//    if ([NSString isNull:_userInfo.resumes]) {
        _height = 140;
//
//    } else {
//        _line2F = CGRectMake(0, CGRectGetMaxY(_imageF) + 20, MAIN_SCREEN_WIDTH, 4);
//        _tag2F = CGRectMake(20, CGRectGetMaxY(_line2F) + 5, 100, 15);
//        // 行距 可以更直接一点
//        CGSize detialSize = [CommonHelper sizeWithText:_userInfo.resumes font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(MAIN_SCREEN_WIDTH - 40, MAXFLOAT)];
//        _detailF = CGRectMake(20,  CGRectGetMaxY(_tag2F) + 5, detialSize.width, detialSize.height);
//        
//        _height = CGRectGetMaxY(_detailF) + 5;
//    }
    
}
@end
