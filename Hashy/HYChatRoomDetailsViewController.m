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

@interface HYChatRoomDetailsViewController ()

@end

@implementation HYChatRoomDetailsViewController
@synthesize chatRoomTableView;
@synthesize chatDict;
@synthesize chatRoomMessageArray;
@synthesize subscribersCountString;
@synthesize chatNameString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) setBarButtonItems{
    
    
    
    UIButton *subscriberButtonCount=[UIButton buttonWithType:UIButtonTypeCustom];
    subscriberButtonCount.frame=CGRectMake(0, 0, 35+(subscribersCountString.length *6), 40);
    //    subscriberButtonCount.backgroundColor=[UIColor orangeColor];
    [subscriberButtonCount setTitle:subscribersCountString forState:UIControlStateNormal];
    [subscriberButtonCount setTitleColor:[Utility colorWithHexString:kHexValueLightGreenColor] forState:UIControlStateNormal];
    [subscriberButtonCount addTarget:self action:@selector(subscribersCountButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    subscriberButtonCount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((subscriberButtonCount.frame.size.width -5 - (subscribersCountString.length+1) *9), 15, 10, 10)];
    [imageView setImage:[UIImage imageNamed:@"profile_green_dot.png"]];
    
    [subscriberButtonCount addSubview:imageView];
    
    
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
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
    [self getChatWithID:[chatDict valueForKey:@"id"]];

    
	// Do any additional setup after loading the view.
}






-(void)getChatWithID:(NSString *)chatIDString{
    
    [[NetworkEngine sharedNetworkEngine]getChatForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
        
        
        [[NetworkEngine sharedNetworkEngine]getChatMessagesForChatRoom:^(id object) {
            
            NSLog(@"%@",object);
            
            if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
                
                self.chatRoomMessageArray=[object mutableCopy];
                // [chatRoomBubbleTableView reload];
                [chatRoomTableView reloadData];
                
                
                
            }
            
            
        } onError:^(NSError *error) {
            NSLog(@"%@",error);
            
        } forChatID:@"11" forPageNumber:1];
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        
    } forChatID:chatIDString forPageNumber:1];
    
}


#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return chatRoomMessageArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChatCellIdentifier"];
    
    
    cell.userNameLabel.textColor=[Utility colorWithHexString:@"616161"];
    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.5];
    
    
    cell.messageLabel.textColor=[Utility colorWithHexString:@"000000"];
    cell.messageLabel.font=[UIFont fontWithName:kHelVeticaNeueRegular size:16];
    
    if (self.chatRoomMessageArray.count>indexPath.row) {
        
        NSMutableDictionary *dict=[self.chatRoomMessageArray objectAtIndex:indexPath.row];
        
        if ([dict valueForKey:@"message"] && ![[dict valueForKey:@"message"]isEqual:[NSNull null]]) {
            
            NSMutableDictionary *messageDict=[dict valueForKey:@"message"];
            
            
            if ([messageDict valueForKey:@"body"] && ![[messageDict valueForKey:@"body"]isEqual:[NSNull null]]) {
                cell.messageLabel.text=[messageDict valueForKey:@"body"];
                
            }
            
            
            NSString *userNameString;
            
            if ([messageDict valueForKey:@"user_name"] && ![[messageDict valueForKey:@"user_name"]isEqual:[NSNull null]]) {
                userNameString=[messageDict valueForKey:@"user_name"];
            }
            
            
            if ([messageDict valueForKey:@"message_timestamp"] && ![[messageDict valueForKey:@"message_timestamp"]isEqual:[NSNull null]]) {
                
                NSString *timeString;
                
                NSTimeInterval interval=(long long)[messageDict valueForKey:@"message_timestamp"];
                NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:interval];
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"hh:mm"];
                
                timeString=[dateFormatter stringFromDate:messageDate];
                
                
                if (userNameString) {
                    
                    userNameString=[NSString stringWithFormat:@"%@ at %@",userNameString,timeString];
                    
                }
                else{
                    userNameString=[NSString stringWithFormat:@"%@",timeString];

                }
                
            }
            cell.userNameLabel.text=userNameString;
            
            
            
            
            
            NSNumber *userIDNum=[messageDict valueForKey:@"id"];
            BOOL isFromLoginUser=NO;
            
            if(userIDNum && userIDNum.intValue== [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue){
                isFromLoginUser=YES;
                
                
            }
            
            
            [self setChatCell:cell ForIndexPath:indexPath forText:[messageDict valueForKey:@"body"] isUserMessage:isFromLoginUser];
            
            
        }
        
    }
    
    //cell.messageLabel.text=
    
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGFloat height=0;
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
//        NSString *messageString=[messageDict valueForKey:@"body"];
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
    
    
    return 67;
    
}


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
    
    CGSize messageSize=CGSizeMake(300, 999);
    
   // CGFloat height=[Utility heightOfTextForString:messageText andFont:cell.messageLabel.font maxSize:messageSize];
//    UIFont *font=cell.messageLabel.font;
    CGSize labelSize=[Utility heightOfTextString:messageText andFont:cell.messageLabel.font maxSize:messageSize];
    
    int textWidth=labelSize.width;
    int textHeight=labelSize.height;

    
    int addedheight=19;
    
    CGRect userNameFrame=cell.userNameLabel.frame;
    userNameFrame.origin.x=20;
    userNameFrame.origin.y=3;
    userNameFrame.size.width=300;
    userNameFrame.size.height=14;
    cell.userNameLabel.frame=userNameFrame;
    
    CGRect topLeftImageFrame=cell.topLeftImageView.frame;
    topLeftImageFrame.origin.x=isFromUser?300-28-textWidth:10.5;
    topLeftImageFrame.origin.y=isFromUser?10:addedheight;
    topLeftImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
    topLeftImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5;
    cell.topLeftImageView.frame=topLeftImageFrame;
    
    
    CGRect topRightImageFrame=cell.topRightImageView.frame;
    topRightImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+cell.topLeftImageView.frame.size.width: cell.topLeftImageView.frame.origin.x+(textWidth/2)+14;
    topRightImageFrame.origin.y=isFromUser?cell.topLeftImageView.frame.origin.y:addedheight;
    topRightImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
    topRightImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5;
    
    cell.topRightImageView.frame=topRightImageFrame;
    
    
    
    
    // 3 is added in height
    // 1 is redcued in height
    CGRect bottomLeftImageFrame=cell.bottomLeftImageView.frame;
    bottomLeftImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x:10;
    bottomLeftImageFrame.origin.y=isFromUser?cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height:cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height;
    bottomLeftImageFrame.size.width=isFromUser?(textWidth/2)+14:(textWidth/2)+14;
    bottomLeftImageFrame.size.height=isFromUser?(textHeight/2)+5:(textHeight/2)+5+3;
    
    cell.bottomLeftImageView.frame=bottomLeftImageFrame;
    
    
    CGRect bottomRightImageFrame=cell.bottomRightImageView.frame;
    bottomRightImageFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+cell.topLeftImageView.frame.size.width: cell.topRightImageView.frame.origin.x;
    bottomRightImageFrame.origin.y=isFromUser?cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height:cell.topRightImageView.frame.origin.y+cell.topRightImageView.frame.size.height;
    bottomRightImageFrame.size.width=isFromUser?(textWidth/2)+14+1:(textWidth/2)+14;
    bottomRightImageFrame.size.height=isFromUser?(textHeight/2)+5+2:(textHeight/2)+5;;
    
    cell.bottomRightImageView.frame=bottomRightImageFrame;
    
    
    
    
    
    UIImage *otherTopLeftImage = [[UIImage imageNamed:kOtherTopLeft]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 0, 0)];
    
    UIImage *otherTopRightImage = [[UIImage imageNamed:kOtherTopRight]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0, 0, 16)];
    
    UIImage *otherBottomLeftImage = [[UIImage imageNamed:kOtherBottomLeft]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 17, 1)];
    
    UIImage *otherBottomRightImage = [[UIImage imageNamed:kOtherBottomRight]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(0,0 , 16, 15)];

    
    UIImage *userTopLeftImage = [[UIImage imageNamed:kUserTopLeft]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 0, 0)];
    
    UIImage *userTopRightImage = [[UIImage imageNamed:kUserTopRight]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0, 0, 16)];
    
    UIImage *userBottomLeftImage = [[UIImage imageNamed:kUserBottomLeft]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 16, 0)];
    
    UIImage *userBottomRightImage = [[UIImage imageNamed:kUserBottomRight]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(0,0 , 16, 15)];
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    
    
    cell.topLeftImageView.image=(isFromUser)?userTopLeftImage:otherTopLeftImage;
    cell.topRightImageView.image=(isFromUser)?userTopRightImage:otherTopRightImage;
    cell.bottomLeftImageView.image=(isFromUser)?userBottomLeftImage:otherBottomLeftImage;
    cell.bottomRightImageView.image=(isFromUser)?userBottomRightImage:otherBottomRightImage;
    
    
    
    
//    cell.topLeftImageView.image=[UIImage imageNamed: (isFromUser)?kUserTopLeft:kOtherTopLeft];
//    cell.topRightImageView.image=[UIImage imageNamed: (isFromUser)?kUserTopRight:kOtherTopRight];
//    cell.bottomLeftImageView.image=[UIImage imageNamed: (isFromUser)?kUserBottomLeft:kOtherBottomLeft];
//    cell.bottomRightImageView.image=[UIImage imageNamed: (isFromUser)?kUserBottomRight:kOtherBottomRight];
    
    
    CGRect messageLabelFrame=cell.messageLabel.frame;
    
    messageLabelFrame.origin.x=isFromUser?cell.topLeftImageView.frame.origin.x+14:10+14;
    messageLabelFrame.origin.y=isFromUser?cell.topLeftImageView.frame.origin.y+5:cell.topLeftImageView.frame.origin.y+5;
    messageLabelFrame.size.width=isFromUser?labelSize.width+5:labelSize.width+5;
    messageLabelFrame.size.height=isFromUser?labelSize.height:labelSize.height;
    
    cell.messageLabel.frame=messageLabelFrame;
    
    
    
}



#pragma mark Button Pressed Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
    // profilePageTableView.scrollEnabled=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)subscribersCountButtonPressed:(UIButton *)sender{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
