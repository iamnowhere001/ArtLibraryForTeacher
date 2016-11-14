//
//  ImagePickerHelper.h
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PickerType) {
    PickerTypePhoto = 0,    ///< 相册
    PickerTypeCamera,       ///< 拍照
};

typedef void(^CallBackBlock)(NSDictionary *infoDict, BOOL isCancel);  ///< 回调

@interface ImagePickerHelper : NSObject

+ (instancetype)shareInstance;

/// 默认图片不可编辑
- (void)presentPicker:(PickerType)pickerType edit:(BOOL)edit targetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock;

/// 相册
- (void)onPhotoActionWithTargetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock;

/// 相机
- (void)onCameraActionWithTargetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock;

@end
