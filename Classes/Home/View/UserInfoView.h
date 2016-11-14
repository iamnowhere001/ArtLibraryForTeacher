//
//  UserInfoView.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/26.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>


@class StudentInfoViewModel;

@interface UserInfoView : UIView

@property (nonatomic, copy) void (^headerButtonClickedBlock)(NSInteger btnTag ,CGFloat height);

@property (nonatomic, strong) StudentInfoViewModel *viewModel;

@end
