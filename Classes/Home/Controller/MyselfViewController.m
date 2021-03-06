//
//  MyselfViewController.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/21.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "MyselfViewController.h"
#import "UserInfoView.h"
#import "UserArticleCell.h"
#import "ArticleViewModel.h"
#import "StudentInfoModel.h"
#import "StudentInfoViewModel.h"
#import "ImagePickerHelper.h"
#import "WorksModel.h"
// 添加、编辑作品
#import "ArticleEditViewController.h"
// 作品详细界面
#import "UserArticleViewController.h"
// 艺术履历
#import "Resume2ViewController.h"


@interface MyselfViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSUInteger      _currentIndex;
}

@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) UserInfoView *headerView;
@property (nonatomic, strong) StudentInfoModel *userInfo;

@property (nonatomic, strong) XYButton *addButton;

@property (nonatomic, strong) UITableView *userTableView;

@end

@implementation MyselfViewController

#pragma mark -

- (NSMutableArray *)articleArray {
    if (!_articleArray) {
        _articleArray = [NSMutableArray array];
    }
    return _articleArray;
}

- (void)getDataSource {
    
    __weak __typeof(self) weakSelf = self;
    [YMHApiManager getUserArticleListWithClassId:weakSelf.classId studentId:weakSelf.studentId pageIndex:_currentIndex success:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            [weakSelf.articleArray removeAllObjects];
            [weakSelf.articleArray addObjectsFromArray:response];
            [self.userTableView reloadData];
            [SVProgressHUD dismiss];
           
        } else {
            [SVProgressHUD showInfoWithStatus:@"暂无数据"];
        }
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"请求异常"];
    }];
    
}

- (void)addRefresh {
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 其它设备更新了用户信息 没有通知只能这样了
        [self getUserInfo];
        _currentIndex = 1;
        [YMHApiManager getUserArticleListWithClassId:weakSelf.classId studentId:weakSelf.studentId pageIndex:_currentIndex success:^(id response) {
            
            if ([response isKindOfClass:[NSArray class]]) {
                [weakSelf.articleArray removeAllObjects];
                [weakSelf.articleArray addObjectsFromArray:response];
                [weakSelf.userTableView reloadData];
            }
            [weakSelf.userTableView.mj_header endRefreshing];
            // 重置
            [weakSelf.userTableView.mj_footer endRefreshing];
        } fail:^(NSString *msg) {
            [weakSelf.userTableView.mj_header endRefreshing];
        }];
    }];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    //header.stateLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    self.userTableView.mj_header = header;
    
    //
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _currentIndex++;
        [YMHApiManager getUserArticleListWithClassId:weakSelf.classId studentId:weakSelf.studentId pageIndex:_currentIndex success:^(id response) {
            if ([response isKindOfClass:[NSArray class]]) {
                [weakSelf.articleArray addObjectsFromArray:response];
                [weakSelf.userTableView reloadData];
                [weakSelf.userTableView.mj_footer endRefreshing];
            } else {
                [weakSelf.userTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } fail:^(NSString *msg) {
            [weakSelf.userTableView.mj_footer endRefreshing];
        }];
            
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    footer.triggerAutomaticallyRefreshPercent = 0.3;
    
    [footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    
    footer.automaticallyChangeAlpha = YES;
    self.userTableView.mj_footer = footer;
}

- (void)getUserInfo {
    
    // 更新
    [YMHApiManager getUserInfoWithUid:self.studentId success:^(id response) {
        self.userInfo = response;
        StudentInfoViewModel *viewModel = [[StudentInfoViewModel alloc]init];
        viewModel.userInfo = self.userInfo; // set
        self.headerView.viewModel = viewModel;
        self.headerView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, viewModel.height);
        [self.userTableView reloadData];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.studentId forKey:@"studentId"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.studentName forKey:@"studentName"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.birthday forKey:@"birthday"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } fail:^(NSString *msg) {
        
        [SVProgressHUD showInfoWithStatus:msg];
    }];
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    _currentIndex = 1;
    
    [self initUserTableView];
    
    [self getUserInfo];
    [self getDataSource];
    
    [self initNav];
    
    [self addRefresh];

    [kNotificationCenter addObserver:self selector:@selector(updateUserArticleList) name:@"UpdateMyselfViewController" object:nil];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
}
- (void)updateUserArticleList {
    _currentIndex = 1;
    [self getDataSource];
}



- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"UpdateMyselfViewController" object:nil];
}

#pragma mark -

- (void)initNav {
    
    self.addButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 21, 21)];
    [_addButton sizeToFit];
    [self.addButton setImage:[UIImage imageNamed:@"icon_nav_add"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addArticle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.addButton];
    
}

- (void)initUserTableView {
    
    self.userTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.userTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.userTableView.dataSource = self;
    self.userTableView.delegate = self;
    [self.view addSubview:self.userTableView];
    [self.userTableView registerClass:[UserArticleCell class] forCellReuseIdentifier:@"UserArticleCell"];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.showsVerticalScrollIndicator = NO;
    
    self.headerView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 140)];
    
    self.userTableView.tableHeaderView = self.headerView;
    
    __weak typeof(self) weakSelf = self;
    self.headerView.headerButtonClickedBlock = ^(NSInteger btnTag, CGFloat height) {
        if (btnTag == 1) {
            Resume2ViewController *VC = [[Resume2ViewController alloc]init];
            VC.name = weakSelf.userInfo.studentName;
            VC.resume = weakSelf.userInfo.resumes;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
        
    };
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.articleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UserArticleCell *cell = [UserArticleCell cellWithTableView:tableView];
    cell.articleViewModel = self.articleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.userTableView deselectRowAtIndexPath:indexPath animated:YES];
    UserArticleViewController *VC = [[UserArticleViewController alloc]init];
    ArticleViewModel *model = self.articleArray[indexPath.row];
    VC.model = model.works;
    [self.navigationController pushViewController:VC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ArticleViewModel *model = self.articleArray[indexPath.row];
    return model.cellHeight;
}

#pragma mark - private method


- (void)addArticle {
    [self getImage];
}

#pragma mark - 图片相关

- (void)getImage {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加作品" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[ImagePickerHelper shareInstance]onPhotoActionWithTargetVC:self callBackBlock:^(NSDictionary *infoDict, BOOL isCancel) {
            if (!isCancel) {
                [self configImageInfo:infoDict];
            }
        }];
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[ImagePickerHelper shareInstance]onCameraActionWithTargetVC:self callBackBlock:^(NSDictionary *infoDict, BOOL isCancel) {
            if (!isCancel) {
                [self configImageInfo:infoDict];
            }
        }];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:albumAction];
    [alert addAction:cameraAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)configImageInfo:(NSDictionary *)infoDict {
    
    UIImage *image = [infoDict objectForKey:UIImagePickerControllerOriginalImage];
    ArticleEditViewController *VC = [[ArticleEditViewController alloc]init];
    VC.image = image;
    VC.type = ArticleTypeAdd;
    VC.classId = self.classId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
