//
//  BaseViewController.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/30.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏侧滑取消 边缘侧滑
   // self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    /**
     iOS7之后是有侧滑返回手势功能的。注意，也就是说系统已经定义了一种手势，并且给这个手势已经添加了一个触发方法（重点）。但是，系统的这个手势的触发条件是必须从屏幕左边缘开始滑动。我们取巧的方法是自己写一个支持全屏滑动的手势，而其触发方法系统已经有，没必要自己实现pop的动画，所以直接就把系统的触发处理方法作为我们自己定义的手势的处理方法。
     苹果的侧滑返回之所以设计成必须从屏幕左侧边缘滑起可能就是为了避免和屏幕上其他左滑动作冲突。当自己的产品设计成屏幕上有多个左滑动作时，你可以屏蔽不必要的一种。比如，我遇到过某个界面是地图，地图是可以左右滑动调整视野范围的，但是和自定义的侧滑返回冲突了，这时我把侧滑返回屏蔽了，只保留地图滑动。
     */
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = BackgroundColor;
    
    
    XYButton *backButton = [[XYButton alloc]initWithFrame:CGrectBackBtn];
    [backButton setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count == 1 ? NO : YES;
}

#pragma mark -

- (void)addTipView {
    
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, MAIN_SCREEN_HEIGHT/3, MAIN_SCREEN_WIDTH - 100, 20)];
    self.tipLabel.text = @"当前没有数据";
    self.tipLabel.font = [UIFont systemFontOfSize:14.0];
    self.tipLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.00];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.tipLabel];
    
    self.tipLabel.hidden = YES;
}

#pragma mark - 

- (void)showTips:(NSString *)message {
    
    if ([[UIDevice currentDevice]systemVersion].floatValue >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alert addAction:cancelAction];
        [alert addAction:setAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// 监听屏幕上的touch事件，隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
