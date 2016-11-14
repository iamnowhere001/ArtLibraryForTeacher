//
//  LoginViewController.m
//  ArtLibraryForTeacher
//
//  Created by iamnowhere on 16/8/15.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UITextField *userName;
@property(nonatomic,weak)UITextField *passWord;

@end

@implementation LoginViewController
-(instancetype)init{
    
    if (self = [super init]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JRColor(238, 238, 238);
    // 1.添加输入框
    [self setTextField];
    
    // 2.添加登陆按钮
    [self setLoginButton];
    
    // 2.添加登陆图片
    [self setLogoImage];
    
    
}

/**
 * 添加登陆按钮
 */
-(void)setLoginButton{
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.passWord.y + 60, self.passWord.width, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = JRColor(0, 156, 216);
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    loginBtn.layer.cornerRadius = 5;
    
}
/**
 *  点击登陆
 *
 */

-(void)login{
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    if (self.userName.text.length == 0 || self.passWord.text.length == 0) {
        if (self.userName.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        }else{
            [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        }
        return;
    }else{
        [self sendPostRequest];
    }
}

/**
 *  发送网络请求
 */
-(void)sendPostRequest{
    
    //发送网络请求
    [SVProgressHUD showWithStatus:@"正在登录"];
    
    
    
    [YMHApiManager loginOfTeacherWithName:self.userName.text pwd:self.passWord.text success:^(id response) {
        [[LocalData shareLocalData]createDatabase];
                
        [self performSelectorOnMainThread:@selector(returnOnMainThreda) withObject:nil waitUntilDone:NO];
        
    } fail:^(NSString *msg) {
        [SVProgressHUD showInfoWithStatus:@"登录失败"];
    }];
    
}

-(void)returnOnMainThreda{
    
    [UIView transitionWithView:[[UIApplication sharedApplication].delegate window]
                      duration:1
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        BOOL oldState=[UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        [[[UIApplication sharedApplication].delegate window]setRootViewController:[[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]]];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:NULL];
}

/**
 * 添加logo图片
 */
-(void)setLogoImage{
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.width = 190;
    logoImageView.height = 160;
    
    logoImageView.x = self.view.centerX - logoImageView.width/2;
    
    if ([UIScreen mainScreen].bounds.size.height > 480) {
        logoImageView.y = self.view.centerY - 230;
    }else{
        
        logoImageView.y = self.view.centerY - 200;
    }
    
    logoImageView.backgroundColor = [UIColor clearColor];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageView];
}

/**
 * 添加输入框
 */

-(void)setTextField{
    
    // 1.用户名
    UITextField *userName = [[UITextField alloc]initWithFrame:CGRectMake(20, self.view.centerY+20, self.view.frame.size.width-40, 40)];
    [userName setBorderStyle:UITextBorderStyleRoundedRect];
    userName.placeholder = @"用户名";
    userName.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userName.returnKeyType = UIReturnKeyDone;  //键盘返回类型
    userName.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    userName.delegate = self;
    userName.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //设置居中输入
    [self.view addSubview:userName];
    self.userName = userName;
    
    // 2.密码
    UITextField *passWord = [[UITextField alloc]initWithFrame:CGRectMake(20, userName.y+60, userName.width, 40)];
    [passWord setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    passWord.placeholder = @"密码"; //默认显示的字
    passWord.secureTextEntry = YES; //密码类型
    passWord.autocorrectionType = UITextAutocorrectionTypeNo;
    passWord.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passWord.returnKeyType = UIReturnKeySend;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    passWord.delegate = self;
    passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:passWord];
    self.passWord = passWord;
    
    if (![[UserDefaultsHelper getUserName] isNull]) {
        self.userName.text = [UserDefaultsHelper getUserName];
    }
    if (![[UserDefaultsHelper getPassword] isNull]) {
        self.passWord.text = [UserDefaultsHelper getPassword];
    }
    // 3.监听键盘的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]+0.2;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        if ([UIScreen mainScreen].bounds.size.height > 480) {
            self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height + 100);
        }else{
            self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height + 60);
        }
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.userName.text.length != 0 && self.passWord.text.length != 0) {
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
}
/**
 * 取消第一响应
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}



@end
