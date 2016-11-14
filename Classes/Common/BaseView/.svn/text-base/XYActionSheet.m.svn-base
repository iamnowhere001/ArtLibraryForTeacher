//
//  XYActionSheet.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/20.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "XYActionSheet.h"

@interface XYActionSheet (){
    CGSize _size;
}
@property (nonatomic, strong) UIView *menuView;

@end
@implementation XYActionSheet

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr {
    
    self = [super initWithFrame:frame];
    _size = [UIScreen mainScreen].bounds.size;
    [self setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];
    [self makeBaseUIWithTitleArr:titleArr];
    
    return self;
}

- (void)makeBaseUIWithTitleArr:(NSArray *)titleArr{
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, _size.height, _size.width, titleArr.count * 50 + 55)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:0.9];//1.0
    [self addSubview:self.menuView];
    
    CGFloat y = [self createBtnWithTitle:@"取消" origin_y: _menuView.frame.size.height - 50 tag:-1 action:@selector(hiddenSheet)] - 55;
    for (int i = 0; i < titleArr.count; i++) {
        y = [self createBtnWithTitle:titleArr[i] origin_y:y tag:i action:@selector(click:)];
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _menuView.frame;
        frame.origin.y -= frame.size.height;
        _menuView.frame = frame;
    }];
}

- (CGFloat)createBtnWithTitle:(NSString *)title origin_y:(CGFloat)y tag:(NSInteger)tag action:(SEL)method {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, y, _size.width, 50);
    btn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    btn.tag = tag;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:btn];
    
    return y -= tag == -1 ? 0 : 50.4;
}

- (void)hiddenSheet {
    // 重置
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kActionSheetDismiss"];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _menuView.frame;
        frame.origin.y += frame.size.height;
        _menuView.frame = frame;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)click:(UIButton *)btn {
    if (self.Click) {
        _Click(btn.tag);
    }
    [self hiddenSheet];//hidden
}


@end
