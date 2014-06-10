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

@interface HYCreateChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>
{
    BOOL resultsObtained;
    UIButton *createButton;
    
}

@property(nonatomic,strong) IBOutlet PageTableView *createChatTableView;
@property(nonatomic,strong) IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *createChatArray;



@end
