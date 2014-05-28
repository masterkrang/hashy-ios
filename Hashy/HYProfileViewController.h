//
//  HYProfileViewController.h
//  Hashy
//
//  Created by attmac107 on 5/27/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ProfileCustomCell.h"
#import "HYListChatViewController.h"

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
