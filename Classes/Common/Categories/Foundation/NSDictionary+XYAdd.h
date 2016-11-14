//
//  NSDictionary+XYAdd.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XYAdd)

/**
 *  将字典编码为UTF8格式
 *
 *  @param dict 字典对象
 *
 *  @return UTF8格式的字典对象
 */
+ (NSDictionary *)encodeUTF8WithDictionary:(NSDictionary *)dict;

/**
 *  打印字典（中文编码）
 *
 *  @param dict 字典对象
 */
+(void)printUTF8WithDict:(NSDictionary *)dict;

/**
 *  将字典编码为UTF8格式
 *
 *  @return UTF8格式的字典对象
 */
- (NSDictionary *)encodeUTF8WithDictionary;

/**
 *  中文编码格式打印字典
 */
-(void)printUTF8;

@end
