//
//  CategoryModel.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/14.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *cid;

@property (nonatomic, assign) BOOL selected;

@end
