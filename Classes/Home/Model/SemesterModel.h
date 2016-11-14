//
//  SemesterModel.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/4.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SemesterModel : NSObject

@property (nonatomic, copy) NSString *employeeId;   ///< 老师id
@property (nonatomic, copy) NSString *semesterId;   ///< 学期id
@property (nonatomic, copy) NSString *semesterName; ///< 学期名称

@end
