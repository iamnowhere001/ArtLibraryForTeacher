//
//  UserInfoView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/26.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UserInfoView.h"

#import "StudentInfoModel.h"
#import "StudentInfoViewModel.h"
#import "ZFAvatarBrowser.h"
#import "UILabel+XYAdd.h"
@interface UserInfoView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *tagLabel2;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UILabel *detialLabel;

@property (nonatomic, strong) UIView *line2;

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, strong) XYButton *resumeButton;

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.isOpen = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; // 有裁剪
        self.imageView.layer.cornerRadius = 50;
        self.imageView.layer.borderWidth = 0.5;
        self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:18];//XYFont(20);//
        [self addSubview:self.nameLabel];
        
        self.tagLabel = [[UILabel alloc]init];
        self.tagLabel.text = @"作品集";
        self.tagLabel.font = [UIFont systemFontOfSize:24];
        self.tagLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.tagLabel];
        
        self.infoLabel = [[UILabel alloc]init];
        self.infoLabel.textColor = [UIColor darkGrayColor];
        self.infoLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.infoLabel];
        
        self.line2 = [[UIView alloc]init];
        self.line2.backgroundColor = BackgroundColor;
        [self addSubview:self.line2];
        
        self.tagLabel2 = [[UILabel alloc]init];
        self.tagLabel2.text = @"艺术履历";
        self.tagLabel2.font = [UIFont systemFontOfSize:12];
        self.tagLabel2.textColor = [UIColor lightGrayColor];
        [self addSubview:self.tagLabel2];
        
        self.detialLabel = [[UILabel alloc]init];
        self.detialLabel.textColor = TextColor;
        self.detialLabel.font = [UIFont systemFontOfSize:14];//14
        self.detialLabel.numberOfLines = 0; //2; //默认2行 展开 无限多
        [self addSubview:self.detialLabel];
        
        self.resumeButton = [[XYButton alloc]init];
        [self.resumeButton setImage:[UIImage imageNamed:@"icon_resume"] forState:UIControlStateNormal];
        [self addSubview:self.resumeButton];
        
        [self.resumeButton addTarget:self action:@selector(resumes) forControlEvents:UIControlEventTouchUpInside];
        
        // 查看大图
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setViewModel:(StudentInfoViewModel *)viewModel {
    _viewModel = viewModel;
    
    // 用户姓名
    self.nameLabel.text = _viewModel.userInfo.studentName;
    
    long age = 0;
    if ([NSString isNull:_viewModel.userInfo.birthday]) {
        
    } else {
        age = [[[NSDate getTime] substringToIndex:4]integerValue] - [[_viewModel.userInfo.birthday substringToIndex:4]integerValue];
    }
    
    // 详细信息 年龄 地址
    self.infoLabel.text = [NSString stringWithFormat:@"%ld岁, %@",age,_viewModel.userInfo.permCity];
    
    if (![NSString isNull:_viewModel.userInfo.resumes]) {
        [self.detialLabel setText:_viewModel.userInfo.resumes lineSpacing:2.5];
    }
    
    NSString *iconStr = @"http://img.ymm.cn/Head/100176990/20140929//1efd788408ac495a9e974f442ef7dd4d.jpg";//[NSString stringWithFormat:@"%@%@",imageBaseUrlPath,_viewModel.userInfo.headImage];
    
    // 用户头像
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[iconStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:kPlaceholderUserImage];
    
    
    
    // 设置frame
    self.imageView.frame = _viewModel.imageF;
    
    self.nameLabel.frame = _viewModel.nameF;
    
    self.tagLabel.frame = _viewModel.tagF;
    
    self.infoLabel.frame = _viewModel.infoF;
    
    self.resumeButton.frame = _viewModel.resumeF;
    
    self.line2.frame = _viewModel.line2F;
    
    self.tagLabel2.frame = _viewModel.tag2F;
    
    self.detialLabel.frame = _viewModel.detailF;
    
}

#pragma mark -
- (void)showImage:(UITapGestureRecognizer *)tap {
    // 点击头像放大 大图预览
    [ZFAvatarBrowser showImage:self.imageView];
}
- (void)resumes {
    
    if (self.headerButtonClickedBlock) {
        self.headerButtonClickedBlock(1,0);
    }
    
}
@end
