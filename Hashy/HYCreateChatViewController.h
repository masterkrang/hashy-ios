//
//  HYCreateChatViewController.h
//  Hashy
//
//  Created by Kurt on 5/29/14.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ProfileCustomCell.h"
#import "Utility.h"
#import "UpdateDataProcessor.h"
#import "NetworkEngine.h"
#import "TTTAttributedLabel.h"
#import "UILabel+VerticalAlignment.h"
@interface HYCreateChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>
{
    BOOL resultsObtained;
    UIButton *createButton;
    int selectedPageNumber;
    UIActivityIndicatorView *activityIndicatorView;

}

@property(nonatomic,strong) IBOutlet PageTableView *createChatTableView;
@property(nonatomic,strong) IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *createChatArray;
@property(nonatomic,strong) IBOutlet UIView *searchContainerView;
@property(nonatomic,strong) IBOutlet UIView *createView;
@property(nonatomic,strong) IBOutlet UIImageView *createImageView;
@property(nonatomic,strong) IBOutlet UIButton *createViewButton;
@property(nonatomic,strong) IBOutlet TTTAttributedLabel *channelNameAttributedLabel;
@property(strong,nonatomic)IBOutlet UIView *bottomView;

@end
