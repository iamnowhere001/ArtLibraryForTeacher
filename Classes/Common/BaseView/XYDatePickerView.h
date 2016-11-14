//
//  XYDatePickerView.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/12.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  日期选择器回调
 *
 *  @param selectDate 获取选择的日期
 */
typedef void(^SelectDatePickerCompleteHandler)(NSString *selectDate, NSString *tag);


@interface XYDatePickerView : UIView {
    SelectDatePickerCompleteHandler  selectDateCompleteHander;
}

+ (XYDatePickerView *)shareInstance;

/**
 *  底部加载显示日期选择器DatePickerView
 *
 *  @param baseView            父视图
 *  @param dateCompleteHandler 获取日期回调
 */
- (void)showInView:(UIView *)baseView andSelectDateCompleteHander:(SelectDatePickerCompleteHandler)dateCompleteHandler;

/**
 *  通过类方法来显示日期选择器DatePickerView
 *
 *  @param baseView 父视图
 *  @param dateCompleteHandler 获取日期回调
 *
 */
+ (void)showInView:(UIView *)baseView andSelectDateCompleteHander:(SelectDatePickerCompleteHandler)dateCompleteHandler;

/**
 *  移除日期选择器
 */
- (void)dismissDatePiker;

@end
