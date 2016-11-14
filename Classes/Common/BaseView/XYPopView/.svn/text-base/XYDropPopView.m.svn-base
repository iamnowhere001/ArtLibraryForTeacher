//
//  XYDropPopView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/5/24.
//  Copyright (c) 2015年 iamnowhere. All rights reserved.
//

#import "XYDropPopView.h"
#import "UIColor+Additions.h"

@implementation XYDropPopView{
    NSArray *_titleArray;
    NSArray *_imageNameArray;
    NSArray *_imageNameHLArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
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
    self.rowHeight = 40;
    
    _titleArray = @[@"修改密码",@"退出登录"];
    _imageNameArray = @[@"icon_pwd",@"icon_exit"];
    _imageNameHLArray = @[@"icon_pwdHL",@"icon_exitHL"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0]; //35
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
    cell.textLabel.text = _titleArray[indexPath.row];
    
    //必须创建视图对象
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:144/255.0 blue:225/255.0 alpha:1];
    cell.selectedBackgroundView = view;
    
    // 高亮状态
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.imageView.highlightedImage = [UIImage imageNamed:_imageNameHLArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
