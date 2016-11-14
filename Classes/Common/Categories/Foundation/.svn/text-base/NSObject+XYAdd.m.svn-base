//
//  NSObject+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "NSObject+XYAdd.h"
#import <objc/runtime.h>

@implementation NSObject (XYAdd)

+ (void)logAllIvars{
    // 谁调用这个类方法就传谁
    Class c = self;
    while (c) {
        // 获得所有的成员变量
        unsigned int outCount = 0;
        
        Ivar *ivarList = class_copyIvarList(c, &outCount);
        // 遍历所有的成员变量
        for (int i = 0; i < outCount; i++) {
            // 获取第i个成员变量
            Ivar ivar = ivarList[i];
            // 获得成员变量的名称和类型
            NSLog(@"%@ -> %s %s",c,ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        }
        // 释放资源
        free(ivarList);
        // 获取父类
        c = class_getSuperclass(c);
    }
}

@end
