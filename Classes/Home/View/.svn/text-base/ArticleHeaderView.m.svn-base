//
//  XYDetailHeaderView.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/25.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "ArticleHeaderView.h"

#import "ArticleHeaderViewModel.h"
#import "WorksModel.h"
#import "UILabel+XYAdd.h"
@interface ArticleHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *seizeLabel;
@property (nonatomic, strong) UILabel *detialLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation ArticleHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:@"#feffff"];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.layer.cornerRadius = 6;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        self.shareBtn = [[UIButton alloc]init];
        [self.shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:self.titleLabel];
        
        self.detialLabel = [[UILabel alloc]init];
        self.detialLabel.textColor = [UIColor colorWithHex:@"#595757"];
        self.detialLabel.numberOfLines = 0;
        self.detialLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:self.detialLabel];
        
//        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.textColor = [UIColor blackColor];
//        self.nameLabel.font = [UIFont systemFontOfSize:14.0];
//        [self addSubview:self.nameLabel];
        
//        self.iconImageView = [[UIImageView alloc]init];
//        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.iconImageView.layer.cornerRadius = 12;
//        self.iconImageView.layer.borderWidth = 0.5;
//        self.iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.iconImageView.layer.masksToBounds = YES;
//        [self addSubview:self.iconImageView];
        
        self.line1 = [[UIView alloc]init];
        self.line1.backgroundColor = SeparatorLineColor;
        [self addSubview:self.line1];
        
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.text = @"相似作品";
        self.tipLabel.textColor = [UIColor colorWithHex:@"#595757"];;
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.backgroundColor = BackgroundColor;
        self.tipLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.tipLabel];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap1];
        
//        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUserInfo:)];
//        self.nameLabel.userInteractionEnabled = YES;
//        [self.nameLabel addGestureRecognizer:tap2];
        
    }
    return self;
}

- (void)setViewModel:(ArticleHeaderViewModel *)viewModel {
    
    _viewModel = viewModel;
    
    NSString *time = [_viewModel.works.createDate substringToIndex:10];
    time = [time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@  %@  %@",_viewModel.works.title,_viewModel.works.studentName,time];
    
    [self.detialLabel setText:_viewModel.works.describe lineSpacing:3];

//    self.nameLabel.text = _viewModel.work.name;
    
    
    NSString *imageStr = nil;
    if ([NSString isNull:_viewModel.works.thumbnailImagePath]) {
        imageStr = [NSString stringWithFormat:@"%@%@",imageBaseUrl,_viewModel.works.imagePath];
    } else {
        imageStr = [NSString stringWithFormat:@"%@%@",imageBaseUrl,_viewModel.works.thumbnailImagePath];
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[imageStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
    
    
//    NSString *iconStr = [NSString stringWithFormat:@"%@%@",imageBaseUrl,_viewModel.work.headImagePath];
//    // 默认是圆形的 有效 可以解决
//    // [self.iconImageView setHeaderWithURL:[iconStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[iconStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:kPlaceholderUserImage];
    
    // 图片
    self.imageView.frame = _viewModel.imageF;
    
    // 分享
    self.shareBtn.frame = _viewModel.shareF;
    
    // 标题
    self.titleLabel.frame = _viewModel.titleF;
    
    // 作品详情
    self.detialLabel.frame = _viewModel.detailF;
    
    // 分割线
    self.line1.frame = _viewModel.line1F;
    
//    self.iconImageView.frame = _viewModel.iconF;
    
//    self.nameLabel.frame = _viewModel.nameF;
    
    self.tipLabel.frame = _viewModel.tipF;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - 

- (void)showBigImage:(UITapGestureRecognizer *)tap {
    if (self.SelectHeaderCompleteHandler) {
        self.SelectHeaderCompleteHandler(1);
    }
}

- (void)showUserInfo:(UITapGestureRecognizer *)tap {
    if (self.SelectHeaderCompleteHandler) {
        self.SelectHeaderCompleteHandler(2);
    }
}

- (void)share {
    if (self.SelectHeaderCompleteHandler) {
        self.SelectHeaderCompleteHandler(3);
    }
}

@end
