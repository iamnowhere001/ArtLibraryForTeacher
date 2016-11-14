//
//  NSArray+XYAdd.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "NSArray+XYAdd.h"

@implementation NSArray (XYAdd)

-(NSString *)toString {
    // NSArray *arr = nil;
    // NSString *str = [arr componentsJoinedByString:@","]; //数组转字符串
    
    NSMutableString *arrayString = [NSMutableString string];
    
    for (int i = 0; i < [self count]; i++) {
        if (i > 0) {
            [arrayString appendString:@","];
        }
        [arrayString appendFormat:@"%@", self[i]];
    }
    return arrayString;
}
@end
