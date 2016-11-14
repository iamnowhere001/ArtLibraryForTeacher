//
//  UserArticleViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UserArticleViewController.h"

#import "ArticleView.h"
#import "WorksModel.h"

#import "ArticleEditViewController.h"

@interface UserArticleViewController ()

@property (nonatomic, strong) ArticleView *articleView;


@property (nonatomic, strong) UITableView *userTableView;
@end

@implementation UserArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@作品集",self.model.studentName];
    [self initNav];
    [self initUserTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initNav {
    
    XYButton *editButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 28, 25)];
    [editButton sizeToFit];
    [editButton setImage:[UIImage imageNamed:@"icon_nav_edit_new"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:editButton];
}

- (void)initUserTableView {
    
    CGSize detialSize = [CommonHelper sizeWithText:self.model.describe font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAIN_SCREEN_WIDTH - 48, MAXFLOAT)];
    if ([NSString isNull:self.model.describe]) {
        detialSize.height -= 32;
    }
    CGSize size = CGSizeMake( MAIN_SCREEN_WIDTH, (MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2) * self.model.heigth/self.model.width +detialSize.height + 105);
    
    self.articleView = [[ArticleView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    self.articleView.works = self.model;

    self.userTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.userTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.userTableView.tableHeaderView = self.articleView;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.userTableView];
}


#pragma mark -
- (void)edit {
    
    ArticleEditViewController *VC = [[ArticleEditViewController alloc]init];
    VC.model = self.model;
    VC.image = self.articleView.imageView.image;
    VC.type = ArticleTypeEdit;
    [self.navigationController pushViewController:VC animated:YES];
}



@end
