//
//  InputTextViewController.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, TextViewEditType) {
    TextEditViewTypeEdit = 0,           // 编辑
    TextEditViewTypeAdd = 1,           // 添加
};

@class WorksModel;

@protocol InputTextViewDelegate <NSObject>
- (void)saveArticleDesribeMessage:(NSString *)message tag:(NSString *)tag;
@end

@interface InputTextViewController : BaseViewController

@property (nonatomic, copy) NSString *categoryCid;
@property (nonatomic, strong) WorksModel *model;

@property (nonatomic, assign) TextViewEditType textViewEditType;

@property (nonatomic, weak) id<InputTextViewDelegate>delegate;

@end
