//
//  ArticleEditArticleViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "ArticleEditViewController.h"

#import "InputViewController.h"
#import "InputTextViewController.h"
#import "CategoryViewController.h"

#import "XYDatePickerView.h"

#import "WorksModel.h"

#import "CategoryModel.h"

#import "UIView+RXProgressCover.h"
#import "ImagePickerHelper.h"

#import "MyselfViewController.h"
@interface ArticleEditViewController ()<UITableViewDelegate, UITableViewDataSource, InputViewDelegate, InputTextViewDelegate, CategoryViewDelegate> {
    
    NSString          *_categoryName;
    NSString          *_categoryCid;
    NSTimer           *_loadTimer;
    CGFloat           _height;
    BOOL              _isOpen;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XYButton *delButton;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *categoryNameArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *cidArr;

@end

@implementation ArticleEditViewController

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (NSMutableArray *)categoryNameArray {
    if (!_categoryNameArray) {
        _categoryNameArray = [NSMutableArray array];
    }
    return _categoryNameArray;
}

- (void)getDataSource {
    
    [YMHApiManager getCategoryByImageId:self.model.imageId success:^(id response) {
        
        [self.categoryNameArray addObjectsFromArray:response];
        
        NSMutableArray *arr = [NSMutableArray array];
        _cidArr = [NSMutableArray array];
        for (CategoryModel *model in _categoryNameArray) {
            [arr addObject:model.categoryName];
            [_cidArr addObject:model.cid];
        }
        _categoryName = [arr componentsJoinedByString:@"/"];
        _categoryCid = [_cidArr componentsJoinedByString:@","];
        
        // 这里缓存是必须的
        [self getCategoryList];
        
        [self.tableView reloadData];
        
    } fail:^(NSString *msg) {
        //
        _categoryCid = @"123";
    }];
}

- (void)getCategoryList {
    
        [YMHApiManager getCategoryListSuccess:^(id response) {
    
            NSArray * arr = [NSArray arrayWithArray:response];
           
                for (CategoryModel *model in arr) {
                    if ([_cidArr containsObject:model.cid]) {
                        model.selected = YES;
                    }else {
                        model.selected = NO;
                    }
                }
            
            self.categoryArray = [NSMutableArray arrayWithArray:arr];
            
        } fail:^(NSString *msg) {
            
        }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    [self initUI];
    [self initTableView];
    
    [self getDataSource];
    
    [self getCategoryList];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self dismissPickerView];
}

#pragma mark - 

- (void)initNav {
    
    self.delButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 16, 22)];
    if (_type == ArticleTypeEdit) {
        [self.delButton setImage:[UIImage imageNamed:@"icon_nav_delect"] forState:UIControlStateNormal];
    } else if (_type == ArticleTypeAdd) {
        self.delButton.frame = CGRectMake(0, 0, 40, 22);
        [self.delButton setTitle:@"保存" forState:UIControlStateNormal];
        [self.delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    [self.delButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.delButton];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor clearColor];
    
    if (_type == ArticleTypeEdit) {
        self.title = @"编辑作品";
    } else if (_type == ArticleTypeAdd) {
        self.title = @"添加作品";
        self.model = [[WorksModel alloc]init]; // 初始化
        self.model.stuIsPublic = 1;
        self.model.classId = _classId;
        [self uploadImage];
    }
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 254)];
    self.imageView = [[UIImageView alloc]initWithFrame:header.frame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit; // 原始比例尺寸填充 UIViewContentModeScaleAspectFill;//
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.image = self.image;
    [header addSubview:self.imageView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 254, MAIN_SCREEN_WIDTH, 6)];
    line.backgroundColor = BackgroundColor;
    [header addSubview:line];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getImage:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tapGes];
    
    self.tableView.tableHeaderView = header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"作品名称";
            cell.detailTextLabel.text = self.model.title;
            if ([NSString isNull:self.model.title]) {
               cell.detailTextLabel.text = @"未填写";
            }
        }
            break;
            
        case 1:{
            cell.textLabel.text = @"作品类别";
            cell.detailTextLabel.text = _categoryName;
            if ([NSString isNull:_categoryName]) {
               cell.detailTextLabel.text = @"最多选择3个类型标签";
            }
        }
            break;
            
        case 2:{
            cell.textLabel.text = @"创作时间";
            cell.detailTextLabel.text = [self.model.createDate substringToIndex:10];
            if ([NSString isNull:self.model.createDate]) {
                cell.detailTextLabel.text = @"未填写";
            }
        }
            break;
            
        case 3:{
            cell.textLabel.text = @"是否公开";
            UISwitch *tipSwitch = [[UISwitch alloc]init];
            if (self.model.stuIsPublic) {
                tipSwitch.on = YES;
            } else {
                tipSwitch.on = NO;
            }
            
            [tipSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = tipSwitch;
        }
            break;
            
        case 4:{
            cell.textLabel.text = @"作品描述  ";
            cell.detailTextLabel.text = self.model.describe;
            if ([NSString isNull:self.model.describe]) {
                cell.detailTextLabel.text = @"未填写";
            }
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;  //自动折行
            cell.detailTextLabel.textAlignment = NSTextAlignmentLeft; // 多行右对齐
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        
        CGSize detialSize = [CommonHelper sizeWithText:self.model.describe font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(MAIN_SCREEN_WIDTH - 135 , 900)];//32
        if (detialSize.height < 33.41) {
            _height = 16.7 + 10 + 18;
            return _height;
        }
        _height = detialSize.height + 10 + 18;
    
        return _height;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            [self editArticleTitle];
        }
            break;
        case 1:{
            [self editArticleCategory];
        }
            break;
        case 2:{
            [self showPickerView];
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            [self editArticleDescribe];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -

- (void)editArticleTitle {
    
    InputViewController *VC = [[InputViewController alloc]init];
    VC.categoryCid = _categoryCid;
    VC.model = self.model;
    VC.delegate = self;
    
    if (_type == ArticleTypeEdit) {
        VC.textEditType = ArticleTypeEdit;
    } else if (_type == ArticleTypeAdd) {
        VC.textEditType = ArticleTypeAdd;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)editArticleDescribe {
    
    InputTextViewController *VC = [[InputTextViewController alloc]init];
    VC.categoryCid = _categoryCid;
    VC.model = self.model;
    VC.delegate = self;
    
    if (_type == ArticleTypeEdit) {
        VC.textViewEditType = ArticleTypeEdit;
    } else if (_type == ArticleTypeAdd) {
        VC.textViewEditType = ArticleTypeAdd;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 作品是否公开

- (void)switchAction:(UISwitch *)sender {
    
   // BOOL isOn = sender.isOn;
    // 编辑作品
    if (_type == ArticleTypeEdit) {
       [self editArticle];
    } else {
       
    }
    
}

#pragma mark - 编辑作品类型
- (void)editArticleCategory {
    CategoryViewController *VC = [[CategoryViewController alloc]init];
    VC.array = self.categoryArray;
    VC.model = self.model;
    VC.delegate = self;
    if (_type == ArticleTypeEdit) {
        VC.categoryType = CategoryTypeEdit;
    } else {
       VC.categoryType = CategoryTypeAdd;
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - DatePicker

- (void)showPickerView {
    
    [XYDatePickerView showInView:self.view andSelectDateCompleteHander:^(NSString *selectDate, NSString *tag) {
        
        if ([tag isEqualToString:@"1"]) {
            
            self.model.createDate = selectDate;
            
            if (_type == ArticleTypeEdit) {
                [self editArticle];
            }else {
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)dismissPickerView {
    [[XYDatePickerView shareInstance]dismissDatePiker];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    [self dismissPickerView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self dismissPickerView];
}


#pragma mark -

- (void)getImage:(UITapGestureRecognizer *)ges {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重新上传作品" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
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
    self.image = image;
    [self uploadImage];
}

- (void)uploadImage{
    
    [YMHApiManager uploadImageWithImage:self.image type:0 progress:^(float progress){
        // 上传动画
        CGFloat rate = 0.0; //self.imageView.rate;
        rate = progress/100;
        self.imageView.rate = rate;
        if (rate >= 1.0) {
            [self.imageView removeProgressCover:YES];
        }
    } success:^(id response) {
        self.imageView.image = self.image; // 上传完成后再显示
        NSString *path = response;
        self.model.imagePath = path; // 上传图片成功返回路径
        
        if (_type == ArticleTypeEdit) {
            [self editArticle];
        }
        
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

#pragma mark - 作品类型回调类型

- (void)saveArticleCategory:(NSArray *)array {
    NSMutableArray *nameArr = [NSMutableArray array];
    NSMutableArray *cidArr = [NSMutableArray array];
    for (CategoryModel *model in array) {
        [nameArr addObject:model.categoryName];
        [cidArr addObject:model.cid];
    }
    _categoryName = [nameArr componentsJoinedByString:@"/"];
    _categoryCid = [cidArr componentsJoinedByString:@","];
    
    if (_type == ArticleTypeEdit) {
        [self editArticle];
    } else {
        [self.tableView reloadData];
    }

}


#pragma mark - 作品名称

- (void)saveArticleTitleMessage:(NSString *)message tag:(NSString *)tag {
    
    self.model.title = message;
    [self.tableView reloadData];
}

#pragma - 作品描述

- (void)saveArticleDesribeMessage:(NSString *)message tag:(NSString *)tag {
    
    self.model.describe = message;
    [self.tableView reloadData];
}

- (void)editArticle {
    
    // 编辑作品
    [SVProgressHUD showWithStatus:@"正在修改..."];
    _loadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(loadDataFailured) userInfo:nil repeats:NO];
    
    [YMHApiManager editArticleWithWorksModel:self.model categoryId:_categoryCid success:^(id response) {
        [SVProgressHUD dismiss];
        [_loadTimer invalidate];
        
        [SVProgressHUD showSuccessWithStatus:@"完成"];
        [self.tableView reloadData];
        
    } fail:^(NSString *msg) {
        [_loadTimer invalidate];
        [SVProgressHUD dismiss];
    }];
    
}

- (void)addArticle {
    
    if ([NSString isNull:self.model.title]) {
        [self showMessage:@"请输入作品名称"];
        return;
    }
    if ([NSString isNull:self.model.createDate]) {
        [self showMessage:@"请输入作品创作时间"];
    }
    if ([NSString isNull:_categoryName]) {
        [self showMessage:@"请选择作品类型"];
        return;
    }
    
    // 添加作品
    if (self.model.imagePath == nil) {
        [SVProgressHUD showWithStatus:@"作品正在上传..."];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在添加..."];
    _loadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(loadDataFailured) userInfo:nil repeats:NO];
    
    [YMHApiManager addArticleWithWorksModel:self.model categoryId:_categoryCid success:^(id response) {
        [_loadTimer invalidate];
        
        UIViewController *vc = self.navigationController.viewControllers[1];
        
        [self.navigationController popToViewController:vc animated:YES];
        
        //通知首页更新数据
//        [kNotificationCenter postNotificationName:@"UpdateHomeViewController" object:nil];
        
    } fail:^(NSString *msg) {
        [_loadTimer invalidate];
        [SVProgressHUD showInfoWithStatus:msg];
    }];
    
}

- (void)deleteArticle {
    
    [YMHApiManager deltArticleWithImageId:self.model.imageId success:^(id response) {
        
        [SVProgressHUD showSuccessWithStatus:@"完成"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } fail:^(NSString *msg) {
        [SVProgressHUD showInfoWithStatus:@"删除失败"];
    }];
}

#pragma mark - private method

-(void)moreAction {
    
    if (_type == ArticleTypeEdit) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否删除该作品？" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除作品" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self deleteArticle];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if (_type == ArticleTypeAdd) {
        
        [self addArticle];
    }
}

#pragma mark -

- (void)showMessage:(NSString *)message {
    [SVProgressHUD showInfoWithStatus:message];
}

- (void)loadDataFailured {
    [_loadTimer invalidate];
    _loadTimer = nil;
    [SVProgressHUD dismiss];
}

- (void)dealloc {
    [_loadTimer invalidate];
    _loadTimer = nil;
}

@end
