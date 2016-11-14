//
//  TeacherHeaderView.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/5.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TeacherHeaderViewCallback)(NSInteger tag);

@interface TeacherHeaderView : UIView

@property (nonatomic, copy) TeacherHeaderViewCallback callback;

@end
