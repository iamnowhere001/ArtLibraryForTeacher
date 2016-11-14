//
//  StudentInfoModel.h
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/8/31.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentInfoModel : NSObject
/**
 *  学生id
 */
@property (nonatomic, copy) NSString *studentId;
/**
 *  学生姓名
 */
@property (nonatomic, copy) NSString *studentName;
/**
 *  头像路径
 */
@property (nonatomic, copy) NSString *headImage;
/**
 *  生日
 */
@property (nonatomic, copy) NSString *birthday;
/**
 *  城市
 */
@property (nonatomic, copy) NSString *permCity;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  个人履历
 */
@property (nonatomic, copy) NSString *resumes;
/**
 *  性别
 */
@property (nonatomic, assign) int gender;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *mobile;
@end
