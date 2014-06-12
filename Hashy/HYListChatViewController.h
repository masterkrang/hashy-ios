//
//  HYListChatViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ProfileCustomCell.h"
#import "NetworkEngine.h"
#import "Utility.h"
#import "HYChatRoomDetailsViewController.h"
#import "HYCreateChatViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface HYListChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate,EGORefreshTableHeaderDelegate>
{
    int selectedPageNumber;
    UIActivityIndicatorView *activityIndicatorView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSDate *lastUpadteddate;

}

@property(nonatomic,strong)IBOutlet PageTableView *listChatTableView;
@property(strong,nonatomic)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *hashTagListArray;
@property(strong,nonatomic)IBOutlet UIView *bottomView;

@end
