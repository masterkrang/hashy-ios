//
//  HYChatRoomDetailsViewController.h
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ChatCustomCell.h"
#import "NetworkEngine.h"
#import "Utility.h"
#import "UpdateDataProcessor.h"
#import "UILabel+VerticalAlignment.h"
#import "GKImagePicker.h"



@interface HYChatRoomDetailsViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate,UIActionSheetDelegate,GKImagePickerDelegate>{
    
    BOOL isLoading;
    UIButton *backButton;
    UIButton *subscriberButtonCount;
    GKImagePicker *imagePicker;
    UIImage *editedImage;
    NSString *imageURLString;
    BOOL isImageSelectedFromDevice;
    UIActivityIndicatorView *activityIndicatorView;
    NSMutableArray *imageArray;
    
    
    
}
@property(nonatomic,strong)    PNChannel *masterChannel;
@property(nonatomic,strong)    IBOutlet PageTableView *chatRoomTableView;
@property(nonatomic,strong) NSMutableDictionary *chatDict;
@property(nonatomic,strong) NSMutableArray *chatRoomMessageArray;
@property(nonatomic,strong)NSString * subscribersCountString;
@property(nonatomic,strong)NSString *chatNameString;
@property(nonatomic,strong)NSString *chatIDString;

@property(nonatomic,strong)    IBOutlet UIView *messageConatinerView;
@property(nonatomic,strong)    IBOutlet UITextField *messagetextField;
@property(nonatomic,strong)    IBOutlet UIButton *attachFileButton;
@property(nonatomic,strong)    IBOutlet UIButton *sendMessageButton;

-(IBAction)attachFileButtonPressed:(UIButton *)sender;
-(IBAction)sendMessageButtonPressed:(UIButton *)sender;

@end
