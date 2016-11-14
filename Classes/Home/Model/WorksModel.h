//
//  WorkModel.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/7.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorksModel : NSObject

@property (nonatomic, copy) NSString *addTime;              ///< 修改时间
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *createDate;           ///< 上传时间 & 创作时间
@property (nonatomic, copy) NSString *describe;             ///< 作品详细描述
@property (nonatomic, copy) NSString *diyCagegory;          ///< 自定义分类
@property (nonatomic, assign) NSInteger heigth;             ///< 作品高
@property (nonatomic, copy) NSString *imageId;              ///< 作品id
@property (nonatomic, copy) NSString *imagePath;            ///< 作品图片路径
@property (nonatomic, copy) NSString *opusIsDeleted;
@property (nonatomic, copy) NSString *opusIsPublic;
@property (nonatomic, copy) NSString *recommendPosition;

@property (nonatomic, copy) NSString *stuIsDeleted;
@property (nonatomic, assign) NSInteger stuIsPublic;

@property (nonatomic, copy) NSString *studentId;                  ///< 学生id
@property (nonatomic, copy) NSString *studentName;                 ///< 学生姓名
@property (nonatomic, copy) NSString *thumbnailImagePath;   ///< 作品缩略图路径
@property (nonatomic, copy) NSString *thumbnailDeatialImagePath;
@property (nonatomic, copy) NSString *title;                ///< 作品标题
@property (nonatomic, assign) NSInteger width;              ///< 作品宽
@property (nonatomic, copy) NSString *isArt;

@end
