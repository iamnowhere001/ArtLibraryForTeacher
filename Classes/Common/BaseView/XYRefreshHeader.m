//
//  XYRefreshHeader.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/25.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "XYRefreshHeader.h"

@interface XYRefreshHeader ()
@property (weak, nonatomic) UIImageView *logoImageView;

@end

@implementation XYRefreshHeader {
    UIImageView *_loadingImageView;
    UIImageView *_completeLogoImageView;
}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置

- (void)prepare {
    [super prepare];
    
    self.mj_h = 50;
    
    _loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo_loading"]];
    _loadingImageView.contentMode = UIViewContentModeCenter;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_loadingImageView];
    self.logoImageView = _loadingImageView;
    
    //    _completeLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableView_Refresh_Success"]];
    [self.logoImageView addSubview:_completeLogoImageView];
    //    _completeLogoImageView.hidden = YES;
}

/// 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    
    [super placeSubviews];
    
    self.logoImageView.frame = CGRectMake(0, 0, 50, 50);
    self.logoImageView.center = CGPointMake(self.mj_w / 2, self.mj_h / 2);
}

/// 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

/// 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

/// 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

///  监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
            /** 普通闲置状态 */
        case MJRefreshStateIdle:{
            [self.logoImageView stopAnimating];
        }
            break;
        case MJRefreshStatePulling:{
            
        }
            break;
        case MJRefreshStateRefreshing:{
            [self.logoImageView startAnimating];
            //[self  getOffLineSocket];
        }
            break;
        case MJRefreshStateNoMoreData:{
            
        }
            break;
        case MJRefreshStateWillRefresh:{
            [self.logoImageView stopAnimating];
        }
            break;
            
        default:
            break;
    }
}

/// 获取离线消息
- (void)getOffLineSocket
{
//    YZLoginUserModel * userModel = [[YZLoginUserStore shareStore] loginUser];
//    YZSocketMessage * message = [[YZSocketMessage alloc]initWithCid:OffLineMessage andUid:[userModel.uid intValue] andForuid:0 andRole:0 andAction:0 andTime:0 andJson:nil];
//    [message sendMessage];
}

/// 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
}

/// 结束刷新
- (void)endRefreshing {
    _loadingImageView.image = [UIImage imageNamed:@"TableView_Refresh_Success"];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(endYZRefresh) userInfo:nil repeats:NO];
}

- (void)endYZRefresh {
    [super endRefreshing];
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(changeLogoImage) userInfo:nil repeats:NO];
}

- (void)changeLogoImage {
    _loadingImageView.image = [UIImage imageNamed:@"icon_logo_loading"];
}

@end
