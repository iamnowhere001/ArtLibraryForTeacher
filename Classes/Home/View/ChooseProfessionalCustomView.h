//
//  ChooseProfessionalCustomView.h
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/8/19.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseProfessionalCustomView : UIView

@property(nonatomic,assign)NSInteger select;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *professionalArr;
@property(nonatomic,copy)void (^chooseBlock)(NSString *professionId,NSString *idStr);

-(void)createUI;
@end
