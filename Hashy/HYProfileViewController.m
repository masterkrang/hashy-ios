//
//  HYProfileViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "HYProfileViewController.h"

@interface HYProfileViewController ()

@end

@implementation HYProfileViewController
@synthesize profilePageTableView;
@synthesize userProfileImageButton;
@synthesize userNameLabel;
@synthesize userStatusImageView;
@synthesize profileHeaderView;
@synthesize userDetailDict;
@synthesize recentChatArray;
@synthesize profileAvatarImageView;
@synthesize bottomView;
@synthesize user_id;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setBarButtonItems{
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
//    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed:)];
//    self.navigationItem.rightBarButtonItem=rightBarButtonItem;

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    self.profilePageTableView.scrollEnabled=YES;
    NSNumber *login_user_id_num=[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id;
    int login_user_id_int=login_user_id_num.intValue;
    
   
    
    profilePageTableView.selectedPageNumber=1;
    
    [self getUserRecentChats:user_id forPageNumber:profilePageTableView.selectedPageNumber];

}

-(void)setProfileScreenUI{
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;
    bottomView.backgroundColor=[UIColor clearColor];
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];//[Utility colorWithHexString:@"f2f2f2"];
    self.profilePageTableView.backgroundColor=[UIColor whiteColor];//[Utility colorWithHexString:@"f2f2f2"];
    
    if (!IS_IPHONE_5) {
        
        CGRect tableFrame=self.profilePageTableView.frame;
        tableFrame.size.height=[[UIScreen mainScreen]bounds].size.height-(profileHeaderView.frame.size.height+profileHeaderView.frame.origin.y);
        tableFrame.size.height=[[UIScreen mainScreen]bounds].size.height-(profileHeaderView.frame.size.height);

        self.profilePageTableView.frame=tableFrame;
        
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Profile";

    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    [userProfileImageButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setBarButtonItems];
   
    [self setProfileScreenUI];
    
    
   
    [profilePageTableView setupTablePaging];
    profilePageTableView.pagingDelegate=self;
    [self getProfileDetails:user_id];
    
	// Do any additional setup after loading the view.
}

-(void)getUserRecentChats:(NSString *)user_id_str forPageNumber:(int)page_number{
    
    
    if (page_number>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];

    }
    
    
    [[NetworkEngine sharedNetworkEngine]getRecentChatsForAUser:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (profilePageTableView.selectedPageNumber==1)
                [self.recentChatArray removeAllObjects];
            
            if (!self.recentChatArray) {
                
                self.recentChatArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.recentChatArray addObjectsFromArray:objectsArray];
            // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.profilePageTableView reloadData];
            self.profilePageTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
            
        }
        
    } onError:^(NSError *error) {
        profilePageTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
        NSLog(@"%@",error);

        
    } forUserID:user_id_str forPageNumber:page_number];
    
}


-(void)getProfileDetails:(NSString *)user_id_str{
    
    
    
    
    [[NetworkEngine sharedNetworkEngine]getUserProfile:^(id object) {
        
        if ([object valueForKey:@"user"] && ![[object valueForKey:@"user"]isEqual:[NSNull null]]) {
            
            self.userDetailDict=[object valueForKey:@"user"];

//            if ([self.userDetailDict valueForKey:@"id"] && ![[self.userDetailDict valueForKey:@"id"]isEqual:[NSNull null]]) {
//                
//                NSString *userID=[[self.userDetailDict valueForKey:@"id"]stringValue ];
//                [self getUserRecentChats:userID forPageNumber:selectedPageNumber];
//
//            }
            
            if ([self.userDetailDict valueForKey:@"avatar_url"] && ![[self.userDetailDict valueForKey:@"avatar_url"]isEqual:[NSNull null]]) {
                NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[self.userDetailDict valueForKey:@"avatar_url"]]];
               __weak typeof (profileAvatarImageView) weakSelf=profileAvatarImageView;
                __weak typeof (activityIndicatorView) weakSelfActivityIndocator=activityIndicatorView;

                [activityIndicatorView startAnimating];

                [self.profileAvatarImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                    [weakSelfActivityIndocator stopAnimating];
 
                    weakSelf.image=image;
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    [weakSelfActivityIndocator stopAnimating];

                    
                    NSLog(@"%@",error);
                    
                    
                }];

            }
            
            if ([self.userDetailDict valueForKey:@"user_name"] && ![[self.userDetailDict valueForKey:@"user_name"]isEqual:[NSNull null]]) {
                self.userNameLabel.text=[self.userDetailDict valueForKey:@"user_name"];
                
            }
            
            
        }
        
        
        
    } onError:^(NSError *error) {
        
    } forUserID:user_id_str];
    
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return recentChatArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ProfileCellIdentifier"];
    
    cell.hashTaglabel.font=[UIFont fontWithName:kHelVeticaBold size:22.2];
    cell.hashTaglabel.textColor=[Utility colorWithHexString:@"939393"];
    
    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.6];
    
    
    cell.subscribersCount.textColor=[Utility colorWithHexString:@"2fc81e"];
    cell.subscribersCount.font=[UIFont fontWithName:kHelVeticaNeueMedium size:17];
    
    
    if (self.recentChatArray.count>indexPath.row) {
        
        NSMutableDictionary *channelDict=[self.recentChatArray objectAtIndex:indexPath.row];
        
        
        if ([channelDict valueForKey:@"channel"] && ![[channelDict valueForKey:@"channel"]isEqual:[NSNull null]]) {
            
            
            
            NSMutableDictionary *hashTagDict=[[channelDict valueForKey:@"channel"] mutableCopy];
            
            if ([hashTagDict valueForKey:@"name"] && ![[hashTagDict valueForKey:@"name"] isEqual:[NSNull null]])                     cell.hashTaglabel.text=[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]];
            else
            cell.hashTaglabel.text=@"";
            
            
            
            NSString *lastMessageUserName=[hashTagDict valueForKey:@"last_message_user_name"];
            NSString *lastMessageString=[hashTagDict valueForKey:@"last_message"];
            
            
            if (lastMessageUserName && ![lastMessageUserName isEqual:[NSNull null]] &&lastMessageString && ![lastMessageString isEqual:[NSNull null]]) {
                
                
                NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
                
                [mutParaStyle setAlignment:NSTextAlignmentLeft];
                
                
                NSMutableAttributedString *liveShowString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",lastMessageUserName,lastMessageString]];
                //    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
                
                
                NSRange user_name_range=[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%@:",lastMessageUserName]];
                
                
                
                
                NSRange messageRange=[liveShowString.string rangeOfString:lastMessageString];
                
                if (messageRange.location!=NSNotFound) {
                    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"9a9a9a"].CGColor range:messageRange];
                    [liveShowString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueMedium size:10.5] range:messageRange];
                    
                    
                }
                
                if (user_name_range.location!=NSNotFound) {
                    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"cecece"].CGColor range:user_name_range];
                    [liveShowString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueMedium size:10.5] range:user_name_range];
                    
                }
                
                
                
                [liveShowString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                                          forKey:NSParagraphStyleAttributeName]
                                        range:NSMakeRange(0,[[liveShowString string] length])];
                [cell.userNameLabel setAttributedText:liveShowString];
                
                
                
            }
            
            
            [self setCell:cell forIndexPath:indexPath forDict:hashTagDict];
            
            
        }
    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (self.recentChatArray.count>indexPath.row) {
        
        
        NSMutableDictionary *channelDict=[self.recentChatArray objectAtIndex:indexPath.row];
        
        
        if (channelDict && ![channelDict isEqual:[NSNull null]]) {
            
            NSMutableDictionary *detailChannelDict=[channelDict valueForKey:@"channel"];
            
            HYChatRoomDetailsViewController *chatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"chatRoomDetails_vc"];
            
            
            if ([detailChannelDict valueForKey:@"name"] && ![[detailChannelDict valueForKey:@"name"]isEqual:[NSNull null]] && [[detailChannelDict valueForKey:@"name"] length]>0){
                
                chatVC.chatNameString=[detailChannelDict valueForKey:@"name"];
                
            }
            else{
                chatVC.chatNameString=@"name";
                
            }
            
            
            NSNumber *chat_id_number=[detailChannelDict valueForKey:@"id"];
            int chat_id=chat_id_number.intValue;
            
            if (chat_id && chat_id>0) {
                chatVC.chatIDString=[NSString stringWithFormat:@"%d",chat_id];
                
            }
            
            
            NSString *count=@"";
            
            if ([detailChannelDict valueForKey:@"subscribers_count"] && ![[detailChannelDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]]) {
                
                NSNumber *sub_count_num=[detailChannelDict valueForKey:@"subscribers_count"];
                int subscribers_count_int=sub_count_num.intValue;
                
                
                count=[NSString stringWithFormat:@"%d",subscribers_count_int];
                
            }
            else{
                
                count=@"0";
                
            }
            
            
            chatVC.subscribersCountString=count;
            
            
            chatVC.chatDict=detailChannelDict;
            
            
            
            [self.navigationController pushViewController:chatVC animated:YES];
            // [self getChatWithID:[detailChannelDict valueForKey:@"id"]];
            
            
            
            
            
            
        }
        
        
        
        
        
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 54;
    

}





-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
    
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
    if (recentChatArray.count%25==0) {
        
        
        [self getUserRecentChats:user_id forPageNumber:profilePageTableView.selectedPageNumber];
        
        
        
        
    }
    
    
}

#pragma mark Set cell

-(void)setCell:(ProfileCustomCell *)cell forIndexPath:(NSIndexPath *)indexPath forDict:(NSMutableDictionary *)hashTagDict{
    
    NSString *count=@"";
    
    if ([hashTagDict valueForKey:@"subscribers_count"] && ![[hashTagDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]]) {
        
        NSNumber *sub_count_num=[hashTagDict valueForKey:@"subscribers_count"];
        int subscribers_count_int=sub_count_num.intValue;
        
        
        count=[NSString stringWithFormat:@"%d",subscribers_count_int];
        
    }
    else{
        
        count=@"0";
        
    }
    
    cell.subscribersCount.text=count;

    CGSize labelSize=[Utility heightOfTextString:count andFont:cell.subscribersCount.font maxSize:CGSizeMake(300, 999)];
    
    
    CGRect subCountFrame=cell.subscribersCount.frame;
    
    subCountFrame.origin.x=305-labelSize.width;
    subCountFrame.size.width=labelSize.width+3;
    cell.subscribersCount.frame=subCountFrame;
    
    
    CGRect onlineImageFrame=cell.statusImageView.frame;
    onlineImageFrame.origin.x=cell.subscribersCount.frame.origin.x-14;
    cell.statusImageView.frame=onlineImageFrame;
    
    
    
    
    
    CGRect userFrame=cell.userNameLabel.frame;
    userFrame.size.width=cell.statusImageView.frame.origin.x-userFrame.origin.x-2;
    cell.userNameLabel.frame=userFrame;
    
    

    
    
}





#pragma mark UIbutton Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
    profilePageTableView.scrollEnabled=NO;
    profilePageTableView.pagingDelegate=nil;
    profilePageTableView.dataSource=nil;

    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)settingsButtonPressed:(UIButton *)sender
{
    
//    HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
//    [self.navigationController pushViewController:listChatVC animated:YES];
    
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    profilePageTableView.selectedPageNumber=1;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
