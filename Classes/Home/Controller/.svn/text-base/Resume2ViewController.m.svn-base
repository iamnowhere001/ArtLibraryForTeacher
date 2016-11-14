//
//  Resume2ViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/18.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "Resume2ViewController.h"

#import "UILabel+XYAdd.h"

@interface Resume2ViewController ()


@end

@implementation Resume2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - 

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@艺术履历",self.name];
    // 获取文本高度
    CGFloat h = [UILabel text:self.resume heightWithFontSize:13 width:MAIN_SCREEN_WIDTH - 40 lineSpacing:2.5];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, MAIN_SCREEN_WIDTH - 40, h)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    [label setText:self.resume lineSpacing:2.5];
    [self.view addSubview:label];
}


@end
