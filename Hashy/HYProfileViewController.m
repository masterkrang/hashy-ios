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
@synthesize editUserProfileImageButton;
@synthesize userNameLabel;
@synthesize userStatusImageView;
@synthesize profileHeaderView;
@synthesize userDetailDict;
@synthesize recentChatArray;
@synthesize profileAvatarImageView;


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
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Profile";
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    [userProfileImageButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setBarButtonItems];
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((userProfileImageButton.frame.size.width/2)-5,(userProfileImageButton.frame.size.height/2)-5,10,10)];
    activityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    [userProfileImageButton addSubview:activityIndicatorView];

   
    [profilePageTableView setupTablePaging];
    profilePageTableView.pagingDelegate=self;

  //  NSLog(@"%@",profilePageTableView);
    [self getProfileDetails];
    
	// Do any additional setup after loading the view.
}

-(void)getUserRecentChats:(NSString *)user_id forPageNumber:(int)page_number{
    
    
    
    profilePageTableView.pageLocked=YES;
    
    
    [[NetworkEngine sharedNetworkEngine]getRecentChatsForAUser:^(id object) {
        
        NSLog(@"%@",object);
        profilePageTableView.pageLocked=NO;
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (selectedPageNumber==1)
                [self.recentChatArray removeAllObjects];
            
            if (!self.recentChatArray) {
                
                self.recentChatArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.recentChatArray addObjectsFromArray:[object mutableCopy]];
            // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.profilePageTableView reloadData];
            self.profilePageTableView.pageLocked=NO;
            if (objectsArray.count>24) {
                
                selectedPageNumber+=1;
                
                [self getUserRecentChats:user_id forPageNumber:selectedPageNumber];
                
                
            }
            
            
            
        }
        
    } onError:^(NSError *error) {
        profilePageTableView.pageLocked=NO;

        NSLog(@"%@",error);

        
    } forUserID:user_id forPageNumber:page_number];
    
}


-(void)getProfileDetails{
    
    
    NSString *userID=[NSString stringWithFormat:@"%d",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id.intValue];
    
    
    [[NetworkEngine sharedNetworkEngine]getUserProfile:^(id object) {
        
        if ([object valueForKey:@"user"] && ![[object valueForKey:@"user"]isEqual:[NSNull null]]) {
            
            self.userDetailDict=[object valueForKey:@"user"];
            
            if ([self.userDetailDict valueForKey:@"id"] && ![[self.userDetailDict valueForKey:@"id"]isEqual:[NSNull null]]) {
                
                NSString *userID=[[self.userDetailDict valueForKey:@"id"]stringValue ];
                [self getUserRecentChats:userID forPageNumber:selectedPageNumber];

            }
            
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
        
    } forUserID:userID];
    
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return recentChatArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ProfileCellIdentifier"];
    
    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    
    [mutParaStyle setAlignment:NSTextAlignmentLeft];
    
    
    NSMutableAttributedString *liveShowString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"cooldude69: what's up people"]];
//    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
    
    //[liveShowString addAttribute:NSFontAttributeName value:kRobotoFontBold(40) range:[liveShowString.string rangeOfString:@"what's up people"]];
    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor lightGrayColor].CGColor range:[liveShowString.string rangeOfString:@"cooldude69:"]];

    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor darkGrayColor].CGColor range:[liveShowString.string rangeOfString:@"what's up people"]];
    [liveShowString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                              forKey:NSParagraphStyleAttributeName]
                            range:NSMakeRange(0,[[liveShowString string] length])];
    [cell.userNameLabel setAttributedText:liveShowString];

    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 54;
    

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

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}


#pragma mark Set cell

-(void)setCell:(ProfileCustomCell *)cell forIndexPath:(NSIndexPath *)indexPath forDict:(NSMutableDictionary *)hashTagDict{
    
    NSString *count=@"1,123";
    
    CGSize labelSize=[Utility heightOfTextString:count andFont:cell.subscribersCount.font maxSize:CGSizeMake(300, 999)];
    
    
    CGRect subCountFrame=cell.subscribersCount.frame;
    
    subCountFrame.origin.x=305-labelSize.width;
    subCountFrame.size.width=labelSize.width+3;
    cell.subscribersCount.frame=subCountFrame;
    
    
    CGRect onlineImageFrame=cell.statusImageView.frame;
    onlineImageFrame.origin.x=cell.subscribersCount.frame.origin.x-14;
    cell.statusImageView.frame=onlineImageFrame;
    
    
    
    cell.subscribersCount.text=count;
    
    
    CGRect userFrame=cell.userNameLabel.frame;
    userFrame.size.width=cell.statusImageView.frame.origin.x-userFrame.origin.x-2;
    cell.userNameLabel.frame=userFrame;
    
    // cell.userNameLabel.backgroundColor=[UIColor orangeColor];
    
    
    
    if ([hashTagDict valueForKey:@"subscribers_count"] && ![[hashTagDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]]) {
        
        
        
    }
    
    
}





#pragma mark UIbutton Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
   // profilePageTableView.scrollEnabled=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)settingsButtonPressed:(UIButton *)sender
{
    
//    HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
//    [self.navigationController pushViewController:listChatVC animated:YES];
    
    
    
}


-(IBAction)editButtonPressed:(UIButton *)sender
{
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    selectedPageNumber=1;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
