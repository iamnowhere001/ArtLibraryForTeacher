//
//  MJExtensionConfig.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/12.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"

#import "WorksModel.h"
#import "UserAccountModel.h"
#import "StudentInfoModel.h"
#import "ClassModel.h"
#import "StudentModel.h"

#import "ProfessionModel.h"
#import "SemesterModel.h"
#import "CategoryModel.h"
@implementation MJExtensionConfig

/**
 *  这个方法会在MJExtensionConfig加载进内存时调用一次
 */
+ (void)load {
#pragma mark 如果使用NSObject来调用这些方法，代表所有继承自NSObject的类都会生效
#pragma mark NSObject中的ID属性对应着字典中的id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id" //id 为关键字 属性命名需回避
                 };
    }];
    
    [WorksModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"addTime"                    : @"AddTime", // 命名
                 @"classId"                    : @"ClassId",
                 @"createDate"                 : @"CreateDate",
                 @"describe"                   : @"Describe",
                 @"diyCagegory"                : @"DiyCagegory",
                 @"heigth"                     : @"Heigth",
                 @"imageId"                    : @"ImageId",
                 @"imagePath"                  : @"ImagePath",
                 @"opusIsDeleted"              : @"OpusIsDeleted",
                 @"opusIsPublic"               : @"OpusIsPublic",
                 @"recommendPosition"          : @"RecommendPosition",
                 @"stuIsDeleted"               : @"StuIsDeleted",
                 @"stuIsPublic"                : @"StuIsPublic",
                 @"studentId"                  : @"StudentId",
                 @"studentName"                : @"StudentName",
                 @"thumbnailDeatialImagePath"  : @"ThumbnailDeatialImagePath",
                 @"thumbnailImagePath"         : @"ThumbnailImagePath",
                 @"title"                      : @"Title",
                 @"width"                      : @"Width",
                 @"isArt"                      : @"isArt"
                 };
    }];
    
    [UserAccountModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"uid"         : @"sys00001",
                 @"username"    : @"userName",
                 @"password"    : @"userpwd",
                 @"birthday"    : @"Birthday"
                 };
    }];
    
    [StudentInfoModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"studentId"   : @"StudentId",
                 @"studentName" : @"StudentName",
                 @"resumes"     : @"Resumes",
                 @"permCity"    : @"PermCity",
                 @"mobile"      : @"Mobile",
                 @"headImage"   :@"HeadImage",
                 @"gender"      : @"Gender",
                 @"email"       : @"Email",
                 @"birthday"    : @"Birthday",
                 
                 };
    }];
    
    [CategoryModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"categoryName" : @"CategoryName",
                 @"cid" : @"Cid"
                 };
    }];
    
    
    
    [ClassModel mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"studentList" : @"StudentModel"};
    }];
    
//    [ProfessionModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"employeeId" : @"EmployeeId",
//                 @"professionalId" : @"ProfessionalId",
//                 @"professionalName" : @"ProfessionalName"
//                 };
//    }];
//    
//    [SemesterModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"employeeId" : @"EmployeeId",
//                 @"semesterId" : @"SemesterId",
//                 @"semesterName" : @"SemesterName"
//                 };
//    }];
}

@end
