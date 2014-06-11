//
//  HYSubscribersListViewController.h
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "Utility.h"
#import "SubscribersCustomCell.h"
#import "NetworkEngine.h"

@interface HYSubscribersListViewController : UIViewController<UITableViewDataSource,PagingDelegate>
{

    int selectedPageNumber;
    UIButton *subscriberButtonCount;

}

@property(nonatomic,strong) IBOutlet PageTableView *subscribersTableView;
@property(nonatomic,strong)  NSMutableArray *subscribersListArray;
@property(nonatomic,strong) IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) IBOutlet UIView *searchContainerView;

@property(nonatomic,strong) NSString *subscribersCountString;
@property(nonatomic,strong) NSString *chat_id_string;



@end
