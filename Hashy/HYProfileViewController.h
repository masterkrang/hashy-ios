//
//  HYProfileViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ProfileCustomCell.h"
#import "HYListChatViewController.h"
#import "UpdateDataProcessor.h"
#import "NetworkEngine.h"

@interface HYProfileViewController : UIViewController<UITableViewDataSource,PagingDelegate>{
    
    IBOutlet PageTableView *profilePageTableView;
    UIActivityIndicatorView *activityIndicatorView;
    int selectedPageNumber;

    
}

@property(nonatomic,strong)    IBOutlet PageTableView *profilePageTableView;
@property(nonatomic,strong)    IBOutlet UIButton *userProfileImageButton;
@property(nonatomic,strong)    IBOutlet UIButton *editUserProfileImageButton;
@property(nonatomic,strong)    IBOutlet UILabel *userNameLabel;
@property(nonatomic,strong)    IBOutlet UIImageView *userStatusImageView;
@property(nonatomic,strong)    IBOutlet UIImageView *profileAvatarImageView;

@property(nonatomic,strong)    IBOutlet UIView *profileHeaderView;
@property(nonatomic,strong)NSMutableArray *recentChatArray;
@property(nonatomic,strong)NSMutableDictionary *userDetailDict;

-(IBAction)editButtonPressed:(UIButton *)sender;



@end
