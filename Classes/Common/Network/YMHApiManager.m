//
//  YMHApiManager.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/6.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "YMHApiManager.h"

#import "YMHURLDefine.h"
#import "HYBNetworking.h"
//
#import "WorksModel.h"

#import "ArticleViewModel.h"

#import "UserAccountModel.h"
#import "StudentInfoModel.h"

#import "CategoryModel.h"

#import "NSString+MD5.h"
#import "NSDate+XYEXtension.h"
#import "UIImage+XYAdd.h"

#import "UIImage+Resize.h"

#import "ClassModel.h"
#import "SemesterModel.h"
#import "ProfessionModel.h"
#import "StudentModel.h"

#define StudentId      [[NSUserDefaults standardUserDefaults]objectForKey:@"studentId"]
#define StudentName    [[NSUserDefaults standardUserDefaults]objectForKey:@"studentName"]
#define Birthday       [[NSUserDefaults standardUserDefaults]objectForKey:@"birthday"]

@interface YMHApiManager ()

@end

@implementation YMHApiManager

#define token @"30BEE9532284F5D469CC5EB4FBCA3AF180E4E0973751AC670A81FBA72DA6909874940A21EB56138A8B150338970B90D5741C15CC07542263DC8E9FE064B1F443"

#define kPageSize 10

#pragma mark - 作品展示列表

+ (void)load {
    // 接口打印信息
    [HYBNetworking enableInterfaceDebug:YES];
    // [HYBNetworking updateBaseUrl:baseUrl];
    // 设置GET、POST请求都缓存
    // [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
}


#pragma mark - 教师端相关API

/// 教师登录
+ (void)loginOfTeacherWithName:(NSString *)name pwd:(NSString *)pwd success:(void (^)(id response))success fail:(void (^)(NSString *msg))fail {
    
    //    NSString *PWD = [[NSString hybnetworking_md5:pwd]uppercaseString];
    NSDictionary *params = @{
                             @"employeeName":name,
                             @"pwd":pwd,
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,teacherLogin] refreshCache:NO params:params success:^(id response) {
        
        if ([response[@"state"] integerValue] == YES) {
            
            success(response);
            UserAccountModel *model = [[UserAccountModel alloc]init];
            model.uid = response[@"content"][@"EmployeeId"];
            model.username = name;
            model.password = pwd;
            [UserDefaultsHelper saveUserInfo:model];
        }else{
            [SVProgressHUD showInfoWithStatus:@"登录异常"];
        }
        
    } fail:^(NSError *error) {
        ZFLog(@"-------%@",error.description);
        fail(error.description);
    }];
}

/// 获取学期列表
+ (void)getSemesterListSuccess:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = @{
                             @"employeeId":[UserDefaultsHelper getUid],
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getSemester] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        if ([arr isKindOfClass:[NSString class]]) {
            success(nil);
            return ;
        }
        
        for (NSDictionary *dict in arr) {
            SemesterModel *groupModel = [SemesterModel mj_objectWithKeyValues:dict];
            [array addObject:groupModel];
        }
        success(array);
        
    } fail:^(NSError *error) {
        
        fail(error.description);
    }];
}

// 需要提供所有专业列表
+ (void)getProfessionWithProfessionId:(NSString *)professionId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = @{
                             @"employeeId":[UserDefaultsHelper getUid],
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getProfession] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        
        if ([arr isKindOfClass:[NSString class]]) {
            success(nil);
            return ;
        }
        
        for (NSDictionary *dict in arr) {
            ProfessionModel *groupModel = [ProfessionModel mj_objectWithKeyValues:dict];
            [array addObject:groupModel];
        }
        success(array);
        
    } fail:^(NSError *error) {
        
        ZFLog(@"-------%@",error.description);
        fail(error.description);
    }];
}

/// 获取班级列表
+ (void)getClassListWithEmployeeId:(NSString *)employeeId professionId:(NSString *)professionId semesterId:(NSString *)semesterId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = @{
                             @"employeeId":employeeId,
                             @"professionId":professionId,
                             @"semesterId":semesterId,
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getClassInfo] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *groupArray = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        
        if ([arr isKindOfClass:[NSString class]]) {
            NSString *msg= [response objectForKey:@"content"];
            success (msg);
            return ;
        }
        if (arr.count == 0) {
            return ;
        }
        for (NSDictionary *dict in arr) {
            ClassModel *groupModel = [ClassModel mj_objectWithKeyValues:dict];
            groupModel.isExpanded = NO; // 添加属性标识
            [groupArray addObject:groupModel];
            
            //本地保存
//            if ([[LocalData shareLocalData]queryClassListData:groupModel]) {
//                [[LocalData shareLocalData]updateClassListData:groupModel];
//            }else{
//            
//                [[LocalData shareLocalData]insertClassListData:groupModel];
//            }
        }
        success(groupArray);
        
    } fail:^(NSError *error) {
        fail(error.description);
        
    }];
}

/// 获取班级学员列表
+ (void)getStudentListWithClassId:(NSString *)classId Success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    classId = @"104";
    NSDictionary *params = @{
                             @"classId":classId,
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getStudentInfo] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *groupArray = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        for (NSDictionary *dict in arr) {
            StudentModel *groupModel = [StudentModel mj_objectWithKeyValues:dict];
            [groupArray addObject:groupModel];
        }
        
        success(response);
        
    } fail:^(NSError *error) {
        
        fail(error.description);
    }];
}



/// 获取一个班级内的一个学生的所有作品
+ (void)getUserArticleListWithClassId:(NSString*)classId studentId:(NSString *)studentId pageIndex:(NSUInteger)index success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = @{
                             @"pageIndex":@(index),
                             @"pageSize":@(kPageSize),
                             @"classId":classId,
                             @"studentId":studentId,
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getPersonalCenterLibraryList] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *recommendArray = [NSMutableArray array];
        NSArray *arr= [response objectForKey:@"content"];
        if ([arr isKindOfClass:[NSString class]]) {
            NSString *msg= [response objectForKey:@"content"];
            success (msg);
            
        } else if ([arr isKindOfClass:[NSArray class]]){
            
            
            //按创建时间排序
            NSDateFormatter *df = [NSDateFormatter new];
//            [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSArray *arr1 = [arr sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary * obj2) {
                
                NSString *str1 = obj1[@"AddTime"];
                NSString *str2 = obj2[@"AddTime"];
                
                NSDate *date1 = [df dateFromString:[[str1 stringByReplacingOccurrencesOfString:@"T" withString:@" "] componentsSeparatedByString:@"."][0]];
                NSDate *date2 = [df dateFromString:[[str2 stringByReplacingOccurrencesOfString:@"T" withString:@" "] componentsSeparatedByString:@"."][0]];
                
                NSComparisonResult result = [date1 compare:date2];
                
                return result == NSOrderedAscending; //NSOrderedAscending降序 ，NSOrderedDescending升序
                
            }];
            
            //解析数据
            for (NSDictionary *dict in arr1) {
                WorksModel *works = [WorksModel mj_objectWithKeyValues:dict];
                ArticleViewModel *viewModel = [[ArticleViewModel alloc]init];
                viewModel.works = works;
                [recommendArray addObject:viewModel];
            }
            success(recommendArray);
        }else {
            NSString *msg= @"暂无数据";
            success(msg);
        }
    } fail:^(NSError *error) {
        fail(error.description);
    }];
}

/// 获取作品类型列表
+ (void)getCategoryListSuccess:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = @{
                             @"token":token
                             };
    
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getCategory] refreshCache:NO params:params success:^(id response) {
        
        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        for (NSDictionary *dict in arr) {
            CategoryModel *model = [CategoryModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
        // 通过属性列表文件持久化
//        NSString *category = [[CommonHelper getDocumentPath] stringByAppendingPathComponent:@"category.plist"];
//        if (![array writeToFile:category atomically:YES]) {
//            NSLog(@"作品类别插入失败");
//        }
//        NSLog(@"--------------%@",category);
//        NSLog(@"-------------%@",array);
        success(array);
        
    } fail:^(NSError *error) {
        fail(error.description);
    }];
    
}


/// 获取作品类别 通过作品ID查询
+ (void)getCategoryByImageId:(NSString *)imageId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    if (imageId == nil) {
        return;
    }
    
    NSDictionary *params = @{
                             @"id":imageId,
                             @"token":token
                             };
    
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getCategoryById] refreshCache:NO params:params success:^(id response) {
        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *arr = [response objectForKey:@"content"];
        if ([arr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in arr) {
                CategoryModel *model = [CategoryModel mj_objectWithKeyValues:dict];
                [array addObject:model];
            }
            
            success (array);
        } else {
            NSString *message = [response objectForKey:@"content"];
            fail(message);
        }
    } fail:^(NSError *error) {
        fail(error.description);
    }];
}

#pragma mark - 作品管理

/// 上传图片
+ (void)uploadImageWithImage:(UIImage *)image type:(NSUInteger)type progress:(void(^)(float progress))progress success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    NSDictionary *params = nil;
    NSString *imageName = nil;
    
    if (type == 0) {
        if (Birthday == nil) {
            params = @{
                       @"studentId":StudentId,
                       @"type":@"Library",
                       @"token":token
                       };
        }else{
        
            params = @{
                       @"studentId":StudentId,
                       @"birthday":Birthday,
                       @"type":@"Library",
                       @"token":token
                       };
        }
        
        imageName = @"Library";
    } else {
        params = @{
                   @"studentId":StudentId,
                   @"type":@"Head",
                   @"token":token
                   };
        imageName = @"Head";
    }
    
    //NSLog(@"-----12--- h:%.2f  w:%.2f",image.size.height,image.size.width);
    //[image fixOrientation];
    //NSLog(@"-----13--- h:%.2f  w:%.2f",image.size.height,image.size.width);
    
    //image = [UIImage scaleImage:image toScale:0.95];
    //NSLog(@"-----14--- h:%.2f  w:%.2f",image.size.height,image.size.width);
    
    // perfect 只有相机拍摄的图片才会进行尺寸校正 设置为 W * H -> 1080 * 1920
    image = [image resizedImageToFitInSize:CGSizeMake(1080, 1080 * image.size.height / image.size.width) scaleIfSmaller:NO];
   // NSLog(@"-----15--- h:%.2f  w:%.2f",image.size.height,image.size.width);
    
    [HYBNetworking uploadWithImage:image url:[NSString stringWithFormat:@"%@%@",baseUrl,uploadImage] filename:nil name:imageName mimeType:@"image/jpeg" parameters:params progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        CGFloat upload = bytesWritten;
        CGFloat total = totalBytesWritten;
        // NSLog(@"---上传进度----%.2f",upload/total *100);
        float uploadprogress = upload/total *100;
        
        progress(uploadprogress);
        
    } success:^(id response) {
        //NSLog(@"---上传图片---%@",response);
        NSString * message = [response objectForKey:@"message"];
        long state =[[response objectForKey:@"state"]integerValue];
        if (state) {
            NSString * path = [response objectForKey:@"Path"];
            success(path);// 返回图片路径
        } else {
            [SVProgressHUD showErrorWithStatus:message];
            fail(message);
        }
        
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        fail(error.description);
    }];
}

/// 添加作品
+ (void)addArticleWithWorksModel:(WorksModel *)works categoryId:(NSString *)categoryId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    if (works.describe == nil) {
        works.describe = @"";
    }
    if (works.diyCagegory == nil) {
        works.diyCagegory = @"";
    }
    NSDictionary *params = @{
                             @"teacherId":[UserDefaultsHelper getUid],
                             @"teacherName":[UserDefaultsHelper getUserName],
                             @"studentName":StudentName,
                             @"studentId":StudentId,
                             @"opusName":works.title,
                             @"opusList" :works.imagePath,
                             @"remark":works.describe,
                             @"categoryId":categoryId,
                             @"classId":works.classId,
                             @"time":works.createDate,
                             @"isPublic":@(works.stuIsPublic),
                             @"isArt"   :@(1),
                             @"diyCagegoryId" :works.diyCagegory,
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,addOpusManage] refreshCache:NO params:params success:^(id response) {
        long state =[[response objectForKey:@"state"]integerValue];
        if (state) {
            [kNotificationCenter postNotificationName:@"UpdateMyselfViewController" object:nil];
            success(@"完成");
        } else {
//            [SVProgressHUD showErrorWithStatus:@"失败"];
            fail([response objectForKey:@"content"]);
        }
        success(response);
    
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        fail(error.description);
        
    }];
}

/// 编辑作品
+ (void)editArticleWithWorksModel:(WorksModel *)works categoryId:(NSString *)categoryId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    
    if (works.imagePath == nil || categoryId == nil) {
        return;
    }
    NSDictionary *params = @{
                             @"studentId":StudentId,
                             @"opusName":works.title,
                             @"opusList" :works.imagePath,
                             @"remark":works.describe,
                             @"time":works.createDate,
                             @"categoryId":categoryId,
                             @"classId":works.classId,
                             @"opusManageId":works.imageId,
                             @"isPublic":@(works.stuIsPublic),
                             @"diyCagegoryId" :@"",
                             @"token":token
                             };
    
    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,editOpusManage] refreshCache:NO params:params success:^(id response) {
        long state =[[response objectForKey:@"state"]integerValue];
        if (state) {
            [kNotificationCenter postNotificationName:@"UpdateMyselfViewController" object:nil];
            success(@"完成");
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            fail(@"失败");
        }
        
    } fail:^(NSError *error) {
        fail(error.description);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

/// 删除作品
+ (void)deltArticleWithImageId:(NSString *)imageId success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    if (imageId == nil) {
        return;
    }
    NSDictionary *params = @{
                             @"studentId":StudentId,
                             @"opusManageId":imageId,
                             @"token":token
                             };
    
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,delInfo] refreshCache:NO params:params success:^(id response) {
        
        long state =[[response objectForKey:@"state"]integerValue];
        if (state) {
            [kNotificationCenter postNotificationName:@"UpdateMyselfViewController" object:nil];
            success(response);
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
        
    } fail:^(NSError *error) {
        fail(error.description);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

#pragma mark - 用户资料

/// 获取学生信息
+ (void)getUserInfoWithUid:(NSString *)uid success:(void(^)(id response))success fail:(void(^)(NSString *msg))fail {
    if (uid == nil) {
        return;
    }
    NSDictionary *params = @{
                             @"id":uid,
                             @"token":token
                             };
    
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",baseUrl,getUserInfo] refreshCache:NO params:params success:^(id response) {
        
        
        NSDictionary *dict = [response objectForKey:@"content"];
        StudentInfoModel *model = [StudentInfoModel mj_objectWithKeyValues:dict];
        
//        [[LocalData shareLocalData]DeleteTableName:@"StudentInfo" PID:0];
//        [[LocalData shareLocalData]insertStudentInfoData:model];
        
        success(model);
    } fail:^(NSError *error) {
        fail(error.description);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}


@end
