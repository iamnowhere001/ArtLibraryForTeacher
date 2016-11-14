//
//  YMHApiManager.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorksModel;

@interface YMHApiManager : NSObject


#pragma mark - ---------------- 教师端 -------------------
#pragma mark - 教师端相关API

/// 教师登录
+ (void)loginOfTeacherWithName:(NSString *)name pwd:(NSString *)pwd success:(void (^)(id response))success fail:(void (^)(NSString *msg))fail;

/// 获取学期列表
+ (void)getSemesterListSuccess:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 获取教师所授课专业
+ (void)getProfessionWithProfessionId:(NSString *)professionId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 获取班级列表
+ (void)getClassListWithEmployeeId:(NSString *)employeeId professionId:(NSString *)professionId semesterId:(NSString *)semesterId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 获取班级学员列表 classId
+ (void)getStudentListWithClassId:(NSString *)classId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

#pragma mark ------ 作品列表展示 ------
#pragma mark - 首页



#pragma mark - 个人中心

/// 获取一个班级内的一个学生的所有作品
+ (void)getUserArticleListWithClassId:(NSString*)classId studentId:(NSString *)studentId pageIndex:(NSUInteger)index success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

#pragma mark - 作品类型

/// 获取类型列表
+ (void)getCategoryListSuccess:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 获取作品类别
+ (void)getCategoryByImageId:(NSString *)imageId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

#pragma mark - 作品管理

/// 上传图片 （作品）& (头像) type 0 作品 1 头像
+ (void)uploadImageWithImage:(UIImage *)image type:(NSUInteger)type progress:(void(^)(float progress))progress success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 添加作品
+ (void)addArticleWithWorksModel:(WorksModel *)works categoryId:(NSString *)categoryId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 编辑作品 参数使用模型 这样单独修改某个属性比较方便简洁 初始化
+ (void)editArticleWithWorksModel:(WorksModel *)works categoryId:(NSString *)categoryId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;

/// 删除作品
+ (void)deltArticleWithImageId:(NSString *)imageId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;


#pragma mark - 用户资料

/// 获取学生信息
+ (void)getUserInfoWithUid:(NSString *)uid success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail;




@end
