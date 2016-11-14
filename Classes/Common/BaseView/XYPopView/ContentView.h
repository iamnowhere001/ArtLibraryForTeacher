//
//  ContentView.h
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView
@property (nonatomic, copy) void (^buttonClickedBlock)(NSInteger btnTag);
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
