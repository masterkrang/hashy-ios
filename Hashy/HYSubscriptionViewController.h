//
//  HYSubscriptionViewController.h
//  Hashy
//
//  Created by attmac107 on 6/20/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "REFrostedViewController.h"
#import "CustomNavigationController.h"
#import "Utility.h"
#import "NetworkEngine.h"
#import "SubscriptionCustomCell.h"
#import "HYAppDelegate.h"

@interface HYSubscriptionViewController : UIViewController<UITableViewDataSource,PagingDelegate,REFrostedViewControllerDelegate>
{
    int selectedPageNumber;
    UIActivityIndicatorView *activityIndicatorView;
    
    
}

@property(nonatomic,strong)IBOutlet PageTableView *subscriptionTableView;
@property(nonatomic,strong) NSMutableArray *subscriptionsArray;
@property(nonatomic,strong)NSString *user_id;
@property(strong,nonatomic)IBOutlet UIView *bottomView;


-(IBAction)subscriptionSwitchPressed:(UISwitch *)sender;


@end
