//
//  HYSubscribersListViewController.h
//  Hashy
//
//  Created by attmac107 on 5/30/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "Utility.h"
#import "SubscribersCustomCell.h"
#import "NetworkEngine.h"

@interface HYSubscribersListViewController : UIViewController<UITableViewDataSource,PagingDelegate>
{

    
}

@property(nonatomic,strong) IBOutlet PageTableView *subscribersTableView;
@property(nonatomic,strong)  NSMutableArray *subscribersListArray;
@property(nonatomic,strong) IBOutlet UITextField *searchTextField;

@property(nonatomic,strong) NSString *subscribersCountString;


@end
