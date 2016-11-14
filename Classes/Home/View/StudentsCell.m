//
//  StudentsCell.m
//  ArtLibraryForTeacher
//
//  Created by ITUser on 16/8/18.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "StudentsCell.h"
#import "StudentModel.h"
@implementation StudentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = JRColor(223, 223, 226);
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setModel:(StudentModel *)model{

    _model = model;
    NSString *imageStr = nil;
    if (model.headImage) {
        imageStr = [NSString stringWithFormat:@"%@%@",imageBaseUrlPath,model.headImage];
    }
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[imageStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"icon-default"]];
    self.studentNameLab.text = self.model.studentName;
    self.studentOpusCountLab.text = [NSString stringWithFormat:@"作品数(%@)",self.model.studentOpusCount];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor redColor]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self.studentOpusCountLab.text];
    [attributeStr addAttributes:dic range:[self.studentOpusCountLab.text rangeOfString:[NSString stringWithFormat:@"%@",model.studentOpusCount]]];
    self.studentOpusCountLab.attributedText = attributeStr;
}

@end
