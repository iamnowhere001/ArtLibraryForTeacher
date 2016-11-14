//
//  XYDatePickerView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/12.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "XYDatePickerView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kDatePickerHeight   160.f
#define kDateViewHeight     200.f

@interface XYDatePickerView (){
    
    UIDatePicker *_datePicker;      //日期选择器
    UIButton     *_btnLeftCancel;   //左边取消按钮
    UIButton     *_btnRightConform; //右边确定按钮
    BOOL         _isSelectDate;     //是否选择日期
    UIView       *_toolView;
    NSString     *_dateString;
    UIButton     *_cancelBtn;
}

@end

@implementation XYDatePickerView

+ (XYDatePickerView *)shareInstance {
    static XYDatePickerView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XYDatePickerView alloc]init]; // - init
    });
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]){
        CGRect frect = CGRectZero;
        frect.size.height  = kDateViewHeight;
        frect.size.width   = SCREEN_WIDTH;
        frect.origin.y     = SCREEN_HEIGHT;
        self.frame = frect;
        //self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.99];
        self.backgroundColor = [UIColor colorWithRed:0.937 green:0.941 blue:0.945 alpha:1.00];
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    // toolbar工具条
    _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _toolView.backgroundColor = [UIColor colorWithRed:0.851 green:0.855 blue:0.855 alpha:1.00];
    [self addSubview:_toolView];
    
    // 取消
    _btnLeftCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLeftCancel.frame = CGRectMake(5, 0, 60, 40);
    [_btnLeftCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnLeftCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnLeftCancel addTarget:self action:@selector(cancelDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_btnLeftCancel];
    
    // 确定
    _btnRightConform = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRightConform.frame = CGRectMake(SCREEN_WIDTH-65, 0, 60, 40);
    [_btnRightConform setTitle:@"完成" forState:UIControlStateNormal];
    [_btnRightConform setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnRightConform addTarget:self action:@selector(ConformDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_btnRightConform];
    
    // datepicker
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.frame = CGRectMake(0, 40, SCREEN_WIDTH, kDatePickerHeight); // 不要写死啊啊
    //设置格式显示年月日
    _datePicker.datePickerMode = UIDatePickerModeDate;
    //本地化为中文公历
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*50];
    _datePicker.maximumDate = [NSDate date];
    
    // 设置日期选择器当前选中时间 用户当前日期
    
    //    NSString *dateString = _dateString; //@"1992-05-21";
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSDate *destDate = [dateFormatter dateFromString:dateString];
    //    [_datePicker setDate:destDate];
    //  [_datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*15] animated:YES];
    
    [_datePicker addTarget:self action:@selector(pickerviewChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
}

/**
 *   取消按钮添加事件
 */
- (void)cancelDatePicker:(UIButton *)sender {
    [self dismissDatePiker];
    if (selectDateCompleteHander){
        selectDateCompleteHander([self dealselectDate:[NSDate date]], @"-1");
    }
}

/**
 *  确定按钮添加事件
 */
- (void)ConformDatePicker:(UIButton *)sender {
    if (sender.isTouchInside) {
        [self dismissDatePiker];
        /**
         *  如果没有选择日期，则当天日期作为参数传递 ---> 亦使用当前选择日期
         */
        if (!_isSelectDate){
            if (selectDateCompleteHander){
                selectDateCompleteHander([self dealselectDate:_datePicker.date], @"1");//[NSDate date]
            }
        }else{
            if (selectDateCompleteHander){
                selectDateCompleteHander([self dealselectDate:_datePicker.date], @"1");
            }
        }
        _isSelectDate = NO;
    }
}

/**
 *  获取当前选择的日期
 */
- (void)pickerviewChanged:(UIDatePicker *)picker {
    _isSelectDate = YES;
    if (selectDateCompleteHander) {
        selectDateCompleteHander([self dealselectDate:picker.date], @"0");
    }
}

/**
 *  格式化处理获取的日期
 *
 *  @param date 当前日期或者是选择的日期
 *
 *  @return 返回一个已经格式化日期字符串
 */
- (NSString*)dealselectDate:(NSDate *)date {
    //NSArray * arrOfWeek=@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = nil;// [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay |NSCalendarUnitWeekday |NSCalendarUnitHour |
    NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    // NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    /**对月份进行处理月份的位数一位数时需要在月份前面添加“0”*/
    NSString *monthFormatter = [NSString stringWithFormat:@"%ld",(long)month];
    if (monthFormatter.length == 1) {
        monthFormatter = [NSString stringWithFormat:@"0%@",monthFormatter];
    } else {
        monthFormatter = monthFormatter;
    }
    
    NSString *dayFormatter = [NSString stringWithFormat:@"%ld",(long)day];
    if (dayFormatter.length == 1) {
        dayFormatter = [NSString stringWithFormat:@"0%@",dayFormatter];
    } else {
        dayFormatter = dayFormatter;
    }
    
    /**特殊时间格式4/27(周一)*/
    //    NSString *formatterDate = [NSString stringWithFormat:@"%@/%ld(%@)",monthFormatter,(long)day,[arrOfWeek objectAtIndex:week-1]];
    //    NSString *appendDate = [NSString stringWithFormat:@"%ld-%@-%ld %@",(long)year,monthFormatter,(long)day,formatterDate];
    
    NSString *appendDate = [NSString stringWithFormat:@"%ld-%@-%@",(long)year,monthFormatter,dayFormatter];
    
    return appendDate;
}

- (void)showInView:(UIView *)baseView andSelectDateCompleteHander:(SelectDatePickerCompleteHandler)dateCompleteHandler {
    
    selectDateCompleteHander = dateCompleteHandler;
    
    [baseView addSubview:self];
    
    // 真的好么？
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    _cancelBtn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
    [_cancelBtn addTarget:self action:@selector(dismissDatePiker) forControlEvents:UIControlEventTouchUpInside];
    [baseView insertSubview:_cancelBtn belowSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = baseView.frame; //0 0 375 667 无导航栏    0 64 375 603 有导航栏
        CGRect selfRect = self.frame;
        selfRect.origin.y =  rect.size.height - kDateViewHeight;// SCREEN_HEIGHT - kDateViewHeight - 64; // 导航栏高度
        self.frame = selfRect;
       
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)showInView:(UIView *)baseView andSelectDateCompleteHander:(SelectDatePickerCompleteHandler)dateCompleteHandler {
    [[XYDatePickerView shareInstance] showInView:baseView andSelectDateCompleteHander:dateCompleteHandler];
}

- (void)dismissDatePiker {
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect selfRect = self.frame;
        selfRect.origin.y = SCREEN_HEIGHT;
        self.frame = selfRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_cancelBtn removeFromSuperview];
    }];
}

@end
