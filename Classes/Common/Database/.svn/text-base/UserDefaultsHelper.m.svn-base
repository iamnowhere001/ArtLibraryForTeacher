//
//  UserDefaultsHelper.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/4.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UserDefaultsHelper.h"
#import "UserAccountModel.h"

//-------- userDefaults ----------

#define UID       @"uid"
#define USERNAME  @"username"
#define PASSWORD  @"password"


@implementation UserDefaultsHelper

/// 获取用户uid
+ (NSString *)getUid {
    return [[NSUserDefaults standardUserDefaults]objectForKey:UID];
}

/// 获取用户名称
+ (NSString *)getUserName {
    return [[NSUserDefaults standardUserDefaults]objectForKey:USERNAME];
}


/// 获取账号密码
+ (NSString *)getPassword {
    return [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
}


/// 清除用户登录信息
+ (void)removeUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:UID];
    [userDefaults removeObjectForKey:USERNAME];
    [userDefaults removeObjectForKey:PASSWORD];
   
}

/// 保存用户信息
+ (void)saveUserInfo:(UserAccountModel *)model {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:model.uid forKey:UID];
    [userDefaults setObject:model.username forKey:USERNAME];
    [userDefaults setObject:model.password forKey:PASSWORD];
    [userDefaults synchronize];
}

@end
