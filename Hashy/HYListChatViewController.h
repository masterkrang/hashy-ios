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

@interface HYListChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>
{
    
}

@property(nonatomic,strong)IBOutlet PageTableView *listChatTableView;
@property(strong,nonatomic)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *hashTagListArray;

@end
