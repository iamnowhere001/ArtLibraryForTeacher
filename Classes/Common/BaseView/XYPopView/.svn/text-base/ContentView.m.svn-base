//
//  ContentView.m
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "ContentView.h"
#import "FDAlertView.h"

@interface ContentView ()
//@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ContentView {
//    NSArray *_titleArray;
//    NSArray *_imageNameArray;
//    NSArray *_imageNameHLArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self initTableView];
//    }
//    return self;
//}
//
//- (void)initTableView {
//    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width, 160) style:UITableViewStylePlain];
//    [self addSubview:self.tableView];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.scrollEnabled = NO;
//    self.tableView.rowHeight = 80;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _titleArray = @[@"相册",@"拍摄"];
//    _imageNameArray = @[@"icon_album",@"icon_camera"];
//    _imageNameHLArray = @[@"icon_pwdHL",@"icon_exitHL"];
//    
//    [self.tableView reloadData];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _titleArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    
//    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//    cell.textLabel.font = [UIFont systemFontOfSize:22.0]; //35
//    cell.textLabel.textAlignment = NSTextAlignmentLeft;
//    cell.imageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
//    cell.textLabel.text = _titleArray[indexPath.row];
//    
//    //必须创建视图对象
//    UIView* view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:144/255.0 blue:225/255.0 alpha:1];
//    //cell.selectedBackgroundView = view;
//    
//    // 高亮状态
//    //cell.textLabel.highlightedTextColor = [UIColor whiteColor];
//    //cell.imageView.highlightedImage = [UIImage imageNamed:_imageNameHLArray[indexPath.row]];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [self actionWithTag:indexPath.row + 101];
//    
//}
//
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

- (IBAction)shutdown:(id)sender {
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}

- (IBAction)album:(UIButton *)sender {
   
    [self actionWithTag:101];
    
}
- (IBAction)camera:(UIButton *)sender {
    [self actionWithTag:102];
}

- (void)actionWithTag:(NSUInteger)tag{
    
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(tag);
    }
}

@end
