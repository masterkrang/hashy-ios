//
//  HYListChatViewController.h
//  Hashy
//
//  Created by attmac107 on 5/28/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ProfileCustomCell.h"

@interface HYListChatViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>
{
    
}

@property(nonatomic,strong)IBOutlet PageTableView *listChatTableView;
@property(strong,nonatomic)IBOutlet UITextField *searchTextField;

@end
