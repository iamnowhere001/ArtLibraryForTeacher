//
//  LocalData.m
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/9/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "LocalData.h"
#import "ClassModel.h"
#import "StudentModel.h"
#import "StudentInfoModel.h"
#define DB_PAGESIZE 10

@interface LocalData ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation LocalData

+ (LocalData*)shareLocalData {

    static LocalData *dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[LocalData alloc]init];
    });
    return dbManager;
}

- (void)createDatabase {

    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlite"];
    ZFLog(@"---- %@",fileName);
    //1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    
    //2.创表
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists ClassList (PID integer primary key autoincrement, className text, classID text, opusCount integer, studentCount integer, isExpanded integer);"];
        if (result) {
            ZFLog(@"ClassList---创表成功");
        }else{
            ZFLog(@"ClassList---创表失败");
        }
    }];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists StudentList (PID integer primary key autoincrement, classID text, studentName text, studentId text, studentOpusCount text, headImage text);"];
        if (result) {
            ZFLog(@"StudentList---创表成功");
        }else{
            ZFLog(@"StudentList---创表失败");
        }
    }];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists StudentInfo (studentName text, studentId text, birthday text, gender integer, headImage text, mobile text, permCity text, email text, resumes text);"];
        if (result) {
            ZFLog(@"StudentList---创表成功");
        }else{
            ZFLog(@"StudentList---创表失败");
        }
    }];
}

- (void)insertClassListData:(ClassModel*)model {

    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into ClassList (className, classID, opusCount, studentCount, isExpanded) values (?, ?, ?, ?, ?);", model.className, model.classID, [NSNumber numberWithInteger:model.opusCount], [NSNumber numberWithInteger:model.studentCount], [NSNumber numberWithBool:model.isExpanded]];
        
    }];
    
    [model.studentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        StudentModel *m = (StudentModel*)obj;
        m.classID = model.classID;
        [self insertStudentListData:m];
    }];
}
- (void)insertStudentListData:(StudentModel*)model {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into StudentList (classID, studentName, studentId, studentOpusCount, headImage) values (?, ?, ?, ?, ?);", model.classID, model.studentName, model.studentId, model.studentOpusCount, model.headImage];
    }];
}
- (void)insertStudentInfoData:(StudentInfoModel*)model {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into StudentInfo (studentName, studentId, birthday, gender, headImage, mobile, permCity, email, resumes) values (?, ?, ?, ?, ?, ?, ?, ?, ?);", model.studentName, model.studentId, model.birthday, [NSNumber numberWithInt:model.gender], model.headImage, model.mobile, model.permCity, model.email, model.resumes];
    }];
}
- (StudentInfoModel*)queryStudentInfo {

    StudentInfoModel *model = [[StudentInfoModel alloc]init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from StudentInfo"];
        while (rs.next) {
            
            model.studentName = [rs stringForColumn:@"studentName"];
            model.studentId = [rs stringForColumn:@"studentId"];
            model.birthday = [rs stringForColumn:@"birthday"];
            model.gender = [[rs stringForColumn:@"gender"] intValue];
            model.headImage = [rs stringForColumn:@"headImage"];
            model.mobile = [rs stringForColumn:@"mobile"];
            model.permCity = [rs stringForColumn:@"permCity"];
            model.email = [rs stringForColumn:@"email"];
            model.resumes = [rs stringForColumn:@"resumes"];
        }
    }];
    return model;
}


- (void)updateClassListData:(ClassModel*)model {

    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update ClassList set className = ? where classID = ?;", model.className, model.classID];
        [db executeUpdate:@"update ClassList set opusCount = ? where classID = ?;", [NSNumber numberWithInteger:model.opusCount], model.classID];
        [db executeUpdate:@"update ClassList set studentCount = ? where classID = ?;", [NSNumber numberWithInteger:model.studentCount], model.classID];
        [db executeUpdate:@"update ClassList set isExpanded = ? where classID = ?;", [NSNumber numberWithBool:model.isExpanded], model.classID];
    }];
    [model.studentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        StudentModel *m = (StudentModel*)obj;
        m.classID = model.classID;
        [self updateStudentListData:m];
    }];
}

- (void)updateStudentListData:(StudentModel*)model {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update StudentList set classID = ? where studentId = ?;", model.classID, model.studentId];
        [db executeUpdate:@"update StudentList set studentName = ? where studentId = ?;", model.studentName, model.studentId];
        [db executeUpdate:@"update StudentList set studentOpusCount = ? where studentId = ?;", model.studentOpusCount, model.studentId];
        [db executeUpdate:@"update StudentList set headImage = ? where studentId = ?;", model.headImage, model.studentId];
    }];
}

- (BOOL)queryClassListData:(ClassModel*)model {
    
    __block BOOL isBool = NO;
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *rs = [db executeQuery:@"select * from ClassList where classID = ?;", model.classID];
        if (rs.next) {
            isBool = YES;
        }
    }];

    return isBool;
}
- (NSArray*)queryAllClassListData {

    NSMutableArray *tempArr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from ClassList"];
        while ([rs next]){
            ClassModel *model = [[ClassModel alloc]init];
            model.classID = [rs stringForColumn:@"classID"];
            model.className = [rs stringForColumn:@"className"];
            model.opusCount = [rs intForColumn:@"opusCount"];
            model.studentCount = [rs intForColumn:@"studentCount"];
            
            model.studentList = [self queryAllStudentListData:model];
            
            [tempArr addObject:model];
        }
    }];
    return tempArr;
}
- (NSArray*)queryAllStudentListData:(ClassModel*)m {
    
    NSMutableArray *tempArr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from StudentList where classID = ?;",m.classID];
        while ([rs next]){
            StudentModel *model = [[StudentModel alloc]init];
            model.studentId = [rs stringForColumn:@"studentId"];
            model.studentName = [rs stringForColumn:@"studentName"];
            model.studentOpusCount = [rs stringForColumn:@"studentOpusCount"];
            model.headImage = [rs stringForColumn:@"headImage"];
            
            [tempArr addObject:model];
        }
    }];
    return tempArr;
}
//删除一条数据
- (void)deleteClassListData:(ClassModel*)model {

    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete * from ClassList where classID = ?;", model.classID];
    }];
}



#pragma mark -删除sql操作
//ID 等于0 删除一张表中所有数据
-(void)DeleteTableName:(NSString *)tableName PID:(int)ID {
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if(ID==0){
            NSString *sql=[NSString stringWithFormat:@"delete from %@",tableName];
            [db executeUpdate:sql];
        }
        else{
            NSString *sql=[NSString stringWithFormat:@"delete from %@ where PID = %zi",tableName,ID];
            [db executeUpdate:sql];
        }
        if ([db hadError])
        {
            NSLog(@"delete from %@  error  %d: %@",tableName, [db lastErrorCode], [db lastErrorMessage]);
        }
    }];
    
}

#pragma mark - 分页查询
-(NSArray *)SelectTableName:(NSString *)tableName  startPage:(int)page{
    
    NSMutableArray *temp=[NSMutableArray array];
    NSString *sql=[NSString stringWithFormat:@"select  * from %@ where PID >= %zi and PID <= %zi order by PID desc",tableName,(page-1)*DB_PAGESIZE+1,page*DB_PAGESIZE];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs=[db executeQuery:sql];
        
        while ([rs next]){
            ClassModel *model = [[ClassModel alloc]init];
            model.classID = [rs stringForColumn:@"classID"];
            model.className = [rs stringForColumn:@"className"];
            model.opusCount = [rs intForColumn:@"opusCount"];
            model.studentCount = [rs intForColumn:@"studentCount"];
            
            [temp addObject:model];
        }
    }];
    
    return temp;
}

#pragma mark - 删除数据库
- (NSString *)getDBPathWithName:(NSString *)dbName {
    if (dbName == nil || dbName.length == 0 || ![dbName isKindOfClass:[NSString class]]) {
        NSLog(@"获取数据库文件路径失败，dbName为空");
        return nil;
    }
    // 获取沙盒中Document的路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSString *name = [[dbName pathExtension] isEqualToString:@"sqlite"] ? dbName : [NSString stringWithFormat:@"%@.sqlite",dbName];
    // 数据库路径
    NSString *path = [documentPath stringByAppendingPathComponent:name];
    return path;
}
- (BOOL)deleteDataBaseWithName:(NSString *)dbName {
    if (dbName == nil || dbName.length == 0 || ![dbName isKindOfClass:[NSString class]]) {
        NSLog(@"删除数据库失败，数据库名字为空。");
        return NO;
    }
    // 获得数据库路径
    NSString *dbPath = [self getDBPathWithName:dbName];
    // 记录执行结果
    BOOL result = NO;
    // 删除数据库文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dbPath]){
        result = [fileManager removeItemAtPath:dbPath error:nil];
    }else{
        NSLog(@"删除数据库失败，没有发现数据库文件。");
    }
    return result;
}

@end
