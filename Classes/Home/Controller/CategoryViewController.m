//
//  CategoryViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/25.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "CategoryViewController.h"
#import "WorksModel.h"

#import "CategoryModel.h"
#import "SelectedCell.h"

static NSString *kCellIdentfier = @"XYSelectedCell";

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSTimer           *_loadTimer;
}

@property (nonatomic, strong) XYButton *sureButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, assign) int totalCount; // 3

@end

@implementation CategoryViewController

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    
    self.categoryArray = [NSMutableArray arrayWithArray:array];
    for (CategoryModel *model in self.categoryArray) {
        if (model.selected) {
            [self.selectArray addObject:model];
        }
    }
    
    [self getCategoryname];
}

- (void)getCategoryname {
    
    NSMutableArray *cidArr = [NSMutableArray array];
    for (CategoryModel *model in self.selectArray) {
        [cidArr addObject:model.categoryName];
    }
    _categoryname = [cidArr componentsJoinedByString:@"/"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择作品类别";
    
    [self initNav];
    [self initTableView];
}

#pragma mark -

- (void)initNav {
    
    XYButton *cancelButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 40, 21)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    self.sureButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 40, 21)];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
   // self.sureButton.userInteractionEnabled = NO;
   // [self.sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.sureButton];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[SelectedCell class] forCellReuseIdentifier:kCellIdentfier];
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        return self.categoryArray.count;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString  *CellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        //
        cell.textLabel.text = _categoryname;
        cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:141/255.0 blue:220/255.0 alpha:1.0];
        
//        XYButton *btn = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
//        [btn sizeToFit];
//        [btn setImage:[UIImage imageNamed:@"icon_del3"] forState:UIControlStateNormal];
//        cell.accessoryView = btn;
//        [btn addTarget:self action:@selector(del3:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    } else {
        
        SelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentfier];
        CategoryModel *model = self.categoryArray[indexPath.row];
        
        cell.textLabel.text = model.categoryName;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        if (model.selected) {
            cell.imageView.image = [UIImage imageNamed:@"icon_select_done"];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"icon_select_nor"];
        }
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1) {
        
        CategoryModel *model = self.categoryArray[indexPath.row];
        
        if (self.selectArray.count == 3) {
            
            if (model.selected) { // 取消选中状态
                model.selected = NO;
            }else {
                [SVProgressHUD showInfoWithStatus:@"最多选择3个类型标签"];
            }
            
        } else {
            model.selected = !model.selected;
        }
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        
        if (model.selected) {
            [self.selectArray addObject:model];
        } else {
            [self.selectArray removeObject:model];
        }
        
        
        [self getCategoryname];
        //[self.header setSelectTagS:self.selectArray];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 50;
    }
    
    return 44;
}

#pragma mark -

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sure {
    
    if (self.selectArray.count == 0) {
        return;
    }
    
    if (_categoryType == CategoryTypeEdit) {
        
        NSMutableArray *cidArr = [NSMutableArray array];
        for (CategoryModel *model in self.selectArray) {
            [cidArr addObject:model.cid];
        }
        _categoryCid = [cidArr componentsJoinedByString:@","];
        
        _loadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(loadDataFailured) userInfo:nil repeats:NO];
        [SVProgressHUD showWithStatus:@"正在修改..."];
        
        [YMHApiManager editArticleWithWorksModel:self.model categoryId:_categoryCid success:^(id response) {
            [SVProgressHUD dismiss];
            [_loadTimer invalidate];
            
            [SVProgressHUD showSuccessWithStatus:@"完成"];
            // 回调
            if ([self.delegate respondsToSelector:@selector(saveArticleCategory:)]) {
                [self.delegate saveArticleCategory:self.selectArray];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } fail:^(NSString *msg) {
            [_loadTimer invalidate];
            [SVProgressHUD dismiss];
        }];

    }else {
        // 回调
        if ([self.delegate respondsToSelector:@selector(saveArticleCategory:)]) {
            [self.delegate saveArticleCategory:self.selectArray];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)del3:(UIButton *)sender {
    
    
}

- (void)loadDataFailured {
    [_loadTimer invalidate];
    _loadTimer = nil;
    [SVProgressHUD dismiss];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_loadTimer invalidate];
    _loadTimer = nil;
}


@end
