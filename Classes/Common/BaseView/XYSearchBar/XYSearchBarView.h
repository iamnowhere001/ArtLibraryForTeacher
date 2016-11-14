//
//  SearchBarView.h
//  ArtLibrary
//
//  Created by JRuser on 16/5/23.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSearchBarView : UIView
@property (nonatomic, copy) void(^buttonClickedOperationBlock)();

@property (nonatomic, strong) UIButton *searchCancelBtn;
@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, copy) NSString *keyword;

@end
