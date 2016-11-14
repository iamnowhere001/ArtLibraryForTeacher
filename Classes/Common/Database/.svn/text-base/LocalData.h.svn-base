//
//  LocalData.h
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/9/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClassModel;
@class StudentModel;
@class StudentInfoModel;
@interface LocalData : NSObject

+ (LocalData*)shareLocalData;
- (void)createDatabase;

- (void)insertClassListData:(ClassModel*)model;
- (void)insertStudentListData:(StudentModel*)model;

- (void)updateClassListData:(ClassModel*)model;
- (void)updateStudentListData:(StudentModel*)model;

- (BOOL)queryClassListData:(ClassModel*)model;
- (void)deleteClassListData:(ClassModel*)model;

- (NSArray*)queryAllClassListData;
- (NSArray*)queryAllStudentListData:(ClassModel*)m;


- (void)insertStudentInfoData:(StudentInfoModel*)model;
- (StudentInfoModel*)queryStudentInfo;
/**
 *  ID 等于0 删除一张表中所有数据
 *
 *  @param tableName 表名
 *  @param ID        主键
 */
-(void)DeleteTableName:(NSString *)tableName PID:(int)ID;

/**
 *  获得数据库文件的路径
 *  @param dbName 数据库的名字
 *  @return 数据库的路径
 */
- (NSString *)getDBPathWithName:(NSString *)dbName;
/**
 *  删除数据库
 *  @param dbName 数据库名字
 *  @return BOOL 是否删除成功
 */
- (BOOL)deleteDataBaseWithName:(NSString *)dbName;
@end
