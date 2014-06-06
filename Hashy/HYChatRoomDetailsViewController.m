//
//  HYChatRoomDetailsViewController.m
//  Hashy
//
//  Created by attmac107 on 6/4/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
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
#define kGreyBubbleImage @"chat_room_blue_bubble.png"




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
    [imageView setImage:[UIImage imageNamed:@"profile_green_dot.png"]];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [chatRoomTableView setupTablePaging];
    chatRoomTableView.pagingDelegate=self;
    self.title=[NSString stringWithFormat:@"#%@",chatNameString];
    [self setBarButtonItems];
    [self setPaddingView];
    [self subscribeToPubNubChannel:[chatDict valueForKey:@"name"]];
 //   [self getChatWithID:[chatDict valueForKey:@"id"]];

    
	// Do any additional setup after loading the view.
}



-(void)getMessagesViaAPICall{
    
    [[NetworkEngine sharedNetworkEngine]getChatMessagesForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            self.chatRoomMessageArray=[object mutableCopy];
            // [chatRoomBubbleTableView reload];
            [chatRoomTableView reloadData];
            
            [self subscribeToPubNubChannel:[chatDict valueForKey:@"name"]];
            
        }
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        
    } forChatID:@"11" forPageNumber:1];

}


-(void)getChatWithID:(NSString *)chatIDString{
    
    
    
    
    [[NetworkEngine sharedNetworkEngine]getChatForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
   //     [self subscribeToPubNubChannel:[chatDict valueForKey:@"name"]];

        
        [self getMessagesViaAPICall];
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        
    } forChatID:chatIDString forPageNumber:1];
    
}

#pragma mark Pub Nub Methods

-(void)subscribeToPubNubChannel:(NSString *)channelName{
    
    NSLog(@"Channel Name %@",channelName);
    
    [kAppDelegate showProgressHUD:self.view];
    backButton.enabled=NO;
    subscriberButtonCount.enabled=NO;
    
    [PubNub setConfiguration:[PNConfiguration defaultConfiguration]];
    
    
    
    [PubNub connectWithSuccessBlock:^(NSString *origin) {
        masterChannel=[PNChannel channelWithName:channelName shouldObservePresence:YES];
        
        if (masterChannel) {
            [PubNub subscribeOnChannel:masterChannel withCompletionHandlingBlock:^(PNSubscriptionProcessState state, NSArray *array, PNError *error) {
                
                if (!error) {
                    [self getFullHistoryOfMessages:masterChannel];
                    
                }
                else{
                    backButton.enabled=YES;
                    subscriberButtonCount.enabled=YES;
                    [kAppDelegate hideProgressHUD];
                }
                
                
                
                //  NSLog(@"%@\n%@",array,error);
                
            }];
        }
        
        
 
        
//        // wait 1 second
//        int64_t delayInSeconds = 1.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            
//           // [PubNub subscribeOnChannel:];
//        
//        });
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




-(void)getFullHistoryOfMessages:(PNChannel *)channel{
    
    [PubNub requestFullHistoryForChannel:channel withCompletionBlock:^(NSArray *messageArray, PNChannel *channel, PNDate *startDate, PNDate *endDate, PNError *error) {
        [kAppDelegate hideProgressHUD];
        backButton.enabled=YES;
        subscriberButtonCount.enabled=YES;
        
        if (!chatRoomMessageArray) {
            chatRoomMessageArray=[[NSMutableArray alloc]init];
        }
        
        chatRoomMessageArray=[messageArray mutableCopy];
        [chatRoomTableView reloadData];
        
        
        
    }];
}


#pragma mark UITextField Deleagte Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
   
    
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect messageContainerFrame=self.messageConatinerView.frame;
        messageContainerFrame.origin.y-=217;
        self.messageConatinerView.frame=messageContainerFrame;
        
//        CGRect tableFrame=self.chatRoomTableView.frame;
//        tableFrame.origin.y-=153;
//        self.chatRoomTableView.frame=tableFrame;
    } completion:nil];
    
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect messageContainerFrame=self.messageConatinerView.frame;
        messageContainerFrame.origin.y+=217;
        self.messageConatinerView.frame=messageContainerFrame;
        
//        CGRect tableFrame=self.chatRoomTableView.frame;
//        tableFrame.origin.y-=153;
//        self.chatRoomTableView.frame=tableFrame;
    } completion:nil];

}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
   // textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (messagetextField.text.length>0) {
        
    }
    else{
    
    }
    
    return YES;
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
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
    
    if (self.chatRoomMessageArray.count>indexPath.row) {
        
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
                [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
                NSDate *message_date=[dateFormatter dateFromString:messageDate];
                
                
                NSDateFormatter *dateFormatterNew=[[NSDateFormatter alloc]init];
                [dateFormatterNew setDateFormat:@"hh:mm a"];
                
                NSString *textLabelDate=[[dateFormatterNew stringFromDate:message_date]uppercaseString];
                NSLog(@"%@",textLabelDate);
                
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
            
            
            [self setChatCell:cell ForIndexPath:indexPath forText:[messageDict valueForKey:@"message"] isUserMessage:isFromLoginUser];
            
            
        }
        
    }
    
    //cell.messageLabel.text=
    
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


//For PN message



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height=0;
    
    
    
    PNMessage *message=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
    
    
    
   // NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    id messageDict=[message.message mutableCopy];
    
    if (messageDict && [messageDict isKindOfClass:[NSString class]]) {
        
        NSData *data=[messageDict dataUsingEncoding:NSUTF8StringEncoding];
        
       messageDict =
        [NSJSONSerialization JSONObjectWithData: data
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        

    }
    
    //
    //        if ([messageDict valueForKey:@"body"] && ![[messageDict valueForKey:@"body"]isEqual:[NSNull null]]) {
    //            cell.messageLabel.text=[messageDict valueForKey:@"body"];
    //
    //        }
    
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
    CGSize messageSize=CGSizeMake(260, 999);
    NSString *messageString=[messageDict valueForKey:@"message"];
    
    // NSString *messageString=[messageDict valueForKey:@"body"];
    
    if (!messageString || messageString.length<1) {
        messageString=@".";
    }
    
    
    
    CGSize labelSize=[Utility heightOfTextString:messageString andFont:[UIFont fontWithName:kHelVeticaNeueRegular size:16] maxSize:messageSize];
    height+=labelSize.height+18;
    
    
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


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
    
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
    
    
}

#pragma mark Set cell 

-(void)setChatCell:(ChatCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath forText:(NSString *)messageText isUserMessage:(BOOL)isFromUser{
    
    
  //  NSString *newtext=@"kugwei wugveiwugh vwg i gvw wvg iugvw iugw eiug eiuvwg eiuvwgiuwvg iuvw iugw iugiuwgv iuvwg iuw giuvwg iuwgviugvw iu giug wvio evwio herio hioherioherioheriohegrioh egrioh ";
    NSString *newtext=cell.messageLabel.text;
   // NSString *newtext=@"kvsjc suev ioevr iehrv ihev eov oihvo oehvoherv ";

    
    CGSize messageSize=CGSizeMake(260, 999);
    
   // CGFloat height=[Utility heightOfTextForString:messageText andFont:cell.messageLabel.font maxSize:messageSize];
//    UIFont *font=cell.messageLabel.font;
    CGSize labelSize=[Utility heightOfTextString:newtext andFont:cell.messageLabel.font maxSize:messageSize];
    
    int textWidth=labelSize.width;
    int textHeight=labelSize.height;
    
    
    if (newtext.length==1) {
         textWidth=8;
        //textHeight=24;
    }
    
    if (newtext.length==2) {
        textWidth=16;
       // textHeight=27;

    }
    
    
    
    
    int addedheight=19;
    
    CGRect bubbleImageFrame=cell.bubbleImageView.frame;
    bubbleImageFrame.origin.x=isFromUser?310-(textWidth+28+5):10;
    bubbleImageFrame.origin.y=isFromUser?8:addedheight;
    bubbleImageFrame.size.width=textWidth+28+5;//isFromUser?0:textWidth+28+5;
    bubbleImageFrame.size.height=textHeight+14;//isFromUser?0:textHeight+14;
    cell.bubbleImageView.frame=bubbleImageFrame;
    
    
    if (!isFromUser) {
        CGRect userNameFrame=cell.userNameLabel.frame;
        userNameFrame.origin.x=20;
        userNameFrame.origin.y=3;
        userNameFrame.size.width=300;
        userNameFrame.size.height=14;
        cell.userNameLabel.frame=userNameFrame;
  
    }
    
    UIImage *bubbleImage =[[UIImage imageNamed:isFromUser?kGreyBubbleImage:kBlueBubbleImage]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    cell.bubbleImageView.image=bubbleImage;

                            
    CGRect messageLabelFrame=cell.messageLabel.frame;
                            
    messageLabelFrame.origin.x=cell.bubbleImageView.frame.origin.x+16;
    messageLabelFrame.origin.y=cell.bubbleImageView.frame.origin.y+6;//isFromUser?cell.bubbleImageView.frame.origin.y+5:cell.bubbleImageView.frame.origin.y+5;
    messageLabelFrame.size.width=textWidth+5;//isFromUser?labelSize.width+5:labelSize.width+5;
    messageLabelFrame.size.height=textHeight+3;//isFromUser?labelSize.height:labelSize.height;
    cell.messageLabel.frame=messageLabelFrame;
    
    
    cell.messageLabel.numberOfLines=0;
    cell.messageLabel.textVerticalAlignment=UITextVerticalAlignmentTop;//;=NSTextAlignmentCenter;
    cell.messageLabel.text=newtext;
    
                            
    
    
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



#pragma mark Button Pressed Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
    // profilePageTableView.scrollEnabled=NO;
    
    
    if (!chatRoomTableView.isScrolling) {
        chatRoomTableView.scrollEnabled=NO;
        chatRoomTableView.pagingDelegate=nil;
        [PubNub unsubscribeFromChannel:masterChannel];
        [PubNub disconnect];
        
        //    [PubNub unsubscribeFromChannel:masterChannel withCompletionHandlingBlock:^(NSArray *array, PNError *error) {
        //        NSLog(@"%@",array);
        //    }];
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}



-(void)subscribersCountButtonPressed:(UIButton *)sender{
    
    
}


-(IBAction)attachFileButtonPressed:(UIButton *)sender{
    
    
}



-(IBAction)sendMessageButtonPressed:(UIButton *)sender{
    
    
    [messagetextField resignFirstResponder];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    
    
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    [messageDict setValue:messagetextField.text forKey:@"message"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.stringValue forKey:@"user_id"];
    [messageDict setValue:dateString forKey:@"message_date"];
    [messageDict setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].userName forKey:@"user_name"];
    [messageDict setValue:@"text" forKey:@"type"];

    
    messagetextField.text=@"";
    
    [PubNub sendMessage:messageDict toChannel:masterChannel withCompletionBlock:^(PNMessageState messageState, id response) {
      
        NSLog(@"%@",response);
        
        if (messageState==PNMessageSent) {
            
           // PNMessage *pn_message=response;
            
            if (!chatRoomMessageArray) {
                chatRoomMessageArray=[[NSMutableArray alloc]init];
                
            }
        
            [chatRoomMessageArray  addObject:response];
            [chatRoomTableView beginUpdates];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:chatRoomMessageArray.count-1 inSection:0];
            
            [chatRoomTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            [chatRoomTableView endUpdates];
            
            
            
            
//            chatRoomMessageArray addObject:<#(id)#>
            
        }
        
        
    }];
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
