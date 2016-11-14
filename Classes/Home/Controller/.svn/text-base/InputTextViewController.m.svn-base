//
//  InputTextViewController.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "InputTextViewController.h"
#import "WorksModel.h"

#import "UITextView+XYAdd.h"

@interface InputTextViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) XYButton *sureButton;

@end

@implementation InputTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作品简介";
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    [self initNav];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [kNotificationCenter addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:self.textView];
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

#pragma mark -

- (void)initUI {
    
    self.textView.text = self.model.describe;
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.textView becomeFirstResponder];
    
    self.label.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)self.model.describe.length];
}

#pragma mark - 

- (void)textViewDidChangeText:(NSNotification *)notification {
    
    self.sureButton.userInteractionEnabled = YES;
    [self.sureButton setTitleColor:[UIColor colorWithHex:@"#0098e1"] forState:UIControlStateNormal];
    
    // 限制文本输入长度
    [UITextView setTextLength:500 notify:notification];
    
    // 使用KVO
    self.label.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)self.textView.text.length];
}

#pragma mark -

- (void)cancel {
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sure {
    [self.view endEditing:YES];
    
    if (_textViewEditType == TextEditViewTypeEdit) {
        // 编辑作品
        [SVProgressHUD showWithStatus:@"正在修改..."];
        
        [YMHApiManager editArticleWithWorksModel:self.model categoryId:_categoryCid success:^(id response) {
            
            [SVProgressHUD showSuccessWithStatus:@"完成"];
            // 回调
            if ([self.delegate respondsToSelector:@selector(saveArticleDesribeMessage:tag:)]) {
                [self.delegate saveArticleDesribeMessage:self.textView.text tag:@"0"];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSString *msg) {
            [SVProgressHUD dismiss];
        }];
        
    } else {
        if ([self.delegate respondsToSelector:@selector(saveArticleDesribeMessage:tag:)]) {
            [self.delegate saveArticleDesribeMessage:self.textView.text tag:@"0"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self];
}

@end
