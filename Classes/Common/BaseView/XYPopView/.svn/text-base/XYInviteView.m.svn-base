//
//  XYInviteView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/16.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "XYInviteView.h"
#import "UIColor+Additions.h"

#define kRowHeight 50;

@interface XYInviteView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_titleArray;
    NSArray *_imageNameArray;
}

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) UIButton  *button; //响应点击事件

@end

@implementation XYInviteView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间"];
        _imageNameArray = @[@"share_wechat_44",@"share_wechat_circle_44",@"share_QQ_44",@"share_QQZone_44"];
        
        [self initTableView];
    }
    return self;
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 50 * 4, self.bounds.size.width, 50 * 4) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    _tableView.rowHeight = 50;
    _tableView.scrollEnabled = NO;
}

#pragma mark - 接口
- (void)show {
    [self button]; // 响应点击事件
    [self showAnimation];
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animate {
    
    if (!animate) {
        [self removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _tableView.frame;
        frame.origin.y = MAIN_SCREEN_HEIGHT;
        _tableView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -
- (void)showAnimation{
    
    CGRect frame = _tableView.frame;
    frame.origin.y = MAIN_SCREEN_HEIGHT;
    _tableView.frame = frame;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _tableView.frame;
        frame.origin.y = MAIN_SCREEN_HEIGHT - 50 * 4;
        _tableView.frame = frame;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (UIButton *)button{
    if (_button != nil) {
        return _button;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.tableView]; // 懒加载
    
    _button = [[UIButton alloc] initWithFrame:self.frame];
    _button.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [_button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:_button belowSubview:_tableView];
    
    return _button;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]]; // 大小不易控制
    cell.textLabel.text = _titleArray[indexPath.row];
    //cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    [self dismiss];
}

@end
