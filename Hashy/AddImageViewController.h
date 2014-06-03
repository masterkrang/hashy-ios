//
//  AddImageViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "HYProfileViewController.h"
#import "NetworkEngine.h"
#import <UIImageView+AFNetworking.h>
#import "GKImagePicker.h"
#import "HYSubscribersListViewController.h"
#import "UpdateDataProcessor.h"

@interface AddImageViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKImagePickerDelegate>
{
    
    GKImagePicker *imagePicker;
    BOOL isImageSelectedFromDevice;
    UIImage *editedImage;
    NSString *randomAvatarImageURL;
    UIActivityIndicatorView *activityIndicatorView;
    
}
@property(nonatomic,strong) IBOutlet UIButton *avatarImageButton;

@property(nonatomic,strong) IBOutlet UIImageView *avatarImageView;
@property(nonatomic,strong) IBOutlet UIButton *doneButton;
@property(nonatomic,strong) IBOutlet UILabel *addYourImagelabel;
@property(nonatomic,strong) IBOutlet UILabel *tapChangeLabel;



-(IBAction)doneButtonPressed:(UIButton *)sender;
-(IBAction)changeImageButtonPressed:(UIButton *)sender;

@end
