//
//  InputViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "InputViewController.h"
#import "WorksModel.h"

#import "UITextField+XYAdd.h"

@interface InputViewController (){
    NSTimer  *_loadTimer;
}

@property (nonatomic, strong) XYButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"作品名称";
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    [self initNav];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [kNotificationCenter addObserver:self selector:@selector(textFieldDidChangeText:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

#pragma mark -

- (void)initNav {
    
    XYButton *cancelButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 40, 21)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    self.sureButton = [[XYButton alloc]initWithFrame:CGRectMake(0, 0, 40, 21)];
    [self.sureButton setTitle:@"保存" forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.sureButton.userInteractionEnabled = NO;
    [self.sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.sureButton];
}

- (void)initUI {
    
    self.textField.text = self.model.title;
    self.textField.font = [UIFont systemFontOfSize:15];
    [self.textField becomeFirstResponder];
    
    self.label.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.model.title.length];
}

#pragma mark -

- (void)textFieldDidChangeText:(NSNotification *)notification {
    
    self.sureButton.userInteractionEnabled = YES;
    [self.sureButton setTitleColor:[UIColor colorWithHex:@"#0098e1"] forState:UIControlStateNormal];
    
    // 最大输入长度15字符
    [UITextField setTextLength:15 notify:notification];
    self.label.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.textField.text.length];
}

#pragma mark -

- (void)cancel {
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sure {
    [self.view endEditing:YES];
    
    if ([NSString isNull:_textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入作品名称"];
        return;
    }
    
    if (_textEditType == TextEditTypeEdit) {
        // 编辑作品名称
        
        _loadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(loadDataFailured) userInfo:nil repeats:NO];
        [SVProgressHUD showWithStatus:@"正在修改..."];
        
        [YMHApiManager editArticleWithWorksModel:self.model categoryId:_categoryCid success:^(id response) {

            [_loadTimer invalidate];
            
            [SVProgressHUD showSuccessWithStatus:@"完成"];
            // 回调
            if ([self.delegate respondsToSelector:@selector(saveArticleTitleMessage:tag:)]) {
                [self.delegate saveArticleTitleMessage:self.textField.text tag:@"0"];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSString *msg) {
            [_loadTimer invalidate];
            [SVProgressHUD dismiss];
        }];
        
    } else {
        // 添加作品名称
        
        if ([self.delegate respondsToSelector:@selector(saveArticleTitleMessage:tag:)]) {
            [self.delegate saveArticleTitleMessage:self.textField.text tag:@"0"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

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
