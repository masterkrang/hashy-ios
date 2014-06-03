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

@interface HYProfileViewController : UIViewController<UITableViewDataSource,PagingDelegate>{
    
    IBOutlet PageTableView *profilePageTableView;
    
}

@property(nonatomic,strong)    IBOutlet PageTableView *profilePageTableView;
@property(nonatomic,strong)    IBOutlet UIButton *userProfileImageButton;
@property(nonatomic,strong)    IBOutlet UIButton *editUserProfileImageButton;
@property(nonatomic,strong)    IBOutlet UILabel *userNameLabel;
@property(nonatomic,strong)    IBOutlet UIImageView *userStatusImageView;
@property(nonatomic,strong)    IBOutlet UIView *profileHeaderView;

-(IBAction)editButtonPressed:(UIButton *)sender;



@end
