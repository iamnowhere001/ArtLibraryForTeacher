//
//  TeacherHomeViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/3.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "HomeViewController.h"
#import "MyselfViewController.h"

#import "ClassHeaderView.h"
#import "ClassModel.h"
#import "StudentModel.h"
#import "StudentsCell.h"
#import "TeacherHeaderView.h"

#import "ChooseSemesterCustomView.h"
#import "ChooseProfessionalCustomView.h"
#import "SemesterModel.h"
#import "ProfessionModel.h"

#define kMainWidth  ([UIScreen mainScreen].bounds.size.width - 8)/4

static NSString *kCellIdentfier = @"StudentsCell";
static NSString *kHeaderIdentifier = @"ClassHeaderView";

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


/**
 *  班级列表数组
 */
@property (nonatomic, strong) NSMutableArray *classList;
/**
 *  学生列表数组
 */
@property (nonatomic, strong) NSMutableArray *studentList;
/**
 *  学期id
 */
@property (nonatomic, copy) NSString *semesterId;
/**
 *  选择的学期id
 */
@property (nonatomic, copy) NSString *selectSemesterId;
/**
 *  学期数组
 */
@property (nonatomic, strong) NSMutableArray *semesterArr;
/**
 *  专业id
 */
@property (nonatomic, copy) NSString *professionId;
/**
 *  专业id
 */
@property (nonatomic, copy) NSString *selectProfessionId;
/**
 *  专业数组
 */
@property (nonatomic, strong) NSMutableArray *professionalArr;

@property (nonatomic, strong) UICollectionView *userCollectionView;

@end

@implementation HomeViewController

- (NSMutableArray *)classList {
    if (!_classList) {
        _classList = [NSMutableArray array];

    }
    return _classList;
}
- (NSMutableArray *)studentList{

    if (!_studentList) {
        _studentList = [NSMutableArray array];
    }
    return _studentList;
}
- (NSMutableArray *)semesterArr{

    if (!_semesterArr) {
        _semesterArr = [NSMutableArray array];
    }
    return _semesterArr;
}
- (NSMutableArray *)professionalArr{

    if (!_professionalArr) {
        _professionalArr = [NSMutableArray array];
    }
    return _professionalArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"艺术作品档案库";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = nil;
    self.professionId = @"";
    self.semesterId = @"";
    self.selectSemesterId = @"1";
    self.selectProfessionId = @"1";
    
    [self initTableView];
    [self initHeaderView];
    
    [self getDataSource];
    [self addRefresh];
    [kNotificationCenter addObserver:self selector:@selector(updateUI) name:@"UpdateHomeViewController" object:nil];
}

- (void)initTableView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.sectionInset = UIEdgeInsetsMake(2, 1, 2, 1);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake(kMainWidth, kMainWidth);
    
    self.userCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60) collectionViewLayout:layout];
    self.userCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.userCollectionView.delegate = self;
    self.userCollectionView.dataSource = self;
    [self.view addSubview:self.userCollectionView];
   
    self.userCollectionView.showsVerticalScrollIndicator = NO;
    [self.userCollectionView registerNib:[UINib nibWithNibName:@"StudentsCell" bundle:nil] forCellWithReuseIdentifier:kCellIdentfier];
    [self.userCollectionView registerClass:[ClassHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
//    self.userCollectionView.backgroundColor = JRColor(230, 230, 230);
    self.userCollectionView.backgroundColor = [UIColor whiteColor];
    self.userCollectionView.alwaysBounceVertical = YES;
}


- (void)initHeaderView{

    TeacherHeaderView *header = [TeacherHeaderView loadFromNib];
    [self.view addSubview:header];
    
    header.callback = ^(NSInteger tag){
        if (tag == 1) {
            
            ChooseSemesterCustomView *chooseView = [[ChooseSemesterCustomView alloc]initWithFrame:self.navigationController.view.bounds];
            chooseView.semesterArr = self.semesterArr;
            chooseView.select = [self.selectSemesterId integerValue];
            [chooseView createUI];
            [self.navigationController.view addSubview:chooseView];
            
            __weak typeof(self) weakSelf = self;
            chooseView.chooseBlock = ^(NSString *semesterId, NSString *idStr){
                
                weakSelf.selectSemesterId = idStr;
                weakSelf.semesterId = semesterId;
                [self getClassListDataProfessionId:weakSelf.professionId semesterId:semesterId];
            };
            
        }
        
        if (tag == 2) {
            
            ChooseProfessionalCustomView *chooseView = [[ChooseProfessionalCustomView alloc]initWithFrame:self.navigationController.view.bounds];
            chooseView.professionalArr = self.professionalArr;
            chooseView.select = [self.selectProfessionId integerValue];
            [chooseView createUI];
            [self.navigationController.view addSubview:chooseView];
            
            __weak typeof(self) weakSelf = self;
            chooseView.chooseBlock = ^(NSString *professionId, NSString *idStr){
                
                weakSelf.selectProfessionId = idStr;
                weakSelf.professionId = professionId;
                [self getClassListDataProfessionId:professionId semesterId:weakSelf.semesterId];
            };
            
        }
        
    };
}

- (void)getDataSource {
    // 可以全部提前缓存 直接调用
    // 学期列表
    [YMHApiManager getSemesterListSuccess:^(id response) {
        if (response == nil) {
            return ;
        }
        self.semesterArr = [NSMutableArray arrayWithArray:response];
        SemesterModel *m = [[SemesterModel alloc]init];
        m.semesterName = @"所有";
        m.semesterId = @"";
        [self.semesterArr insertObject:m atIndex:0];
    } fail:^(NSString *msg) {
        
    }];
    
    // 专业名称
    [YMHApiManager getProfessionWithProfessionId:@"" Success:^(id response) {
        
        if (response == nil) {
            return ;
        }
        
        self.professionalArr = [NSMutableArray arrayWithArray:response];
        ProfessionModel *m = [[ProfessionModel alloc]init];
        m.professionalName = @"所有";
        m.professionalId = @"";
        [self.professionalArr insertObject:m atIndex:0];
    } fail:^(NSString *msg) {
        
    }];
    
    // 班级列表 应该是全部的啊啊
    [self getClassListDataProfessionId:@"" semesterId:@""];
}

- (void)updateUI {

    [self getClassListDataProfessionId:self.professionId semesterId:self.semesterId];
    
}

- (void)getClassListDataProfessionId:(NSString*)professionId semesterId:(NSString*)semesterId {

    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [YMHApiManager getClassListWithEmployeeId:[UserDefaultsHelper getUid] professionId:professionId semesterId:semesterId Success:^(id response) {
        if (![response isKindOfClass:[NSString class]]) {
            self.classList = [NSMutableArray arrayWithArray:response];
        }else{
            self.classList = nil;
        }
        
        [self.userCollectionView reloadData];
        [SVProgressHUD dismiss];
        
    } fail:^(NSString *msg) {
        [SVProgressHUD showInfoWithStatus:msg];
        self.classList = (NSMutableArray*)[[LocalData shareLocalData]queryAllClassListData];
        [self.userCollectionView reloadData];
    }];
}

- (void)addRefresh {
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [YMHApiManager getClassListWithEmployeeId:[UserDefaultsHelper getUid] professionId:weakSelf.professionId semesterId:weakSelf.semesterId Success:^(id response) {
            if (![response isKindOfClass:[NSString class]]) {
                [self.classList removeAllObjects];
                self.classList = [NSMutableArray arrayWithArray:response];
            }else{
                self.classList = nil;
            }
           
            [weakSelf.userCollectionView reloadData];
            [weakSelf.userCollectionView.mj_header endRefreshing];
        } fail:^(NSString *msg) {
            [weakSelf.userCollectionView.mj_header endRefreshing];
            
            [SVProgressHUD showInfoWithStatus:msg];
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
    self.userCollectionView.mj_header = header;
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = {self.view.frame.size.width,60};
    return size;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    ClassHeaderView *header = header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier forIndexPath:indexPath];
    
    
    ClassModel *model = self.classList[indexPath.section];
    header.model = model;
    header.expandCallback = ^(BOOL isExpanded) {
        
        // 动画在这里 刷新某一个section  0 1 2 ...
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        
    };
    return header;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.classList.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    ClassModel *model = self.classList[section];

    return model.isExpanded ? model.studentCount : 0;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StudentsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentfier forIndexPath:indexPath];
    
    ClassModel *model = self.classList[indexPath.section];
    StudentModel *model1 = model.studentList[indexPath.item];
    cell.model = model1;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    MyselfViewController *VC = [[MyselfViewController alloc]init];
    ClassModel *model = self.classList[indexPath.section];
    VC.classId = model.classID;
    StudentModel *model1 = model.studentList[indexPath.item];
    VC.studentId = model1.studentId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)dealloc {

    [kNotificationCenter removeObserver:self name:@"UpdateHomeViewController" object:nil];
}

@end
