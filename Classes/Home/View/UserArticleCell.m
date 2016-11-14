//
//  XYUserArticleCell.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/7/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "UserArticleCell.h"

#import "WorksModel.h"
#import "ArticleViewModel.h"

#import "UILabel+XYAdd.h"
@interface UserArticleCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detialLabel;

@property (nonatomic, strong) UIView *line1;

@end

@implementation UserArticleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"UserArticleCell";
    UserArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UserArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 6;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1].CGColor;
        self.layer.masksToBounds = YES;
        
        self.imageView1 = [[UIImageView alloc]init];
        self.imageView1.backgroundColor = [UIColor randomBackgroundColor]; // 7种随机色
        [self.contentView addSubview:self.imageView1];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor colorWithHex:@"#111111"];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        self.detialLabel = [[UILabel alloc]init];
        self.detialLabel.textColor = [UIColor colorWithHex:@"#595757"];
        self.detialLabel.numberOfLines = 0;
        self.detialLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.detialLabel];
        
        self.line1 = [[UIView alloc]init];
        self.line1.backgroundColor = SeparatorLineColor;
        [self.contentView addSubview:self.line1];
    }
    return self;
}
- (void)setArticleViewModel:(ArticleViewModel *)articleViewModel {
    _articleViewModel = articleViewModel;
    
    // 设置数据
   WorksModel *works = _articleViewModel.works;
    
    NSString *time = [works.createDate substringToIndex:10];
    time = [time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@  %@  %@",works.title,works.studentName,time];
    

    [self.detialLabel setText:works.describe lineSpacing:2.5];

    
    NSString *imageStr = nil;
    if (!works.thumbnailDeatialImagePath) {
        imageStr = [NSString stringWithFormat:@"%@%@",imageBaseUrlPath,works.thumbnailImagePath];
    }else {
        imageStr = [NSString stringWithFormat:@"%@%@",imageBaseUrlPath,works.thumbnailDeatialImagePath];
    }
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[imageStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
}
- (void)layoutSubviews {


    // 设置frame
    self.imageView1.frame = _articleViewModel.imageF;
    
    self.titleLabel.frame = _articleViewModel.titleF;
    
    self.line1.frame = _articleViewModel.line1F;
    
    self.detialLabel.frame = _articleViewModel.detailF;
    
    [super layoutSubviews];
}
- (void)setFrame:(CGRect)frame {

    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.origin.x = 5;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 10;;
    [super setFrame:frame];
}

@end
