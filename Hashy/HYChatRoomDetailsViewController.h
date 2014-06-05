//
//  HYChatRoomDetailsViewController.h
//  Hashy
//
//  Created by attmac107 on 6/4/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
#import "ChatCustomCell.h"
#import "NetworkEngine.h"
#import "Utility.h"
#import "UpdateDataProcessor.h"


@interface HYChatRoomDetailsViewController : UIViewController<UITableViewDataSource,PagingDelegate,UITextFieldDelegate>{
    

    
}
@property(nonatomic,strong)    PNChannel *masterChannel;
@property(nonatomic,strong)    IBOutlet PageTableView *chatRoomTableView;
@property(nonatomic,strong) NSMutableDictionary *chatDict;
@property(nonatomic,strong) NSMutableArray *chatRoomMessageArray;
@property(nonatomic,strong)NSString * subscribersCountString;
@property(nonatomic,strong)NSString *chatNameString;

@property(nonatomic,strong)    IBOutlet UIView *messageConatinerView;
@property(nonatomic,strong)    IBOutlet UITextField *messagetextField;
@property(nonatomic,strong)    IBOutlet UIButton *attachFileButton;
@property(nonatomic,strong)    IBOutlet UIButton *sendMessageButton;

-(IBAction)attachFileButtonPressed:(UIButton *)sender;
-(IBAction)sendMessageButtonPressed:(UIButton *)sender;

@end
