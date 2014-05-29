//
//  GKResizeableView.h
//  GKImagePicker
//
//  Created by Kurt on 5/27/14.
//

#import <UIKit/UIKit.h>
#import "GKCropBorderView.h"
#import "GKImageCropOverlayView.h"

typedef struct {
    int widhtMultiplyer;
    int heightMultiplyer;
    int xMultiplyer;
    int yMultiplyer;
}GKResizeableViewBorderMultiplyer;

@interface GKResizeableCropOverlayView : GKImageCropOverlayView

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong, readonly) GKCropBorderView *cropBorderView;

/**
 call this method to create a resizable crop view
 @param frame
 @param initial crop size
 @return crop view instance
 */
-(id)initWithFrame:(CGRect)frame andInitialContentSize:(CGSize)contentSize;

@end
