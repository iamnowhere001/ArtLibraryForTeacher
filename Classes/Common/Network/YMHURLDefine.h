//
//  YMHURLDefine.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/4.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#ifndef YMHURLDefine_h
#define YMHURLDefine_h

#pragma mark - host
/**
 *  图片加载主路径
 */
static const NSString *imageBaseUrlPath = @"http://112.124.27.173:1027"; // @"http://112.124.27.173:1027";// 测试服务器 个人中心
static const NSString *imageBaseUrl = @"http://img.ymm.cn/"; // 正式服务器  首页

/**
 *  服务器的主路径 host
 */
//static  NSString *baseUrl = @"http://120.76.168.178:1027";// @"http://192.168.99.2:1028";
static  NSString *baseUrl = @"http://112.124.27.173:1028";

#pragma mark - 作品展示列表

/**
 *  用户其他作品列表
 */
// 个人中心
static  NSString *personalCenterLikeSearch = @"/api/Librarys/PersonalCenterLikeSearch";

//获取一个班级内的一个学生的所有作品
static  NSString *getPersonalCenterLibraryList = @"/api/Librarys/GetStuentLibraryList";
/**
 *  分类列表
 */
static  NSString *getCategory = @"/api/Librarys/GetCategory";
/**
 *  类别查询列表
 */
static  NSString *getCategoryList = @"/api/Librarys/GetCategoryList";
/**
 *  获取作品类别 通过作品ID查询
 */
static  NSString *getCategoryById = @"/api/Librarys/GetCategoryById";

#pragma mark - 作品编辑
/**
 *  上传图片
 */
static  NSString *uploadImage = @"/api/Files/UploadImage";
/**
 *  添加作品
 */
static  NSString *addOpusManage = @"/api/Class/AddOpusManage";
/**
 *  编辑作品
 */
static  NSString *editOpusManage = @"/api/Librarys/EditOpusManage";
/**
 *  删除作品
 */
static  NSString *delInfo = @"/api/Librarys/DelInfo";

#pragma mark - 用户信息
/**
 *  获取学生信息
 */
static  NSString *getUserInfo = @"/api/Librarys/GetStudentById";
/**
 *  编辑个人信息
 */
static  NSString *editUserInfo = @"/api/Librarys/EidtStudents";

#pragma mark - 设置

/**
 *  登录
 */
static  NSString *login = @"/api/Librarys/Login";


#pragma mark - 教师端相关API

/// 教师登录  老师登录,要有授权到班级,才会让他登录
static NSString *teacherLogin = @"/api/Class/Login";

/// 学期
static NSString *getSemester = @"/api/Class/GetSemester";

/// 专业   该老师账号对应授权到的专业(一个账号对应一个专业)
static NSString *getProfession = @"/api/Class/GetProfession";

/// 班级列表
static NSString *getClassInfo = @"/api/Class/GetClassInfo";

/// 班级学员信息
static NSString *getStudentInfo = @"/api/Class/GetStudentInfo";


#endif /* YMHURLDefine_h */
