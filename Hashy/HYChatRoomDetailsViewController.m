//
//  HYChatRoomDetailsViewController.m
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import "HYChatRoomDetailsViewController.h"
#define kUserTopLeft @"chat_room_user_top_left.png"
#define kUserTopRight @"chat_room_user_top_right.png"
#define kUserBottomLeft @"chat_room_user_bottom_left.png"
#define kUserBottomRight @"chat_room_user_bottom_right.png"
#define kOtherTopLeft @"chat_room_other_top_left.png"
#define kOtherTopRight @"chat_room_other_top_right.png"
#define kOtherBottomLeft @"chat_room_other_bottom_left.png"
#define kOtherBottomRight @"chat_room_other_bottom_right.png"
#define kBlueBubbleImage @"chat_room_blue_bubble.png"
#define kGreyBubbleImage @"chat_room_grey_bubble.png"




@interface HYChatRoomDetailsViewController ()

@end

@implementation HYChatRoomDetailsViewController
@synthesize chatRoomTableView;
@synthesize chatDict;
@synthesize chatRoomMessageArray;
@synthesize subscribersCountString;
@synthesize chatNameString;
@synthesize messageConatinerView;
@synthesize messagetextField;
@synthesize sendMessageButton;
@synthesize attachFileButton;
@synthesize masterChannel;
@synthesize chatIDString;
@synthesize bottomView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)setPaddingView{
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    paddingView.backgroundColor = [UIColor clearColor];
    
//    UIImageView *searchIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9,8, 12,12 )];
//    searchIconImageView.image=[UIImage imageNamed:@"listChat_search_icon.png"];
//    [paddingView addSubview:searchIconImageView];
    
    messagetextField.leftView = paddingView;
    messagetextField.leftViewMode = UITextFieldViewModeAlways;
    
    messagetextField.font=[UIFont fontWithName:kHelVeticaNeueRegular size:16];
    messagetextField.textColor=[Utility colorWithHexString:@"525252"];
    messagetextField.autocapitalizationType=UITextAutocapitalizationTypeSentences;
    
   // messagetextField.autocorrectionType=UITextAutocorrectionTypeDefault;

}


-(void) setBarButtonItems{
    
    
    
    subscriberButtonCount=[UIButton buttonWithType:UIButtonTypeCustom];
    subscriberButtonCount.frame=CGRectMake(0, 0, 35+(subscribersCountString.length *6), 40);
    //    subscriberButtonCount.backgroundColor=[UIColor orangeColor];
    [subscriberButtonCount setTitle:subscribersCountString forState:UIControlStateNormal];
    [subscriberButtonCount setTitleColor:[Utility colorWithHexString:kHexValueLightGreenColor] forState:UIControlStateNormal];
    [subscriberButtonCount addTarget:self action:@selector(subscribersCountButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    subscriberButtonCount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((subscriberButtonCount.frame.size.width -5 - (subscribersCountString.length+1) *9), 15, 10, 10)];
    [imageView setImage:[UIImage imageNamed:kGreenDot]];
    
    [subscriberButtonCount addSubview:imageView];
    
    
    
    backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, 0, 24, 16);
    [backButton setBackgroundImage:[UIImage imageNamed:@"profile_back_button.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:subscriberButtonCount];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
   
}





-(void)addDAKeyboardControl{
    
    
    
    typeof (self.messageConatinerView) weakSelfMessageContainer=self.messageConatinerView;
    typeof (self.chatRoomTableView) weakSelfTableView=self.chatRoomTableView;
    
    typeof (self) weakSelf=self;
    
    
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        
        NSLog(@"%@",weakSelf);

        if ([weakSelf.navigationController.visibleViewController isKindOfClass:[HYChatRoomDetailsViewController class]]) {
            
            
            /*
             Try not to call "self" inside this block (retain cycle).
             But if you do, make sure to remove DAKeyboardControl
             when you are done with the view controller by calling:
             [self.view removeKeyboardControl];
             */
            CGRect toolBarFrame = weakSelfMessageContainer.frame;
            toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
            weakSelfMessageContainer.frame = toolBarFrame;
            NSLog(@"Origin %f",(-[[UIScreen mainScreen] bounds].size.height+toolBarFrame.size.height+toolBarFrame.origin.y));
            
            if (keyboardFrameInView.origin.y==264 || keyboardFrameInView.origin.y==352) {

                if (IS_IPHONE_5) {
                    //For iphone 5 keyboard show

                    if (weakSelfTableView.contentSize.height<230) {
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=0;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    else if (weakSelfTableView.contentSize.height>=230 && weakSelfTableView.contentSize.height<290){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-60;
                        
                        weakSelfTableView.frame = tableViewFrame;

                    }
                    
                    else if (weakSelfTableView.contentSize.height>=290 && weakSelfTableView.contentSize.height<350){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-150;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }

                    
                    else if (weakSelfTableView.contentSize.height>=350 && weakSelfTableView.contentSize.height<410){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-210;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    
                    else{
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-216;//90;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    
                    
                    
                }
                else{
                   //For iphone 4 keyboard show
                    if (weakSelfTableView.contentSize.height<150) {
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=0;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    else if (weakSelfTableView.contentSize.height>=150 && weakSelfTableView.contentSize.height<210){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-60;
                        
                        weakSelfTableView.frame = tableViewFrame;
                        
                    }
                    
                    else if (weakSelfTableView.contentSize.height>=210 && weakSelfTableView.contentSize.height<270){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-150+20;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    
                    
                    else if (weakSelfTableView.contentSize.height>=270 && weakSelfTableView.contentSize.height<330){
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-210;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    
                    else{
                        
                        CGRect tableViewFrame =weakSelfTableView.frame;
                        tableViewFrame.origin.y=-216;//90;
                        
                        weakSelfTableView.frame = tableViewFrame;
                    }
                    
                }
            }
            
            //Hide keyboard
            else{
                
                if (closing) {
                    CGRect tableViewFrame =weakSelfTableView.frame;
                    tableViewFrame.origin.y=0;// [[UIScreen mainScreen] bounds].size.height-35-toolBarFrame.origin.y;
                    
                    weakSelfTableView.frame = tableViewFrame;
                    
                }
                else{
                    
                    CGRect tableViewFrame =weakSelfTableView.frame;
                    tableViewFrame.origin.y=(-[[UIScreen mainScreen] bounds].size.height+toolBarFrame.size.height+toolBarFrame.origin.y);// [[UIScreen mainScreen] bounds].size.height-35-toolBarFrame.origin.y;
                    
                    weakSelfTableView.frame = tableViewFrame;

                    
//                    if (IS_IPHONE_5) {
//                        
//                        if (weakSelfTableView.contentSize.height>270) {
//                            
//                            CGRect tableFrame=weakSelfTableView.frame;
//                            tableFrame.origin.y-=216;
//                            weakSelfTableView.frame=tableFrame;
//                        }
//                        
//                    }
//                    else{
//                        
//                        if (weakSelfTableView.contentSize.height>190  &&weakSelfTableView.contentSize.height<220 ) {
//                            
//                            CGRect tableFrame=weakSelfTableView.frame;
//                            tableFrame.origin.y-=166;
//                            weakSelfTableView.frame=tableFrame;
//                        }
//                        else if (weakSelfTableView.contentSize.height>=220){
//                            CGRect tableFrame=weakSelfTableView.frame;
//                            tableFrame.origin.y-=216;
//                            weakSelfTableView.frame=tableFrame;
//                            
//                        }
//                        
//                    }
                    
                    
                    NSLog(@"Table total height %f",weakSelfTableView.contentSize.height);
                    
                    
               
                    
                    
                }
                
                
                
            }
            
        }
        
        
        

        
        
    } constraintBasedActionHandler:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    isInChatRoom=YES;
    
    [self.view removeKeyboardControl];
    [self addDAKeyboardControl];

    sendMessageButton.enabled=NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [chatRoomTableView setupTablePaging];
    chatRoomTableView.selectedPageNumber=1;
    chatRoomTableView.pagingDelegate=self;
    
    if (self.chatNameString) {
        self.title=[NSString stringWithFormat:@"#%@",self.chatNameString];

    }
    
    [self setBarButtonItems];
    [self setPaddingView];
    [self getChatWithID:chatIDString];
   
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;
    bottomView.backgroundColor=[UIColor clearColor];
    
    
   // activityIndicatorView =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(90, 90, 20, 20)];
   // activityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    
    if (!imageArray) {
        imageArray=[[NSMutableArray alloc]init];
        
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(insertNewMessage:) name:kNewMessageReceived object:nil];
    
    
 //   [self subscribeToPubNubChannel:chatIDString];
    
    
    [sendMessageButton setTitleColor:[Utility colorWithHexString:@"157dfb"] forState:UIControlStateNormal];
    [sendMessageButton setTitleColor:[Utility colorWithHexString:@"cecece"] forState:UIControlStateDisabled];
    [sendMessageButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueMedium size:16]];

    
    //   [self getChatWithID:[chatDict valueForKey:@"id"]];
    
    
	// Do any additional setup after loading the view.
}


#pragma mark Hashy API methods



-(void)getMessagesViaAPICall{
    
    [[NetworkEngine sharedNetworkEngine]getChatMessagesForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
        [kAppDelegate hideProgressHUD];

        if (isInChatRoom) {
            if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
                
                self.chatRoomMessageArray=[object mutableCopy];
                // [chatRoomBubbleTableView reload];
                
                if (self.chatRoomMessageArray.count) {
                    self.chatRoomMessageArray= [[[self.chatRoomMessageArray reverseObjectEnumerator]allObjects]mutableCopy];
                }
                
                [chatRoomTableView reloadData];
                if (chatRoomMessageArray.count) {
                    // [self.chatRoomTableView beginUpdates];
                    [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatRoomTableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                    //[self.chatRoomTableView endUpdates];
                }
                
                [self subscribeToPubNubChannel:chatIDString];
                
            }
            
            chatRoomTableView.pageLocked=NO;
            
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
        }
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        [kAppDelegate hideProgressHUD];
        chatRoomTableView.pageLocked=NO;

    } forChatID:chatIDString forPageNumber:chatRoomTableView.selectedPageNumber];
    
}


-(void)getChatWithID:(NSString *)chat_id_String{
    
    
    [kAppDelegate showProgressHUD:self.view];
    
    
    [[NetworkEngine sharedNetworkEngine]getChatForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
        
        
        if ([object valueForKey:@"channel"] && ![[object valueForKey:@"channel"]isEqual:[NSNull null]]) {
            
            NSMutableDictionary *channelDict=[object valueForKey:@"channel"];
            
            if ([channelDict valueForKey:@"subscribers_count"] && ![[channelDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]]) {
                
                
                NSNumber *subscriber_num=[channelDict valueForKey:@"subscribers_count"];
                
                int subscriber_count_int=subscriber_num.intValue;
                NSString *count=[NSString stringWithFormat:@"%d",subscriber_count_int];
                if (count)
                   [ subscriberButtonCount setTitle:count forState:UIControlStateNormal];
                
            }
            
        }
        
        
        [self getMessagesViaAPICall];
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        [kAppDelegate hideProgressHUD];
        
    } forChatID:chat_id_String forPageNumber:chatRoomTableView.selectedPageNumber];
    
}



-(void)sendMessageOnHashyAPI{
    
    
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long long time=timeInMiliseconds;
    NSString *dateString=[NSString stringWithFormat:@"%lld",time];
    
    
    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    [messageDict setValue:messagetextField.text forKey:@"body"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.stringValue forKey:@"user_id"];
    [messageDict setValue:dateString forKey:@"message_timestamp"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].userName forKey:@"user_name"];
    [messageDict setValue:@"text" forKey:@"message_type"];
    
    NSMutableDictionary *messageDetailDict=[[NSMutableDictionary alloc]init];
    [messageDetailDict setValue:messageDict forKey:@"message"];
    
    messagetextField.text=@"";
    
    [[NetworkEngine sharedNetworkEngine]sendMessage:^(id object) {
        
        //NSLog(@"%@",object);
        
        
    } onError:^(NSError *error) {
        
        
        
    } forChatID:chatIDString withParams:messageDetailDict];
    
}


-(void) sendImageOnHashyAPI:(UIImage *)image andImageURL:(NSString *)url{
    
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long long time=timeInMiliseconds;
    NSString *dateString=[NSString stringWithFormat:@"%lld",time];
    
    
    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    [messageDict setValue:url forKey:@"body"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.stringValue forKey:@"user_id"];
    [messageDict setValue:dateString forKey:@"message_timestamp"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].userName forKey:@"user_name"];
    [messageDict setValue:@"image" forKey:@"message_type"];
    //    [messageDict setValue:@"text" forKey:@"message_type"];
    
    NSMutableDictionary *messageDetailDict=[[NSMutableDictionary alloc]init];
    [messageDetailDict setValue:messageDict forKey:@"message"];
    
    
    NSMutableDictionary *imageDict=[[NSMutableDictionary alloc]init];
    [imageDict setValue:image forKey:@"image"];
    [imageDict setValue:url forKey:@"image_url"];
    
    
    [imageArray addObject:imageDict];

    
    
    messagetextField.text=@"";
    [[NetworkEngine sharedNetworkEngine]sendMessage:^(id object) {
        
        //NSLog(@"%@",object);
        
        
    } onError:^(NSError *error) {
        
        
        
    } forChatID:chatIDString withParams:messageDetailDict];
    
    
    
}

#pragma mark Pub Nub Methods

-(void) sendImageonPubNub:(UIImage *) image andImageURL:(NSString *)url{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    
    
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    [messageDict setValue:url forKey:@"message"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.stringValue forKey:@"user_id"];
    [messageDict setValue:dateString forKey:@"message_date"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].userName forKey:@"user_name"];
    [messageDict setValue:@"image" forKey:@"type"];
    
    NSMutableDictionary *imageDict=[[NSMutableDictionary alloc]init];
    [imageDict setValue:image forKey:@"image"];
    [imageDict setValue:url forKey:@"image_url"];
    
    
    [imageArray addObject:imageDict];
    
    
    [PubNub sendMessage:messageDict toChannel:masterChannel withCompletionBlock:^(PNMessageState messageState, id response) {
        [kAppDelegate hideProgressHUD];
        
        NSLog(@"%@",response);
        
        if (messageState==PNMessageSent) {
            
            
        }
        
        
    }];
    
}



-(void)subscribeToPubNubChannel:(NSString *)channelName{
    
    NSLog(@"Channel Name %@",channelName);
    
 //   [kAppDelegate showProgressHUD:self.view];
    backButton.enabled=YES;

//    backButton.enabled=NO;
//    subscriberButtonCount.enabled=NO;
    
  
   
    if ([PubNub sharedInstance].isConnected) {
        
        
        masterChannel=[PNChannel channelWithName:channelName shouldObservePresence:YES];
        BOOL isSubscribedOnChannel=[PubNub isSubscribedOnChannel:masterChannel];

        
        if (isSubscribedOnChannel) {
            
            //[self getFullHistoryOfMessages:masterChannel];

        }
        else{
            
            if (masterChannel) {
                [PubNub subscribeOnChannel:masterChannel withCompletionHandlingBlock:^(PNSubscriptionProcessState state, NSArray *array, PNError *error) {
                    
                    if (!error) {
                       // [self getFullHistoryOfMessages:masterChannel];
                        
                    }
                    else{
                        backButton.enabled=YES;
                        subscriberButtonCount.enabled=YES;
                        [kAppDelegate hideProgressHUD];
                    }
                    
                    
                    
                    //  NSLog(@"%@\n%@",array,error);
                    
                }];
            }
            
        }
        
        
        
        
    
    }
    else{
        
        PNConfiguration *configuration=[PNConfiguration configurationWithPublishKey:kPubNubPublishKey subscribeKey:kPubNubSubscribeKey secretKey:kPubNubSecretKey];

      //  PNConfiguration *configuration=[PNConfiguration defaultConfiguration];
        
        [PubNub setConfiguration:configuration];
        
        
        
        
        [PubNub connectWithSuccessBlock:^(NSString *origin) {
            masterChannel=[PNChannel channelWithName:channelName shouldObservePresence:YES];
            
            if (masterChannel) {
                [PubNub subscribeOnChannel:masterChannel withCompletionHandlingBlock:^(PNSubscriptionProcessState state, NSArray *array, PNError *error) {
                    
                    if (!error) {
                       // [self getFullHistoryOfMessages:masterChannel];
                        
                    }
                    else{
                        backButton.enabled=YES;
                        subscriberButtonCount.enabled=YES;
                        [kAppDelegate hideProgressHUD];
                    }
                    
                    
                    
                    //  NSLog(@"%@\n%@",array,error);
                    
                }];
            }
            
            
            
            
     
        } errorBlock:^(PNError *error) {
            [kAppDelegate hideProgressHUD];
            backButton.enabled=YES;
            subscriberButtonCount.enabled=YES;
            UIAlertView *connectionErrorAlert = [UIAlertView new]; connectionErrorAlert.title = [NSString stringWithFormat:@"%@(%@)",
                                                                                                 [error localizedDescription],
                                                                                                 NSStringFromClass([self class])];
            connectionErrorAlert.message = [NSString stringWithFormat:@"Reason:\n%@\n\nSuggestion:\n%@",
                                            [error localizedFailureReason],
                                            [error localizedRecoverySuggestion]]; [connectionErrorAlert addButtonWithTitle:@"OK"];
            [connectionErrorAlert show];
        }];
    }

    
    
//    [PubNub setConfiguration: [PNConfiguration configurationForOrigin:@"pubsub.pubnub.com"
//                                                           publishKey:kPubNubPublishKey
//                                                         subscribeKey:kPubNubSubscribeKey
//                                                            secretKey:kPubNubSecretKey]];
//    
//    [PubNub connect];
//    
//    masterChannel = [PNChannel channelWithName:channelName shouldObservePresence:YES];
//    
//    [PubNub subscribeOnChannel:masterChannel];
    
    //[PubNub sendMessage:@"my_unique_channel_name" toChannel:masterChannel];
    
    
}


//-(void)getMessages1{
//    PNConfiguration *myConfig = [PNConfiguration configurationForOrigin:@"pubsub.pubnub.com"
//                                                             publishKey:@"demo"
//                                                           subscribeKey:@"demo"
//                                                              secretKey:nil];
//    [PubNub setConfiguration:myConfig];
//    [PubNub connect];
//    
//    // #1 Define channel
//    PNChannel *my_channel = [PNChannel channelWithName:@"blus"
//                                 shouldObservePresence:YES];
//    
//    [[PNObservationCenter defaultCenter] addClientConnectionStateObserver:self withCallbackBlock:^(NSString *origin, BOOL connected, PNError *connectionError){
//        if (connected)
//        {
//            NSLog(@"OBSERVER: Successful Connection!");
//            // #2 Subscribe if client connects successfully
//            [PubNub subscribeOnChannel:my_channel];
//        }
//        else if (!connected || connectionError)
//        {
//            NSLog(@"OBSERVER: Error %@, Connection Failed!", connectionError.localizedDescription);
//        }
//    }];
//    
//    // #3 Added Observer to look for subscribe events
//    [[PNObservationCenter defaultCenter] addClientChannelSubscriptionStateObserver:self withCallbackBlock:^(PNSubscriptionProcessState state, NSArray *channels, PNError *error){
//        switch (state) {
//            case PNSubscriptionProcessSubscribedState:
//                NSLog(@"OBSERVER: Subscribed to Channel: %@", channels[0]);
//                break;
//            case PNSubscriptionProcessNotSubscribedState:
//                NSLog(@"OBSERVER: Not subscribed to Channel: %@, Error: %@", channels[0], error);
//                break;
//            case PNSubscriptionProcessWillRestoreState:
//                NSLog(@"OBSERVER: Will re-subscribe to Channel: %@", channels[0]);
//                break;
//            case PNSubscriptionProcessRestoredState:
//                NSLog(@"OBSERVER: Re-subscribed to Channel: %@", channels[0]);
//                break;
//        }
//    }];
//    
//    // #4 Added Observer to look for message received events
//    [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self withBlock:^(PNMessage *message) {
//        NSLog(@"OBSERVER: Channel: %@, Message: %@", message.channel.name, message.message);
//    }];
//}
//    




-(void)getFullHistoryOfMessages:(PNChannel *)channel{
    //float startDateTimeInterval=-CGFLOAT_MAX;
    //float endDateTimeInterval=100;

    //PNDate *start_pn_date = [PNDate dateWithDate:[NSDate dateWithTimeIntervalSinceNow:startDateTimeInterval]];
   // PNDate *end_pn_date = [PNDate dateWithDate:[NSDate date]];
   // PNDate *end_pn_date = [PNDate dateWithDate:[NSDate dateWithTimeIntervalSinceNow:endDateTimeInterval]];

    
    
    
    if (!isInChatRoom) {
        [kAppDelegate hideProgressHUD];

        return;
    }

    
    
    
    [PubNub requestHistoryForChannel:channel from:nil to:nil limit:25 reverseHistory:NO includingTimeToken:YES withCompletionBlock:^(NSArray *messageArray, PNChannel *channel, PNDate *startDate, PNDate *endDate, PNError *error) {
       


        if (isInChatRoom) {
            pn_paging_endDate=startDate;
            
            backButton.enabled=YES;
            subscriberButtonCount.enabled=YES;
            
            if (!chatRoomMessageArray) {
                chatRoomMessageArray=[[NSMutableArray alloc]init];
            }
            
            chatRoomMessageArray=[messageArray mutableCopy];
            [chatRoomTableView reloadData];
            
            
            if (chatRoomMessageArray.count) {
                // [self.chatRoomTableView beginUpdates];
                [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatRoomTableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                //[self.chatRoomTableView endUpdates];
            }
            

        }
        [kAppDelegate hideProgressHUD];
        chatRoomTableView.pageLocked=NO;
        
        
        
        
        
        //[chatRoomTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        
        
    } ];
    

}

-(void)getPreviousMesagesFromPunNub {
    if (pn_paging_endDate)
        
    {
        
        
        chatRoomTableView.pageLocked=YES;
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
        //            float startDateTimeInterval=-CGFLOAT_MAX;
        //            PNDate *start_pn_date = [PNDate dateWithDate:[NSDate dateWithTimeIntervalSinceNow:startDateTimeInterval]];
        
        
        PNDate *date=[PNDate dateWithDate:pn_paging_endDate.date];
        
        
        [PubNub requestHistoryForChannel:masterChannel from:date to:nil limit:25 includingTimeToken:YES withCompletionBlock:^(NSArray *messageArray, PNChannel *channel, PNDate *start_Date, PNDate *end_Date, PNError *error) {
            
            
            if (!isInChatRoom) {
                pn_paging_endDate=start_Date;
                chatRoomTableView.pageLocked=NO;
                bottomView.hidden=YES;
                [activityIndicatorView stopAnimating];
                
                
                [kAppDelegate hideProgressHUD];
                backButton.enabled=YES;
                subscriberButtonCount.enabled=YES;
                
                if (!chatRoomMessageArray) {
                    chatRoomMessageArray=[[NSMutableArray alloc]init];
                }
                
                
                NSMutableArray *objectsArray=[messageArray mutableCopy];
                
                
                objectsArray=[[[objectsArray reverseObjectEnumerator]allObjects] mutableCopy];
                
                for (id object in objectsArray) {
                    
                    [chatRoomMessageArray insertObject:object atIndex:0];
                    
                }
                
                
                //                [chatRoomMessageArray addObjectsFromArray:objectsArray];
                [chatRoomTableView reloadData];
                
                
            }
            
            
            
            
        }];
        
        
        //            [PubNub requestHistoryForChannel:masterChannel from:start_pn_date to:end_pn_date limit:25 includingTimeToken:YES withCompletionBlock:^(NSArray *messageArray, PNChannel *channel, PNDate *startDate, PNDate *endDate, PNError *error) ];
        
        
        
        
        
    }
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return chatRoomMessageArray.count;
    
}

//-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ChatCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChatCellIdentifier"];
//    
//    
//    cell.userNameLabel.textColor=[Utility colorWithHexString:@"616161"];
//    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.5];
//    
//    
//    cell.messageLabel.textColor=[Utility colorWithHexString:@"000000"];
//    cell.messageLabel.font=[UIFont fontWithName:kHelVeticaNeueRegular size:16];
//    cell.messageLabel.numberOfLines=0;
//
//    if (self.chatRoomMessageArray.count>indexPath.row) {
//        
//        id dict=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
//        
//        if ([dict valueForKey:@"message"] && ![[dict valueForKey:@"message"]isEqual:[NSNull null]]) {
//            
//            NSMutableDictionary *messageDict=[dict valueForKey:@"message"];
//            
//            
//            if ([messageDict valueForKey:@"body"] && ![[messageDict valueForKey:@"body"]isEqual:[NSNull null]]) {
//                cell.messageLabel.text=[messageDict valueForKey:@"body"];
//                
//            }
//            
//            
//            NSString *userNameString;
//            
//            if ([messageDict valueForKey:@"user_name"] && ![[messageDict valueForKey:@"user_name"]isEqual:[NSNull null]]) {
//                userNameString=[messageDict valueForKey:@"user_name"];
//            }
//            
//            
//            if ([messageDict valueForKey:@"message_timestamp"] && ![[messageDict valueForKey:@"message_timestamp"]isEqual:[NSNull null]]) {
//                
//                NSString *timeString;
//                
//                NSTimeInterval interval=(long long)[messageDict valueForKey:@"message_timestamp"];
//                NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:interval];
//                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//                [dateFormatter setDateFormat:@"hh:mm"];
//                
//                timeString=[dateFormatter stringFromDate:messageDate];
//                
//                
//                if (userNameString) {
//                    
//                    userNameString=[NSString stringWithFormat:@"%@ at %@",userNameString,timeString];
//                    
//                }
//                else{
//                    userNameString=[NSString stringWithFormat:@"%@",timeString];
//
//                }
//                
//            }
//            cell.userNameLabel.text=userNameString;
//            
//            
//            
//            
//            
//            NSNumber *userIDNum=[messageDict valueForKey:@"id"];
//            BOOL isFromLoginUser=NO;
//            
//            if(userIDNum && userIDNum.intValue== [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
//                isFromLoginUser=YES;
//                
//                
//            }
//            
//            
//            [self setChatCell:cell ForIndexPath:indexPath forText:[messageDict valueForKey:@"body"] isUserMessage:isFromLoginUser];
//            
//            
//        }
//        
//    }
//    
//    //cell.messageLabel.text=
//    
//    
//    
//    return cell;
//    
//    
//}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChatCellIdentifier"];
    
    
    cell.userNameLabel.textColor=[Utility colorWithHexString:@"616161"];
    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.5];
    
    
    cell.messageLabel.textColor=[Utility colorWithHexString:@"000000"];
    cell.messageLabel.font=[UIFont fontWithName:kHelVeticaNeueRegular size:16];
    cell.messageLabel.numberOfLines=0;
    
    cell.messageLabel.delegate = self;
    cell.messageLabel.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;

    cell.messageLabel.textAlignment = NSTextAlignmentLeft;
    //cell.messageLabel.verticalAlignment=TTTAttributedLabelVerticalAlignmentCenter;
    cell.messageLabel.numberOfLines=0;
    cell.messageLabel.textVerticalAlignment=UITextVerticalAlignmentTop;
    [cell.activityIndicatorView stopAnimating];
    
    if (self.chatRoomMessageArray.count>indexPath.row) {
        
        
        id message=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
        
        
        if (message && [message isKindOfClass:[NSDictionary class]]) {
           
            
            if ([message valueForKey:@"message"] && ![[message valueForKey:@"message"]isEqual:[NSNull null]]) {
                
                
                NSMutableDictionary *messageDict=[message valueForKey:@"message"];
                
                
                if ([messageDict valueForKey:@"body"] && ![[messageDict valueForKey:@"body"]isEqual:[NSNull null]]) {
                    cell.messageLabel.text=[messageDict valueForKey:@"body"];
                    
                    NSString *celltext=cell.messageLabel.text;
                    if (celltext && celltext.length<3 ) {
                        cell.messageLabel.textAlignment = NSTextAlignmentRight;

                    }
                    
                }
                
                
                NSString *userNameString;
                
                if ([messageDict valueForKey:@"user_name"] && ![[messageDict valueForKey:@"user_name"]isEqual:[NSNull null]]) {
                    userNameString=[messageDict valueForKey:@"user_name"];
                }
                
                
                if ([messageDict valueForKey:@"message_timestamp"] && ![[messageDict valueForKey:@"message_timestamp"]isEqual:[NSNull null]]) {
                    
                    NSString *messageTime_str=[messageDict valueForKey:@"message_timestamp"];
                    long long messageTime=messageTime_str.longLongValue;
                    
                    NSDate *message_date=[NSDate dateWithTimeIntervalSince1970:messageTime];
                    
                    
                    
//                    NSString *messageDate = [messageDict valueForKey:@"message_date"];
//                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
//                    NSDate *message_date=[dateFormatter dateFromString:messageDate];
                    
                    
                    NSDateFormatter *dateFormatterNew=[[NSDateFormatter alloc]init];
                    [dateFormatterNew setDateFormat:@"h:mm a"];
                   // [dateFormatterNew setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
                    NSString *textLabelDate=[[dateFormatterNew stringFromDate:message_date]uppercaseString];
                    //    NSLog(@"%@",textLabelDate);
                    
                    if (userNameString) {
                        
                        if(textLabelDate)
                            
                            userNameString=[NSString stringWithFormat:@"%@ at %@",userNameString,textLabelDate];
                        
                    }
                    else{
                        if(textLabelDate)
                            
                            userNameString=[NSString stringWithFormat:@"%@",textLabelDate];
                        
                    }
                    
                }
                cell.userNameLabel.text=userNameString;
                
                
                
                
                
                NSString *userIDString;
                
                if ([[messageDict valueForKey:@"user_id"] isKindOfClass:[NSString class]]) {
                    userIDString=[messageDict valueForKey:@"user_id"];
                    
                }
                else{
                    
                    userIDString=[[messageDict valueForKey:@"user_id"] stringValue];
                }
                BOOL isFromLoginUser=NO;
                
                if(userIDString && userIDString.intValue && userIDString.intValue == [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
                    isFromLoginUser=YES;
                    
                    
                }
                
                
                [self setChatCell:cell ForIndexPath:indexPath forDictionary:messageDict isUserMessage:isFromLoginUser];
                
                
                
            }
            
        }
        
        else if (message && [message isKindOfClass:[PNMessage class]]){
            PNMessage *pn_message=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
            
            if (pn_message && ![pn_message isEqual:[NSNull null]]) {
                
                id messageDict=[pn_message.message mutableCopy];
                if (messageDict && [messageDict isKindOfClass:[NSString class]]) {
                    
                    NSData *data=[messageDict dataUsingEncoding:NSUTF8StringEncoding];
                    
                    messageDict =
                    [NSJSONSerialization JSONObjectWithData: data
                                                    options: NSJSONReadingMutableContainers
                                                      error: nil];
                    
                    
                }
                
                
                if ([messageDict valueForKey:@"message"] && ![[messageDict valueForKey:@"message"]isEqual:[NSNull null]]) {
                    cell.messageLabel.text=[messageDict valueForKey:@"message"];
                    
                }
                
                
                NSString *userNameString;
                
                if ([messageDict valueForKey:@"user_name"] && ![[messageDict valueForKey:@"user_name"]isEqual:[NSNull null]]) {
                    userNameString=[messageDict valueForKey:@"user_name"];
                }
                
                
                if ([messageDict valueForKey:@"message_date"] && ![[messageDict valueForKey:@"message_date"]isEqual:[NSNull null]]) {
                    
                    
                    
                    NSString *messageDate = [messageDict valueForKey:@"message_date"];
                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
                    NSDate *message_date=[dateFormatter dateFromString:messageDate];
                    
                    
                    NSDateFormatter *dateFormatterNew=[[NSDateFormatter alloc]init];
                    [dateFormatterNew setDateFormat:@"h:mm a"];
                    
                    NSString *textLabelDate=[[dateFormatterNew stringFromDate:message_date]uppercaseString];
                    //    NSLog(@"%@",textLabelDate);
                    
                    if (userNameString) {
                        
                        if(textLabelDate)
                            
                            userNameString=[NSString stringWithFormat:@"%@ at %@",userNameString,textLabelDate];
                        
                    }
                    else{
                        if(textLabelDate)
                            
                            userNameString=[NSString stringWithFormat:@"%@",textLabelDate];
                        
                    }
                    
                }
                cell.userNameLabel.text=userNameString;
                
                
                
                
                
                NSString *userIDString;
                
                if ([[messageDict valueForKey:@"user_id"] isKindOfClass:[NSString class]]) {
                    userIDString=[messageDict valueForKey:@"user_id"];
                    
                }
                else{
                    
                    userIDString=[[messageDict valueForKey:@"user_id"] stringValue];
                }
                BOOL isFromLoginUser=NO;
                
                if(userIDString && userIDString.intValue && userIDString.intValue == [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
                    isFromLoginUser=YES;
                    
                    
                }
                
                
                [self setChatCell:cell ForIndexPath:indexPath forDictionary:messageDict isUserMessage:isFromLoginUser];
                
                
                
            }
            
        }
       
        
        
    }
  
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


//For PN message



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height=0;
    
    id message1=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
    id messageDict;
    
    if (message1 && [message1 isKindOfClass:[NSDictionary class]]) {
       
        
        if ([message1 valueForKey:@"message"] && ![[message1 valueForKey:@"message"]isEqual:[NSNull null]]) {
            
            
            messageDict=[message1 valueForKey:@"message"];
            
            
            NSString *userIDString;
            
            
            if ([[messageDict valueForKey:@"user_id"] isKindOfClass:[NSString class]]) {
                userIDString=[messageDict valueForKey:@"user_id"];
                
            }
            else{
                
                userIDString=[[messageDict valueForKey:@"user_id"] stringValue];
            }
            BOOL isFromLoginUser=NO;
            
            //   NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id);
            
            if(userIDString && userIDString.intValue== [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
                isFromLoginUser=YES;
                
                
            }
            
            if (!isFromLoginUser) {
                height+=20;
            }
            else{
                
                height+=11;
            }
            
            CGSize messageSize=CGSizeMake(230, 999);

            if ([messageDict valueForKey:@"message_type"] && [[messageDict valueForKey:@"message_type"]isEqualToString:@"image"]) {
                
                
                height+=215;
                
            }
            else{
                
                NSString *messageString=[messageDict valueForKey:@"body"];
                
                // NSString *messageString=[messageDict valueForKey:@"body"];
                
                if (!messageString || messageString.length<1) {
                    messageString=@".";
                }
                
                
                
                CGSize labelSize=[Utility heightOfTextString:messageString andFont:[UIFont fontWithName:kHelVeticaNeueRegular size:16] maxSize:messageSize];
                height+=labelSize.height+18;
                
            }
        }
        
    }
    else if (message1 && [message1 isKindOfClass:[PNMessage class]]){
        PNMessage *message=message1;
        messageDict=[message.message mutableCopy];

        if (messageDict && [messageDict isKindOfClass:[NSString class]]) {
            
            NSData *data=[messageDict dataUsingEncoding:NSUTF8StringEncoding];
            
            messageDict =
            [NSJSONSerialization JSONObjectWithData: data
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
            
            
        }
   
        NSString *userIDString;
        
        
        if ([[messageDict valueForKey:@"user_id"] isKindOfClass:[NSString class]]) {
            userIDString=[messageDict valueForKey:@"user_id"];
            
        }
        else{
            
            userIDString=[[messageDict valueForKey:@"user_id"] stringValue];
        }
        BOOL isFromLoginUser=NO;
        
        //   NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id);
        
        if(userIDString && userIDString.intValue== [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
            isFromLoginUser=YES;
            
            
        }
        
        if (!isFromLoginUser) {
            height+=20;
        }
        else{
            
            height+=11;
        }
        //CGSize messageSize=CGSizeMake(260, 999);
        CGSize messageSize=CGSizeMake(230, 999);
        
        
        if ([messageDict valueForKey:@"type"] && [[messageDict valueForKey:@"type"]isEqualToString:@"image"]) {
            
            
            height+=215;
            
        }
        else{
            
            NSString *messageString=[messageDict valueForKey:@"message"];
            
            // NSString *messageString=[messageDict valueForKey:@"body"];
            
            if (!messageString || messageString.length<1) {
                messageString=@".";
            }
            
            
            
            CGSize labelSize=[Utility heightOfTextString:messageString andFont:[UIFont fontWithName:kHelVeticaNeueRegular size:16] maxSize:messageSize];
            height+=labelSize.height+18;
            
        }
    
    
    }
    
    

    

    
    
    
    return height;
    
    
    //return 67;
    
}


//For API

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGFloat height=0;
//    
//    
//    
//    NSMutableDictionary *dict=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
//    
//    if ([dict valueForKey:@"message"] && ![[dict valueForKey:@"message"]isEqual:[NSNull null]]) {
//        
//        NSMutableDictionary *messageDict=[dict valueForKey:@"message"];
//        
////        
////        if ([messageDict valueForKey:@"body"] && ![[messageDict valueForKey:@"body"]isEqual:[NSNull null]]) {
////            cell.messageLabel.text=[messageDict valueForKey:@"body"];
////            
////        }
//        
//        NSNumber *userIDNum=[messageDict valueForKey:@"id"];
//        BOOL isFromLoginUser=NO;
//        
//        NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id);
//        
////        if(userIDNum && userIDNum.intValue== [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
////            isFromLoginUser=YES;
////            
////            
////        }
//        
//        if (!isFromLoginUser) {
//            height+=18;
//        }
//        CGSize messageSize=CGSizeMake(300, 999);
//        NSString *messageString=@"kahjcvbkjviuihevgiuejkevikuervjkhjkevikviklheiovhioh ijkuevghiouh";
//        
//       // NSString *messageString=[messageDict valueForKey:@"body"];
//        
//        if (!messageString || messageString.length<1) {
//            messageString=@".";
//        }
//       
//
//
//        CGSize labelSize=[Utility heightOfTextString:messageString andFont:[UIFont fontWithName:kHelVeticaNeueRegular size:16] maxSize:messageSize];
//        height+=labelSize.height+18;
//        
//        
//        
//        
//    }
//    
//    return height;
//    
//    
//    //return 67;
//    
//}




-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
    
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    

    
    UIView *customFooterView= [[UIView alloc]initWithFrame:CGRectZero];
    customFooterView.backgroundColor=[UIColor clearColor];;
    return customFooterView;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
 
    if (chatRoomMessageArray.count%25==0) {
        
        //[self getPreviousMesagesFromPunNub];
        
        if (chatRoomTableView.selectedPageNumber>1) {
            bottomView.hidden=NO;
            [activityIndicatorView startAnimating];

        }
        
        chatRoomTableView.pageLocked=YES;
        

        [[NetworkEngine sharedNetworkEngine]getChatMessagesForChatRoom:^(id object) {
            
            NSLog(@"%@",object);
            
            if (isInChatRoom) {
                if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
                    NSMutableArray *messageArray;
                    
                    messageArray=[object mutableCopy];
                    // [chatRoomBubbleTableView reload];
                    
                    if (self.chatRoomMessageArray.count) {
                        messageArray= [[[messageArray reverseObjectEnumerator]allObjects]mutableCopy];
                    }
                    
                    for (id object in messageArray) {
                        
                        [chatRoomMessageArray insertObject:object atIndex:0];
                        
                    }

                    
                    
                    if (chatRoomMessageArray.count && messageArray.count) {
                        
                        [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messageArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

                        
                    }
                    
                    [chatRoomTableView reloadData];
                                      
                }
                
            }
            [kAppDelegate hideProgressHUD];

            chatRoomTableView.pageLocked=NO;

            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
            
        } onError:^(NSError *error) {
            NSLog(@"%@",error);
            [kAppDelegate hideProgressHUD];
            
            chatRoomTableView.pageLocked=NO;
            
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
        } forChatID:chatIDString forPageNumber:chatRoomTableView.selectedPageNumber];
        
        
    }
    
    
}



#pragma mark Set cell

-(void)setChatCell:(ChatCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath forDictionary:(NSDictionary *)messageDict isUserMessage:(BOOL)isFromUser{
    
    
    NSString *newtext=cell.messageLabel.text;

    
    //CGSize messageSize=CGSizeMake(260, 999);
    CGSize messageSize=CGSizeMake(230, 999);


    CGSize labelSize=[Utility heightOfTextString:newtext andFont:cell.messageLabel.font maxSize:messageSize];
    
    int textWidth=labelSize.width;
    int textHeight=labelSize.height;
    
    
//    if (newtext.length==1) {
//         textWidth=9;
//        //textHeight=24;
//    }
//    
//    if (newtext.length==2) {
//        textWidth=17;
//       // textHeight=27;
//
//    }
    
    
    if (textWidth<20) {
        textWidth=20;
//        //Written below
//        if (newtext.length<3) {
//            cell.messageLabel.textAlignment=NSTextAlignmentCenter;
//        }
    }
    
    
    
    
    BOOL isImage=NO;
    
    if ([messageDict valueForKey:@"message_type"] && [[messageDict valueForKey:@"message_type"]isEqualToString:@"image"]) {
        isImage=YES;
        
       
        
        
        
    }
    else{
        [cell.activityIndicatorView stopAnimating];
    }
    
    
    int addedheight=20;
    
//    CGRect bubbleImageFrame=cell.bubbleImageView.frame;
//    //bubbleImageFrame.origin.x=isFromUser?310-(textWidth+28+5):10;
//    bubbleImageFrame.origin.x=isFromUser?305-(textWidth+28+5):15;
//
//    bubbleImageFrame.origin.y=isFromUser?8:addedheight;
//    bubbleImageFrame.size.width=isImage?200+28+5: textWidth+28+5;//isFromUser?0:textWidth+28+5;
//    bubbleImageFrame.size.height=isImage?200+28+5:textHeight+14;//isFromUser?0:textHeight+14;
//    cell.bubbleImageView.frame=bubbleImageFrame;

    
    CGRect bubbleImageFrame=cell.bubbleImageView.frame;
    bubbleImageFrame.origin.x=isFromUser?305-(textWidth+28+5):15;
    bubbleImageFrame.origin.y=isFromUser?8:addedheight;
    bubbleImageFrame.size.width=isImage?200+28+5: textWidth+23;//isFromUser?0:textWidth+28+5;
    bubbleImageFrame.size.height=isImage?200+28+5:textHeight+16;//isFromUser?0:textHeight+14;
    cell.bubbleImageView.frame=bubbleImageFrame;

    
    if (!isFromUser) {
        CGRect userNameFrame=cell.userNameLabel.frame;
        userNameFrame.origin.x=23;//20
        userNameFrame.origin.y=3;
        userNameFrame.size.width=300;
        userNameFrame.size.height=14;
        cell.userNameLabel.frame=userNameFrame;
  
    }
    else
        cell.userNameLabel.frame=CGRectZero;
    
    if (isImage) {
        CGRect activityIndicatorRect=cell.activityIndicatorView.frame;
        activityIndicatorRect.origin.x=150;
        activityIndicatorRect.origin.y=(cell.bubbleImageView.frame.origin.y+6)+90;
        cell.activityIndicatorView.frame=activityIndicatorRect;
        [cell.activityIndicatorView startAnimating];
    }
    else{
        cell.activityIndicatorView.frame=CGRectZero;
        [cell.activityIndicatorView stopAnimating];
    }
    
    //    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)

//    UIImage *bubbleImage =[[UIImage imageNamed:isFromUser?kGreyBubbleImage:kBlueBubbleImage]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    UIImage *bubbleImage;
    if (isFromUser) {
        bubbleImage=[[UIImage imageNamed:kGreyBubbleImage]resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,22,20)];
 
    }
    else{
        bubbleImage=[[UIImage imageNamed:kBlueBubbleImage]resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,22,20)];

    }

    cell.bubbleImageView.image=bubbleImage;

    
    
    if ([messageDict valueForKey:@"message_type"] && [[messageDict valueForKey:@"message_type"]isEqualToString:@"image"]) {
        
        CGRect pictureFrame=cell.pictureImageView.frame;
        
//        pictureFrame.origin.x=cell.bubbleImageView.frame.origin.x+16;
        pictureFrame.origin.y=cell.bubbleImageView.frame.origin.y+6;
        pictureFrame.origin.x=60;
        pictureFrame.size.width=200;
        pictureFrame.size.height=200;
        cell.pictureImageView.frame=pictureFrame;
         cell.bubbleImageView.image=nil;
        cell.pictureImageView.image=nil;
        UIImage *localImage;
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"image_url == %@",[messageDict valueForKey:@"body"]];
        
        NSArray *predicateArray=[imageArray filteredArrayUsingPredicate:predicate];
        if (predicateArray.count) {
            
         
            NSMutableDictionary *imageDict=[predicateArray objectAtIndex:0];
            
            if ([imageDict valueForKey:@"image"] && ![[imageDict valueForKey:@"image"]isEqual:[NSNull null]]) {
                
                localImage=(UIImage *)[imageDict valueForKey:@"image"];
                
                
            }
            
            
        }
        
        
        if (localImage) {
            
            
            cell.pictureImageView.image=localImage;
            [cell.activityIndicatorView stopAnimating];

            
        }
        else{
            
            NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[messageDict valueForKey:@"body"]]];
            
            typeof (cell.pictureImageView) weakSelf=(cell.pictureImageView);
            typeof (cell.activityIndicatorView) weakSelfIndicator=(cell.activityIndicatorView);

            [weakSelfIndicator startAnimating];
            
            
            [cell.pictureImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                weakSelf.image=image;
                [weakSelfIndicator stopAnimating];

                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                //[activityIndicatorView stopAnimating];
                [weakSelfIndicator stopAnimating];

            }];
        }
        
        
 
        
        cell.messageLabel.frame=CGRectZero;
        
        
    }
    else{

//        CGRect messageLabelFrame=cell.messageLabel.frame;
//        
//        messageLabelFrame.origin.x=cell.bubbleImageView.frame.origin.x+13+3;//16;
//        messageLabelFrame.origin.y=cell.bubbleImageView.frame.origin.y+4;//6;
//        messageLabelFrame.size.width=textWidth+5;//isFromUser?labelSize.width+5:labelSize.width+5;
//        messageLabelFrame.size.height=textHeight+3;//isFromUser?labelSize.height:labelSize.height;
//        cell.messageLabel.frame=messageLabelFrame;
        
        
        
        CGRect messageLabelFrame=cell.messageLabel.frame;
        
        messageLabelFrame.origin.x=cell.bubbleImageView.frame.origin.x+11;//16;
        messageLabelFrame.origin.y=cell.bubbleImageView.frame.origin.y+4;//6;
        messageLabelFrame.size.width=textWidth+5;//isFromUser?labelSize.width+5:labelSize.width+5;
        messageLabelFrame.size.height=textHeight+3;//isFromUser?labelSize.height:labelSize.height;
        cell.messageLabel.frame=messageLabelFrame;

     //   cell.messageLabel.backgroundColor=[UIColor greenColor];
        
        cell.pictureImageView.frame=CGRectZero;
        
        
        
        
        
    }
    
    if (newtext.length<3 && newtext.length>0 && !isImage) {
        
        CGRect messageLabelFrame=cell.messageLabel.frame;
        
        messageLabelFrame.origin.x=cell.bubbleImageView.frame.origin.x;
        messageLabelFrame.origin.y=cell.bubbleImageView.frame.origin.y-2;
        messageLabelFrame.size.width=cell.bubbleImageView.frame.size.width;
        messageLabelFrame.size.height=cell.bubbleImageView.frame.size.height;
        cell.messageLabel.frame=messageLabelFrame;


        NSMutableAttributedString *fullString=[[NSMutableAttributedString alloc]initWithString:newtext];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        
        NSRange range=NSMakeRange(0, fullString.length);
        if (range.location!=NSNotFound) {
            [fullString addAttribute:(NSString *)NSParagraphStyleAttributeName value:paragraphStyle range:range];
            [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"000000"].CGColor range:range];
            [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueRegular size:16] range:range];
            
            
            [cell.messageLabel setAttributedText:fullString];
  
        }
        
        
        
    }
    
                            
    
    
//    CGRect topLeftImageFrame=cell.topLeftImageView.frame;
//    topLeftImageFrame.origin.x=isFromUser?300-28-textWidth:10.5;
//    topLeftImageFrame.origin.y=isFromUser?10:addedheight;
//    topLeftImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
//    topLeftImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5;
//    cell.topLeftImageView.frame=topLeftImageFrame;
//    
//    
//    CGRect topRightImageFrame=cell.topRightImageView.frame;
//    topRightImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+cell.topLeftImageView.frame.size.width: cell.topLeftImageView.frame.origin.x+(textWidth/2)+14;
//    topRightImageFrame.origin.y=isFromUser?cell.topLeftImageView.frame.origin.y:addedheight;
//    topRightImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
//    topRightImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5;
//    
//    cell.topRightImageView.frame=topRightImageFrame;
//    
//    
//    
//    
//    // 3 is added in height
//    // 1 is redcued in height
//    CGRect bottomLeftImageFrame=cell.bottomLeftImageView.frame;
//    bottomLeftImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x:10;
//    bottomLeftImageFrame.origin.y=isFromUser?cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height:cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height;
//    bottomLeftImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
//    bottomLeftImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5+3;
//    
//    cell.bottomLeftImageView.frame=bottomLeftImageFrame;
//    
//    
//    CGRect bottomRightImageFrame=cell.bottomRightImageView.frame;
//    bottomRightImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+cell.topLeftImageView.frame.size.width: cell.topRightImageView.frame.origin.x;
//    bottomRightImageFrame.origin.y=isFromUser?cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height:cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height;
//    bottomRightImageFrame.size.width=isFromUser?(textWidth/2)+14+1:(textWidth/2)+14;
//    bottomRightImageFrame.size.height=isFromUser?(textHeight/2)+5+2:(textHeight/2)+5;;
//    
//    cell.bottomRightImageView.frame=bottomRightImageFrame;
//    
//    
//    
//    
//    
//    UIImage *otherTopLeftImage = [[UIImage imageNamed:kOtherTopLeft]
//                                 resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 0, 0)];
//    
//    UIImage *otherTopRightImage = [[UIImage imageNamed:kOtherTopRight]
//                                  resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0, 0, 16)];
//    
//    UIImage *otherBottomLeftImage = [[UIImage imageNamed:kOtherBottomLeft]
//                                    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 17, 1)];
//    
//    UIImage *otherBottomRightImage = [[UIImage imageNamed:kOtherBottomRight]
//                                     resizableImageWithCapInsets:UIEdgeInsetsMake(0,0 , 16, 15)];
//
//    
//    UIImage *userTopLeftImage = [[UIImage imageNamed:kUserTopLeft]
//                       resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 0, 0)];
//    
//    UIImage *userTopRightImage = [[UIImage imageNamed:kUserTopRight]
//                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0, 0, 16)];
//    
//    UIImage *userBottomLeftImage = [[UIImage imageNamed:kUserBottomLeft]
//                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 16, 0)];
//    
//    UIImage *userBottomRightImage = [[UIImage imageNamed:kUserBottomRight]
//                        resizableImageWithCapInsets:UIEdgeInsetsMake(0,0 , 16, 15)];
//    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//    
//    
//    
//    cell.topLeftImageView.image=(isFromUser)?userTopLeftImage:otherTopLeftImage;
//    cell.topRightImageView.image=(isFromUser)?userTopRightImage:otherTopRightImage;
//    cell.bottomLeftImageView.image=(isFromUser)?userBottomLeftImage:otherBottomLeftImage;
//    cell.bottomRightImageView.image=(isFromUser)?userBottomRightImage:otherBottomRightImage;
    
    
    
    
//    cell.topLeftImageView.image=[UIImage imageNamed: (isFromUser)?kUserTopLeft:kOtherTopLeft];
//    cell.topRightImageView.image=[UIImage imageNamed: (isFromUser)?kUserTopRight:kOtherTopRight];
//    cell.bottomLeftImageView.image=[UIImage imageNamed: (isFromUser)?kUserBottomLeft:kOtherBottomLeft];
//    cell.bottomRightImageView.image=[UIImage imageNamed: (isFromUser)?kUserBottomRight:kOtherBottomRight];
    
    
//    CGRect messageLabelFrame=cell.messageLabel.frame;
//    
//    messageLabelFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+14:10+14;
//    messageLabelFrame.origin.y=isFromUser?cell.topLeftImageView.frame.origin.y+5:cell.topLeftImageView.frame.origin.y+5;
//    messageLabelFrame.size.width=isFromUser?labelSize.width+5:labelSize.width+5;
//    messageLabelFrame.size.height=isFromUser?labelSize.height:labelSize.height;
//    
//    cell.messageLabel.frame=messageLabelFrame;
    
    
    
}


#pragma mark UITextField Deleagte Methods



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
 
    
    [UIView animateWithDuration:0.2 delay:0.05 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect messageContainerFrame=self.messageConatinerView.frame;
        messageContainerFrame.origin.y-=216;
        self.messageConatinerView.frame=messageContainerFrame;
        
        
        
        if (chatRoomMessageArray.count>0) {
            
            [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatRoomTableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            
        }
        


        
    } completion:nil];
    
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
  //  [self.view removeGestureRecognizer:panGestureRecognizer];
    
    
    
    
    
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    if (searchString.length>0) {
        
        
        sendMessageButton.enabled=YES;
        
    }
    else{
        sendMessageButton.enabled=NO;
    }
    
    return YES;
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self lowerDownBottomView];
    
    return [textField resignFirstResponder];
    
}




#pragma mark Button Pressed Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
    // profilePageTableView.scrollEnabled=NO;
    
    
   // if (!chatRoomTableView.isScrolling) {
    
        [PubNub unsubscribeFromChannel:masterChannel];
       // [PubNub disconnect];
        
        //    [PubNub unsubscribeFromChannel:masterChannel withCompletionHandlingBlock:^(NSArray *array, PNError *error) {
        //        NSLog(@"%@",array);
        //    }];
    
        chatRoomTableView.scrollEnabled=NO;
        chatRoomTableView.pagingDelegate=nil;
        chatRoomTableView.dataSource=nil;

        [self.view removeKeyboardControl];
        [self.navigationController popViewControllerAnimated:YES];

    //}
    
}



-(void)subscribersCountButtonPressed:(UIButton *)sender{
   
    HYSubscribersListViewController *subscribersVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"subscribers_vc"];
    subscribersVC.chat_id_string=chatIDString;
    subscribersVC.subscribersCountString=self.subscribersCountString;
    
    [self.navigationController pushViewController:subscribersVC animated:YES];
    
    
    
}


-(IBAction)attachFileButtonPressed:(UIButton *)sender{
    
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Existing",nil];
    
    [popup showInView:self.view];
    
    
    
}



-(IBAction)sendMessageButtonPressed:(UIButton *)sender{
    
    if (messagetextField.text.length<1) {
        
        return;
        
    }
    sender.enabled=NO;
    [self sendMessageOnHashyAPI ];

    
//    [messagetextField resignFirstResponder];
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
////        CGRect messageContainerFrame=self.messageConatinerView.frame;
////        messageContainerFrame.origin.y+=216;
////        self.messageConatinerView.frame=messageContainerFrame;
//        
//        CGRect tableFrame=self.chatRoomTableView.frame;
//        tableFrame.origin.y=0;
//        self.chatRoomTableView.frame=tableFrame;
//        
//    } completion:nil];
//
    
    
  
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    [dateFormatter setTimeZone:gmt];
//    
//    
//    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
//    
//    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
//    [messageDict setValue:messagetextField.text forKey:@"message"];
//    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.stringValue forKey:@"user_id"];
//    [messageDict setValue:dateString forKey:@"message_date"];
//    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].userName forKey:@"user_name"];
//    [messageDict setValue:@"text" forKey:@"type"];

    
    
    
  //  [self publishOnPubNubAPI:messageDict forChannel:masterChannel];
    
    
    
    
    
}

-(void)publishOnPubNubAPI:(NSMutableDictionary *)messageDict forChannel:(PNChannel *)channel{
 
    
    [PubNub sendMessage:messageDict toChannel:channel withCompletionBlock:^(PNMessageState messageState, id response) {
        
        
        if (messageState==PNMessageSent) {
            
            
            
        }
        
        
    }];
    
}


#pragma mark Image Upload Method


#pragma mark TTTAttributedLabel



- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{

    
    NSLog(@"%@",url);
    
    if (url) {
        
        
        [[UIApplication sharedApplication]openURL:url];
        
        
    }
    
    
    
}
- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithAddress:(NSDictionary *)addressComponents{
    
    
    NSLog(@"%@",addressComponents);

    
}


- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithPhoneNumber:(NSString *)phoneNumber{
    
    
    NSLog(@"%@",phoneNumber);
    
    if (phoneNumber) {
        
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
        } else {
            
            [Utility showAlertWithString:@"Your device doesn't support this feature."];
            
           
        }

    }
    
    

    
}


- (void)attributedLabel:(TTTAttributedLabel *)label
  didSelectLinkWithDate:(NSDate *)date{
    
    NSLog(@"%@",date);

}


- (void)attributedLabel:(TTTAttributedLabel *)label
  didSelectLinkWithDate:(NSDate *)date
               timeZone:(NSTimeZone *)timeZone
               duration:(NSTimeInterval)duration{
    
    
    NSLog(@"%@",date);

    
}


- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    
    NSLog(@"%@",result);

    
}

//
//#pragma mark UISwipeGestureReconizer Methods
//
//-(void)screenSwipedDown:(UIGestureRecognizer *)gestureRecognizer{
//  
//    
//    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
//        
//        CGPoint location=[panGestureRecognizer locationInView:self.view];
//        NSRange yAxisRange;
//        
//        if (!IS_IPHONE_5) {
//            yAxisRange=NSMakeRange(0,150);
//
//        }
//        else{
//            
//            yAxisRange=NSMakeRange(0,200);
//
//        }
//        
//        // BOOL isInXAxisRange = NSLocationInRange(location.x, xAxisRange);
//        BOOL isInYAxisRange = NSLocationInRange(location.y, yAxisRange);
//        
//        
//        if (isInYAxisRange) {
//            
//            CGPoint location=[panGestureRecognizer locationInView:self.view];
//            
//            swipeStarted=YES;
//            yLocationDifference=location.y;
//            
//            
//        }
//        
//        
//    }
//    else if (gestureRecognizer.state==UIGestureRecognizerStateChanged){
//        
//        
//        if (swipeStarted && yLocationDifference>0) {
//            
//            CGPoint location=[panGestureRecognizer locationInView:self.view];
//            
//            float checkDifferenceValue= yLocationDifference - location.y;
//            
//            if (checkDifferenceValue>70) {
//                
//                swipeStarted=NO;
//                yLocationDifference=0;
//                [self lowerDownBottomView];
//                
//                
//                
//            }
//            
//            
//            
//        }
//        
//        
//    }
//    else if (gestureRecognizer.state==UIGestureRecognizerStateEnded){
//        
//        if (swipeStarted && yLocationDifference>0) {
//            
//            CGPoint location=[panGestureRecognizer locationInView:self.view];
//            
//            float checkDifferenceValue = yLocationDifference -  location.y ;
//            
//            
//            
//            if (checkDifferenceValue>= 70) {
//                
//                swipeStarted=NO;
//                yLocationDifference=0;
//                [self lowerDownBottomView];
//
//            }
////            else{
////                swipeStarted=NO;
////                yLocationDifference=0;
////                [self performSelector:@selector(moveHeadlineViewToItsOriginalPositionInDuration:) withObject:nil afterDelay:0];
////                
////            }
//            
//            
//            
//            
//            
//        }
//        else{
//            swipeStarted=NO;
//            yLocationDifference=0;
//          //  [self lowerDownBottomView];
//
//            
//            
//        }
//        
//        
//        
//    }
//    else if (gestureRecognizer.state==UIGestureRecognizerStateCancelled){
//        
//        
//        swipeStarted=NO;
//        yLocationDifference=0;
//       // [self lowerDownBottomView];
//
//        
//    }
//    else if (gestureRecognizer.state==UIGestureRecognizerStateFailed){
//        swipeStarted=NO;
//        yLocationDifference=0;
//       // [self lowerDownBottomView];
//
//        
//    }
//    
//    
//    
//}


-(void)lowerDownBottomView{
    
    
    [messagetextField resignFirstResponder];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect messageContainerFrame=self.messageConatinerView.frame;
        messageContainerFrame.origin.y=[[UIScreen mainScreen]bounds].size.height-45;
        self.messageConatinerView.frame=messageContainerFrame;
        
        CGRect tableFrame=self.chatRoomTableView.frame;
        tableFrame.origin.y=0;
        self.chatRoomTableView.frame=tableFrame;
        
        //        CGRect tableFrame=self.chatRoomTableView.frame;
        //        tableFrame.origin.y-=153;
        //        self.chatRoomTableView.frame=tableFrame;
    } completion:nil];
    
    
}



#pragma mark UIactionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //[self openCamera];
            [self openPhoneCamera];
            break;
        case 1:
            //[self openPhotoLibrary];
            [self openPhonePhotoLibrary];
            break;
            
            break;
        default:
            break;
    }
}


- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
    
    editedImage=image;
    isImageSelectedFromDevice=YES;
    
    [self hideImagePicker];
    
    [self uploadImageOnAmazon:image];
    
    
}

- (void)hideImagePicker{
    
    [imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


#pragma mark UIImagePicker Contrller Methods

-(void) openCamera{
    
    
    if (!imagePicker) {
        imagePicker = [[GKImagePicker alloc] init];
        
    }
    imagePicker.imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
    imagePicker.resizeableCropArea = YES;
    
    // imagePicker.cropSize = CGSizeMake(300 ,300);
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker.imagePickerController animated:YES completion:nil];
    
    
    
    
    
}


-(void)openPhoneCamera{
    
    UIImagePickerController *pickerController;//=[[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (pickerController==nil) {
            pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            pickerController.delegate = self;
            pickerController.showsCameraControls = YES;
          //  pickerController.allowsEditing = YES;
            
        }// create once!
        
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    
}

-(void)openPhonePhotoLibrary{
    
    
    UIImagePickerController *pickerController;//=[[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (pickerController==nil) {
            pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

            pickerController.delegate = self;
           
            //pickerController.allowsEditing = YES;
        }// create once!
        
        [self presentViewController:pickerController animated:YES completion:nil];
    }

}


-(void)openPhotoLibrary{
    
    
    
    if (!imagePicker) {
        imagePicker = [[GKImagePicker alloc] init];
        
    }
    imagePicker.imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.resizeableCropArea = YES;
    
    imagePicker.cropSize = CGSizeMake(300 ,300);
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker.imagePickerController animated:YES completion:nil];
    
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img)
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    editedImage=img;

    isImageSelectedFromDevice=YES;
    

    
    [self uploadImageOnAmazon:editedImage];

    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark Disappear Methods

-(void)uploadImageOnAmazon:(UIImage *)image
{

    
    if (image) {
        [[NetworkEngine sharedNetworkEngine]saveAmazoneURLImageInChatRoomScreen:image completionBlock:^(NSString *url) {
            
            NSLog(@"Image Uploaded");
            if (url) {
                
                //  [self sendImageonPubNub:image andImageURL:url];
                [self sendImageOnHashyAPI:image andImageURL:url];
                
            }
            else{
                [kAppDelegate hideProgressHUD];
                
            }
            
        } onError:^(NSError *error) {
            
            
            [kAppDelegate hideProgressHUD];
            
            
        }];
    }
    
    
    
 
    
}

#pragma mark NOtification Methods


-(void)checkForTableOffset{
    
    if (messageConatinerView.frame.origin.y==[[UIScreen mainScreen] bounds].size.height-messageConatinerView.frame.size.height) {
        
        NSLog(@"Message container down");
        if (chatRoomMessageArray.count) {
            [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatRoomTableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            
        }
        
        
    }
    
    else{
        
        typeof (self.chatRoomTableView) weakSelfTableView=self.chatRoomTableView;
        
        if (IS_IPHONE_5) {
            //For iphone 5 keyboard show
            
            if (weakSelfTableView.contentSize.height<230) {
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=0;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            else if (weakSelfTableView.contentSize.height>=230 && weakSelfTableView.contentSize.height<290){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-60;
                
                weakSelfTableView.frame = tableViewFrame;
                
            }
            
            else if (weakSelfTableView.contentSize.height>=290 && weakSelfTableView.contentSize.height<350){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-150+10;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            
            else if (weakSelfTableView.contentSize.height>=350 && weakSelfTableView.contentSize.height<410){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-210+10;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            else{
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-216;//90;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            
            
        }
        else{
            //For iphone 4 keyboard show
            
            
            if (weakSelfTableView.contentSize.height<150) {
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=0;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            else if (weakSelfTableView.contentSize.height>=150 && weakSelfTableView.contentSize.height<210){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-60;
                
                weakSelfTableView.frame = tableViewFrame;
                
            }
            
            else if (weakSelfTableView.contentSize.height>=210 && weakSelfTableView.contentSize.height<270){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-150+10;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            
            else if (weakSelfTableView.contentSize.height>=270 && weakSelfTableView.contentSize.height<330){
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-210+10;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            else{
                
                CGRect tableViewFrame =weakSelfTableView.frame;
                tableViewFrame.origin.y=-216;//90;
                
                weakSelfTableView.frame = tableViewFrame;
            }
            
            
            
        }
        
    }
    
    
    
    
    
}

-(void)insertNewMessage:(NSNotification *)notification{
    
    
    // NSLog(@"%@",notification);
    // NSLog(@"%@",notification.userInfo);
    
    
    NSMutableDictionary *messageDict=[notification.userInfo mutableCopy];
    
    if([messageDict valueForKey:@"message"] && ![[messageDict valueForKey:@"message"]isEqual:[NSNull null]])
        
        
    {
        PNMessage *new_message=[messageDict valueForKey:@"message"];
        
        
        if (new_message.channel.name && [new_message.channel.name isEqualToString:chatIDString]) {
            if (!chatRoomMessageArray) {
                chatRoomMessageArray =[[NSMutableArray alloc]init];
            }
            
            id messageDetails=new_message.message;
            if (messageDetails) {
                NSArray *array=[messageDetails componentsSeparatedByString:@":::"];
                
                
                if (array.count==5) {
                    
                    
                    NSString *messageString=[array objectAtIndex:0];
                    NSString *userNameString=[array objectAtIndex:1];
                    NSString *user_id_str=[array objectAtIndex:2];
                    NSString *messageDate=[array objectAtIndex:3];
                    NSString *messageType=[array objectAtIndex:4];
                    
                    
                    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
                    [messageDict setValue:messageString forKey:@"body"];
                    [messageDict setValue:userNameString forKey:@"user_name"];
                    [messageDict setValue:user_id_str forKey:@"user_id"];
                    [messageDict setValue:messageDate forKey:@"message_timestamp"];
                    [messageDict setValue:messageType forKey:@"message_type"];
                    
                    
                    NSMutableDictionary *messageDetailDict=[[NSMutableDictionary alloc]init];
                    
                    [messageDetailDict setValue:messageDict forKey:@"message"];
                    
                    
                    [chatRoomMessageArray  addObject:messageDetailDict];
                   
                    if (chatRoomMessageArray.count && isInChatRoom) {
                        
                        
                        [chatRoomTableView beginUpdates];
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:chatRoomMessageArray.count-1 inSection:0];
                        
                        [chatRoomTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                        
                        [chatRoomTableView endUpdates];
                        
                        // [self.chatRoomTableView beginUpdates];
                        [chatRoomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatRoomTableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                        
                        
                        //[self.chatRoomTableView endUpdates];
                    }
                    
                  //  [chatRoomTableView reloadData];
                    [self checkForTableOffset];
                    
                    
                    
                    
                    
                }
                
            }
            
            
 
        }
        
     
        
        
    }
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.view removeKeyboardControl];
    isInChatRoom=NO;
    
    messagetextField.text=@"";
    [self lowerDownBottomView];
   // [self.view removeGestureRecognizer:panGestureRecognizer];

    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}


-(void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
