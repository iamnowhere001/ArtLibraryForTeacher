//
//  QRreaderPopView.m
//  YZCommunity
//
//  Created by iamnowhere on 15/9/10.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import "XYPopView.h"
#import "UIColor+Additions.h"

@implementation XYPopView{
    NSArray *_titleArray;
    NSArray *_imageNameArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
        [self initTableViewHeader];
    }
    return self;
}

- (void)initTableView {
    
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    //self.backgroundColor = [UIColor colorWithHex:@"#ededed"];
    self.backgroundColor = [UIColor whiteColor];
    //self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorColor = [UIColor colorWithHex:@"eaeaea"];
    self.rowHeight = 40; // 固定高度最好使用这种写法
    
    _titleArray = @[@"相册",@"拍摄"];
    _imageNameArray = @[@"icon_camera",@"icon_album"];
}

- (void)initTableViewHeader {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = @"上传作品";
    [view addSubview:label];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,10, 20, 20)];
    cancelBtn.backgroundColor = [UIColor blueColor];
    [view addSubview:cancelBtn];
    self.tableHeaderView = view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.buttonClickedOperationBlock){
        self.buttonClickedOperationBlock(indexPath.row);
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
