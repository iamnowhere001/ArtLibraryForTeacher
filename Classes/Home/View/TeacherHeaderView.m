//
//  TeacherHeaderView.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/8/5.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "TeacherHeaderView.h"

@interface TeacherHeaderView ()

@end

@implementation TeacherHeaderView

- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.height = 60;
        self.width = [UIScreen mainScreen].bounds.size.width;

    }
    return self;
}


- (IBAction)semesterAction:(UIButton *)sender {
  // 更新button
    if (self.callback) {
        self.callback(sender.tag);
    }
    
    
    
//    if (sender.selected == NO) {
//        [sender setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
//    }else{
//        [sender setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
//    }
//    sender.selected = !sender.selected;
    
}

- (IBAction)professionAction:(UIButton *)sender {
    if (self.callback) {
        self.callback(sender.tag);
    }
//    if (sender.selected == NO) {
//        [sender setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
//    }else{
//        [sender setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
//    }
//    sender.selected = !sender.selected;
}


@end
