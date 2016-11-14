//
//  InputViewController.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class WorksModel;

typedef NS_ENUM(NSUInteger, TextEditType) {
    TextEditTypeEdit = 0,           ///< 编辑
    TextEditTypeAdd = 1,            ///< 添加
};

@protocol InputViewDelegate <NSObject>
- (void)saveArticleTitleMessage:(NSString *)message tag:(NSString *)tag;
@end

@interface InputViewController : BaseViewController

@property (nonatomic, copy) NSString *categoryCid;
@property (nonatomic, strong) WorksModel *model;
@property (nonatomic, assign) TextEditType textEditType;

@property (nonatomic, weak) id<InputViewDelegate>delegate;

@end
