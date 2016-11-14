//
//  ChooseProfessionalCustomView.m
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/8/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "ChooseProfessionalCustomView.h"
#import "ProfessionModel.h"
@implementation ChooseProfessionalCustomView

-(void)createUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    [self addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    [backgroundView addGestureRecognizer:tap];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 120, self.bounds.size.width-80, self.bounds.size.height-240)];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    
    self.scrollView.layer.cornerRadius = 5;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        weakSelf.scrollView.contentSize = CGSizeMake(weakSelf.scrollView.bounds.size.width, weakSelf.professionalArr.count*55);
        for (NSInteger i=0; i<weakSelf.professionalArr.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 10 +i;
            button.frame = CGRectMake(0, i*55, weakSelf.scrollView.bounds.size.width, 55);
            [button addTarget:weakSelf action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, button.frame.size.height-0.5, button.frame.size.width, 0.5)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.size.width-50, 14, 27, 27)];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                ProfessionModel *model = weakSelf.professionalArr[i];
                [button setTitle:model.professionalName forState:UIControlStateNormal];
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 17, 0, 0);
                button.titleLabel.font = [UIFont systemFontOfSize:15.0];
                [weakSelf.scrollView addSubview:button];
                bottomLine.backgroundColor = [UIColor lightGrayColor];
                [button addSubview:bottomLine];
                if (i == weakSelf.select-1) {
                    
                    imageView.image = [UIImage imageNamed:@"choose_S"];
                }else
                {
                    imageView.image = [UIImage imageNamed:@"choose_N"];
                }
                [button addSubview:imageView];
            });
        }
    });
    
}

-(void)choose:(UIButton *)button
{
    ProfessionModel *model = self.professionalArr[button.tag - 10];
    NSString *idStr = [NSString stringWithFormat:@"%ld",button.tag-9];
    if ([idStr integerValue] != self.select) {
        
        if (self.chooseBlock) {
            self.chooseBlock(model.professionalId,idStr);
        }
        
    }
    [self removeFromSuperview];
}

-(void)remove
{
    [self removeFromSuperview];
}

@end
