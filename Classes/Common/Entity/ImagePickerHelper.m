//
//  ImagePickerHelper.m
//  ArtLibrary
//
//  Created by iamnowhere on 16/6/27.
//  Copyright © 2016年 iamnowhere. All rights reserved.
//

#import "ImagePickerHelper.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface ImagePickerHelper ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    //UIImagePickerController        *_imgPickC;
    UIViewController            *_VC;
    CallBackBlock               _callBackBlock;
}

@end

@implementation ImagePickerHelper

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static ImagePickerHelper *pickHelper;
    dispatch_once(&once,^{
        pickHelper = [[ImagePickerHelper alloc]init];
    });
    return pickHelper;
}

//- (instancetype)init {
//    self = [super init];
//    if(self){
//        if(!_imgPickC){
//            _imgPickC = [[UIImagePickerController alloc] init]; // 初始化 _imgPickC
//        }
//    }
//    return self;
//}

- (void)presentPicker:(PickerType)pickerType edit:(BOOL)edit targetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock {
    _VC = VC;
    _callBackBlock = callBackBlock;
    if (pickerType == PickerTypePhoto) {
        // 相册
        ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
        if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
            [self showTips:@"尚未获得相册访问授权，请前往设置-隐私-相册中修改~" targetVC:VC];
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            if (edit) {
                picker.allowsEditing = YES;
            }
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.delegate = self;
            [VC presentViewController:picker animated:YES completion:nil];
        }
    } else if (pickerType == PickerTypeCamera){
        // 相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSString * mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
                [self showTips:@"尚未获得拍照访问授权，请前往设置-隐私-相机中修改~" targetVC:VC];
            }else{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                if (edit) {
                    picker.allowsEditing = YES;
                }
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                [VC presentViewController:picker animated:YES completion:nil];
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}

- (void)onPhotoActionWithTargetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock {
    _VC = VC;
    _callBackBlock = callBackBlock;
    // 相册
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
        [self showTips:@"尚未获得相册访问授权，请前往设置-隐私-相册中修改~" targetVC:VC];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
      
        //picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = self;
        [VC presentViewController:picker animated:YES completion:nil];
    }
}

- (void)onCameraActionWithTargetVC:(UIViewController *)VC callBackBlock:(CallBackBlock)callBackBlock {
    
    _VC = VC;
    _callBackBlock = callBackBlock;
    // 相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self showTips:@"尚未获得拍照访问授权，请前往设置-隐私-相机中修改~" targetVC:VC];
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            [VC presentViewController:picker animated:YES completion:nil];
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)showTips:(NSString *)message targetVC:(UIViewController *)VC{
    
    if ([[UIDevice currentDevice]systemVersion].floatValue >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alert addAction:cancelAction];
        [alert addAction:setAction];
        [VC presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // NSLog(@"-imagePickerInfo--%@",info);
    /**
     -imagePickerInfo--{
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x7ffb3b4fb510> size {3000, 2002} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=9F983DBA-EC35-42B8-8773-B597CF782EDD&ext=JPG";
     }
     */
    
    /**
     
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     
     */

    // 使用YES 
    [picker dismissViewControllerAnimated:YES completion:^{
        //_callBackBlock(info, NO);
    }];
    
    _callBackBlock(info, NO);
    
//    [_VC dismissViewControllerAnimated:NO completion:^{
//        _callBackBlock(info, NO); // block回调
//    }];
    
   // UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //NSData *data = UIImageJPEGRepresentation(image, 1);
    //NSData *dataStr = [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //NSString *dataStr3 = [[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding];
    // NSLog(@"--222---%@",dataStr3);
    
    // 显示图片 主线程 多余
    // [self performSelectorOnMainThread:@selector(showUserImageViewWithimage:) withObject:image waitUntilDone:NO];
    
//    XYEditWorkViewController *VC = [[XYEditWorkViewController alloc]init];
//    VC.image = image;
//    VC.type = ArticleTypeAdd;
//    [self.navigationController pushViewController:VC animated:NO];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    [_VC dismissViewControllerAnimated:NO completion:^{
    //        _callBackBlock(info, YES); // block回调
    //    }];
}

@end
