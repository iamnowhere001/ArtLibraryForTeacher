//
//  ArticleView.m
//  ArtLibrary
//
//  Created by JRuser on 16/5/31.
//  Copyright © 2016年 JRuser. All rights reserved.
//

#import "ArticleView.h"
#import "WorksModel.h"
#import "ZFAvatarBrowser.h"
#import "XYActionSheet.h"
@interface ArticleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detialLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, weak) UIView *line1; // 分割线
@property (nonatomic, weak) UIView *line2;

//
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *sImgView;

@end

@implementation ArticleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc]init];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:self.titleLabel];
        
        self.detialLabel = [[UILabel alloc]init];
        self.detialLabel.textColor = TextColor;
        self.detialLabel.numberOfLines = 0;
        self.detialLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.detialLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = TextColor;
        self.timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.timeLabel];
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = SeparatorLineColor;
        [self addSubview:line1];
        self.line1 = line1;
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = SeparatorLineColor;
        [self addSubview:line2];
        self.line2 = line2;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap1];
        
        [self initScrollView];
    }
    return self;
}

- (void)setWorks:(WorksModel *)works {
    _works = works;
    
    self.titleLabel.text = works.title;
    self.detialLabel.text = works.describe;
    NSString *time = [works.createDate substringToIndex:10];
    self.timeLabel.text = [NSString stringWithFormat:@"创作时间:%@",time];
    
    NSString *imageStr = [works.imagePath componentsSeparatedByString:@"|"][0];
    NSString *imagepath = nil;
    if (!imageStr) {
        imagepath = [NSString stringWithFormat:@"%@%@",imageBaseUrlPath,works.thumbnailDeatialImagePath];
    }else{
    
        imagepath = [NSString stringWithFormat:@"%@%@",imageBaseUrlPath,imageStr];
    }
    
    self.imageView.backgroundColor = [UIColor brownColor];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[imagepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
   
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat imageW = MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2;
    CGFloat imageH = imageW * _works.heigth / _works.width;
    
    self.imageView.frame = CGRectMake(BigCellLeftMargin, 8, imageW, imageH);
    self.imageView.layer.cornerRadius = 6;
    self.imageView.layer.masksToBounds = YES;
    
    self.titleLabel.frame = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(self.imageView.frame) + 10, MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2, 20);
    
    self.line1.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 7, MAIN_SCREEN_WIDTH - 0, 0.5);
    if (self.detialLabel.text.length != 0) {
        
    CGSize detialSize = [CommonHelper sizeWithText:self.detialLabel.text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAIN_SCREEN_WIDTH - BigCellLeftMargin * 2, MAXFLOAT)];
        self.detialLabel.frame = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(self.line1.frame) + 7, detialSize.width, detialSize.height);
        self.line2.frame = CGRectMake(0, CGRectGetMaxY(self.detialLabel.frame) + 7, MAIN_SCREEN_WIDTH , 0.5);
        self.timeLabel.frame = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(self.line2.frame) + 7, MAIN_SCREEN_WIDTH - 30, 24);
    } else {
        self.timeLabel.frame = CGRectMake(BigCellLeftMargin, CGRectGetMaxY(self.line1.frame) + 7, MAIN_SCREEN_WIDTH - 30, 24);
    }
}

#pragma mark - 浏览查看

- (void)showImage:(UITapGestureRecognizer *)tap {
    if (self.imageView.image == nil) {
        return;
    }
    //1.浏览
//    [ZFAvatarBrowser showImage:self.imageView];
    
    //2.浏览放大和缩小
    UIWindow *window = self.window;
    _sImgView.image = self.imageView.image;
    [window addSubview:_scrollView];
}

#pragma mark - 初始化ScrollView
-(void)initScrollView{
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    _scrollView =[[UIScrollView alloc] initWithFrame:window.frame];
//    _scrollView.bounces = true;    //反弹
    _scrollView.scrollEnabled = true ; //滚动
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView:)];
    _scrollView.backgroundColor = [UIColor blackColor];
    [_scrollView addGestureRecognizer:tapGes];
    
    _sImgView = [[UIImageView alloc] init];
    _sImgView.frame = _scrollView.frame;
    _sImgView.contentMode = UIViewContentModeScaleAspectFit;
    _sImgView.userInteractionEnabled = YES;
    [_scrollView addSubview:_sImgView];
    
    UIPinchGestureRecognizer *pinchGes =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesAction:)] ;
    [_sImgView addGestureRecognizer:pinchGes];
    
    //
    UILongPressGestureRecognizer *longPressTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    [_scrollView addGestureRecognizer:longPressTap];
    // 重置
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kActionSheetDismiss"];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    tap2.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer: tap2];
    [tapGes requireGestureRecognizerToFail:tap2];
}
-(void)closeView:(UITapGestureRecognizer*)tap{
//    ZFLog(@"tap1");
    [_scrollView removeFromSuperview];
}

-(void)pinchGesAction:(UIPinchGestureRecognizer*)recognizer{
//    ZFLog(@"Pinch scale: %f", recognizer.scale);
    
    if (_scrollView.contentSize.width / _scrollView.frame.size.width > 4 && recognizer.scale >1) {
        return ;
    }
    
    if (recognizer.scale <= 1 && _sImgView.frame.size.width / _scrollView.frame.size.width <= 1  ) {
//        ZFLog(@"%f",_sImgView.frame.size.width / _scrollView.frame.size.width);
        _sImgView.frame = _scrollView.frame;
        return ;
    }
    
    
    _sImgView.transform = CGAffineTransformScale(_sImgView.transform, recognizer.scale, recognizer.scale);
    _scrollView.contentSize = recognizer.view.frame.size ;
    CGPoint point = CGPointMake(_scrollView.contentSize.width/2, _scrollView.contentSize.height/2);
    
    _sImgView.center = point;
    [_scrollView setContentOffset:CGPointMake(point.x - _scrollView.frame.size.width /2 , point.y - _scrollView.frame.size.height/2)];
    recognizer.scale = 1;
}


- (void)saveImage:(UILongPressGestureRecognizer *)tap {
    
    BOOL isDismiss = [[NSUserDefaults standardUserDefaults]boolForKey:@"kActionSheetDismiss"];
    if (!isDismiss) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kActionSheetDismiss"];
    
    if (tap.state == UIGestureRecognizerStateBegan) {
        
//        UIView *backgroundView = tap.view;
        UIWindow *window = self.window;
        UIImageView *imageView = [tap.view subviews][0];
        
        XYActionSheet *sheet = [[XYActionSheet alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) titleArr:@[@"保存到相册"]];
        
        sheet.Click = ^(NSInteger clickIndex) {
            switch (clickIndex) {
                case 0:{
                    UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
                    [SVProgressHUD showSuccessWithStatus:@"图片已保存"]; // 不严谨 若磁盘空间不足可能失败
                }
                    break;
                default:
                    break;
            }
        };
        
        [window addSubview:sheet];
    }
}
@end
