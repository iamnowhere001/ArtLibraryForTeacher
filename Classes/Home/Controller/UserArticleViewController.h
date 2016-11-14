//
//  UserArticleViewController.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class WorksModel;

@interface UserArticleViewController : BaseViewController
@property (nonatomic, strong) WorksModel*model;// big image of header
@property (nonatomic, assign) UIImage *image; //
@end
