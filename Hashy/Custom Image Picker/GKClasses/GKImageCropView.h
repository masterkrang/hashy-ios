//
//  GKImageCropView.h
//  GKImagePicker
//
//  Created by Kurt on 5/27/14.
//

#import <UIKit/UIKit.h>

@interface GKImageCropView : UIView

@property (nonatomic, strong) UIImage *imageToCrop;
@property (nonatomic, assign) CGSize cropSize;
@property (nonatomic, assign) BOOL resizableCropArea;

- (UIImage *)croppedImage;

@end
