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
#import "HYChatRoomViewController.h"
#import "HYChatRoomDetailsViewController.h"
#import "HYCreateChatViewController.h"


@interface HYListChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>
{
    int selectedPageNumber;
    UIActivityIndicatorView *activityIndicatorView;
    
}

@property(nonatomic,strong)IBOutlet PageTableView *listChatTableView;
@property(strong,nonatomic)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *hashTagListArray;
@property(strong,nonatomic)IBOutlet UIView *bottomView;

@end
