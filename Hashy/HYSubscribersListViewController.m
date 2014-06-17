//
//  HYSubscribersListViewController.m
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import "HYSubscribersListViewController.h"

@interface HYSubscribersListViewController ()

@end

@implementation HYSubscribersListViewController
@synthesize subscribersTableView;
@synthesize subscribersListArray;
@synthesize searchTextField;
@synthesize subscribersCountString;
@synthesize searchContainerView;
@synthesize chat_id_string;
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
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    
    paddingView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *searchIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9,8, 12,12 )];
    searchIconImageView.image=[UIImage imageNamed:@"listChat_search_icon.png"];
    [paddingView addSubview:searchIconImageView];
    
    
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    
    searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;

}


-(void)setNavigationBarItems{
    
   
    
    
    subscriberButtonCount=[UIButton buttonWithType:UIButtonTypeCustom];
    subscriberButtonCount.frame=CGRectMake(0, 0, 35+(subscribersCountString.length *6), 40);
    //    subscriberButtonCount.backgroundColor=[UIColor orangeColor];
       [subscriberButtonCount setTitle:subscribersCountString forState:UIControlStateNormal];
    [subscriberButtonCount setTitleColor:[Utility colorWithHexString:kHexValueLightGreenColor] forState:UIControlStateNormal];
    [subscriberButtonCount.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueMedium size:17]];
    subscriberButtonCount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
   
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((subscriberButtonCount.frame.size.width -5 - (subscribersCountString.length+1) *9), 15, 10, 10)];
    [imageView setImage:[UIImage imageNamed:kGreenDot]];
    
    [subscriberButtonCount addSubview:imageView];
    
    
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:subscriberButtonCount];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    self.subscribersTableView.selectedPageNumber=1;
    [self getSubscribersListForChatID:chat_id_string forPageNumber:self.subscribersTableView.selectedPageNumber];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"subscribers";
    [subscribersTableView setupTablePaging];
    subscribersTableView.pagingDelegate=self;
    
    [self setPaddingView];
    
    [self setNavigationBarItems];
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;
    bottomView.backgroundColor=[UIColor clearColor];
    

    subscribersTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];
    
    
    if (!subscribersListArray) {
        self.subscribersListArray=[[NSMutableArray alloc]init];
        
    }
    
    self.subscribersTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];

//    self.subscribersTableView.selectedPageNumber=1;
//    [self getSubscribersListForChatID:chat_id_string forPageNumber:self.subscribersTableView.selectedPageNumber];
//    
    
	// Do any additional setup after loading the view.
}


#pragma mark API Methods

-(void)searchSubscribers:(NSString *)searched_user forPageNumber:(int)page_number{
    

    if (page_number>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
    }
    [[[[NetworkEngine sharedNetworkEngine]httpManager]operationQueue]cancelAllOperations];

    [[NetworkEngine sharedNetworkEngine]searchSubscribers:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (page_number==1)
                [self.subscribersListArray removeAllObjects];
            
            if (!self.subscribersListArray) {
                
                self.subscribersListArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.subscribersListArray addObjectsFromArray:objectsArray];
            // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.subscribersTableView reloadData];
            self.subscribersTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            //            if (objectsArray.count>24) {
            //
            //                selectedPageNumber+=1;
            //
            //                [self searchSubscribers:searched_user forPageNumber:selectedPageNumber];
            //
            //
            //            }
            
            
            
        }
        
    } onError:^(NSError *error) {
        subscribersTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
        NSLog(@"%@",error);
        
    } forChat_id:chat_id_string forSearchedText:searched_user forPageNumber:subscribersTableView.selectedPageNumber];
    
    
    
}

-(void)getSubscribersListForChatID:(NSString *)chat_id forPageNumber:(int)page_number{
    
    if (page_number>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
    }
    
    [[NetworkEngine sharedNetworkEngine]getSubscribersList:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (self.subscribersTableView.selectedPageNumber==1)
                [self.subscribersListArray removeAllObjects];
            
            if (!self.subscribersListArray) {
                
                self.subscribersListArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.subscribersListArray addObjectsFromArray:objectsArray];
           // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.subscribersTableView reloadData];
            self.subscribersTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
        }
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        subscribersTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
    } forChatID:chat_id forPageNumber:page_number];
    
}



#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return subscribersListArray.count;// self.subscribersListArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscribersCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SubscribersCellIdentifier"];
    
    
    cell.userNameLabel.textColor=[Utility colorWithHexString:@"888888"];
    [cell.userNameLabel setFont:[UIFont fontWithName:kHelVeticaNeueRegular size:15.5]];
    [cell.maskButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [cell.maskButton setBackgroundImage:nil forState:UIControlStateSelected];
    cell.userProfilePictureImageView.image=nil;
    
    if (subscribersListArray.count>indexPath.row) {
        
        NSMutableDictionary *userDict=[subscribersListArray objectAtIndex:indexPath.row];
        
        
        if ([userDict valueForKey:@"user"] && ![[userDict valueForKey:@"user"]isEqual:[NSNull null]]) {
            
            NSMutableDictionary *userDetailDict=[userDict valueForKey:@"user"];
            
            
            if ([userDetailDict valueForKey:@"user_name"] && ![[userDetailDict valueForKey:@"user_name"]isEqual:[NSNull null]] && [[userDetailDict valueForKey:@"user_name"] length]>0) {
                
                cell.userNameLabel.text=[userDetailDict valueForKey:@"user_name"];
                
                
            }
            else{
                cell.userNameLabel.text=@"";
            }
            
            
            
            if ([userDetailDict valueForKey:@"avatar_url"] && ![[userDetailDict valueForKey:@"avatar_url"]isEqual:[NSNull null]]) {
                
                
                NSURL *url=[NSURL URLWithString:[userDetailDict valueForKey:@"avatar_url"]];
                
                NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
                
                typeof (cell.userProfilePictureImageView) weakSelf=cell.userProfilePictureImageView;
                [cell.userProfilePictureImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                    weakSelf.image=image;
                    
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                    
                    
                }];
                
                
            }
            
            
        }
        else if ([userDict valueForKey:@"channel_subscription"] && ![[userDict valueForKey:@"channel_subscription"]isEqual:[NSNull null]]){
            
            
            NSMutableDictionary *userDetailDict=[userDict valueForKey:@"channel_subscription"];
            if ([userDetailDict valueForKey:@"user_name"] && ![[userDetailDict valueForKey:@"user_name"]isEqual:[NSNull null]] && [[userDetailDict valueForKey:@"user_name"] length]>0) {
                
                cell.userNameLabel.text=[userDetailDict valueForKey:@"user_name"];
                
                
            }
            else{
                cell.userNameLabel.text=@"";
            }

            
            if ([userDetailDict valueForKey:@"avatar_url"] && ![[userDetailDict valueForKey:@"avatar_url"]isEqual:[NSNull null]]) {
                
                
                NSURL *url=[NSURL URLWithString:[userDetailDict valueForKey:@"avatar_url"]];
                
                NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
                
                typeof (cell.userProfilePictureImageView) weakSelf=cell.userProfilePictureImageView;
                [cell.userProfilePictureImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                    weakSelf.image=image;
                    
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                    
                    
                }];
                
                
            }        }
        
    }
   
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (subscribersListArray.count>indexPath.row) {
        NSMutableDictionary *userDict=[subscribersListArray objectAtIndex:indexPath.row];
        int user_id_int;
        
        if ([userDict valueForKey:@"user"] && ![[userDict valueForKey:@"user"]isEqual:[NSNull null]]) {
            
            NSMutableDictionary *userDetailsDict=[userDict valueForKey:@"user"];
            
            
            if ([userDetailsDict valueForKey:@"id"] && ![[userDetailsDict valueForKey:@"id"]isEqual:[NSNull null]]) {
                
                
                NSNumber *user_id_num=[userDetailsDict valueForKey:@"id"];
                user_id_int=user_id_num.intValue;
                
                
            }
            
            
        }
        else if ([userDict valueForKey:@"channel_subscription"] && ![[userDict valueForKey:@"channel_subscription"]isEqual:[NSNull null]]){
            
            
            NSMutableDictionary *userDetailDict=[userDict valueForKey:@"channel_subscription"];
            
            if ([userDetailDict valueForKey:@"user_id"] && ![[userDetailDict valueForKey:@"user_id"]isEqual:[NSNull null]]) {
                
                
                NSNumber *user_id_num=[userDetailDict valueForKey:@"user_id"];
                user_id_int=user_id_num.intValue;
                
                
            }
            
            
            
        }
        
        if (user_id_int>0) {
            
            HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
            profileVC.user_id=[NSString stringWithFormat:@"%d",user_id_int];
            [self.navigationController pushViewController:profileVC animated:YES];
            
            
        }
        

    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
    
}



-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30)];
    
    headerView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 10, 10)];
    [imageView setImage:[UIImage imageNamed:kGreenDot]];
    
    
    UILabel *subscribersLabel=[[UILabel alloc]initWithFrame:CGRectMake(35,0, 200, 30)];
    subscribersLabel.text=@"SUBSCRIBERS";
    subscribersLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:12.5];;
    subscribersLabel.textColor=[Utility colorWithHexString:@"888888"];;
    
    
    [headerView addSubview:imageView];
    [headerView addSubview:subscribersLabel];
    
    return headerView;
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *customFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.1)];
    customFooterView.backgroundColor=tableView.backgroundColor;// [UIColor greenColor];
    
    
    return customFooterView;
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
    
    if (searchTextField.text.length<1) {
        
        if (subscribersListArray.count%15==0) {
            
            
            [self getSubscribersListForChatID:chat_id_string forPageNumber:subscribersTableView.selectedPageNumber];
            
            
        }

        
    }
    else{
        if (subscribersListArray.count%15==0) {
            
            
            [self searchSubscribers:searchTextField.text forPageNumber:subscribersTableView.selectedPageNumber];
            
            
        }
        

        
    }
}



#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:kCharacterSetString];
    NSRange r = [string rangeOfCharacterFromSet:s];
    if ((r.location != NSNotFound) || [string isEqualToString:@""]) {
        
        
        NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
        subscribersTableView.selectedPageNumber=1;
        
        if (searchString && searchString.length>0) {
            [self searchSubscribers:searchString forPageNumber:subscribersTableView.selectedPageNumber];

        }
        else
            [self getSubscribersListForChatID:chat_id_string forPageNumber:subscribersTableView.selectedPageNumber];
        
        return YES;
        
        
    }
    else{
        
        return NO;
    }

    
    
//    textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
//    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}



#pragma mark Button Pressed Methods


-(void)backButtonPressed:(UIButton *)sender {
    
    self.subscribersTableView.dataSource=nil;
    self.subscribersTableView.pagingDelegate=nil;
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(IBAction)userImageButtonPressed:(UIButton *)sender{
    
    SubscribersCustomCell *cell;
    
    if (isIOSVersion7) {
        cell=(SubscribersCustomCell *) [[[sender superview] superview]superview];
        
    }
    else
        cell=(SubscribersCustomCell *) [[sender superview] superview];
 
    NSIndexPath *indexPath=[subscribersTableView indexPathForCell:cell];
    if (subscribersListArray.count>indexPath.row) {
        
        
        NSMutableDictionary *userDict=[subscribersListArray objectAtIndex:indexPath.row];
        int user_id_int;
        
        if ([userDict valueForKey:@"user"] && ![[userDict valueForKey:@"user"]isEqual:[NSNull null]]) {
            
            NSMutableDictionary *userDetailsDict=[userDict valueForKey:@"user"];
            
            
            if ([userDetailsDict valueForKey:@"id"] && ![[userDetailsDict valueForKey:@"id"]isEqual:[NSNull null]]) {
                
                
                NSNumber *user_id_num=[userDetailsDict valueForKey:@"id"];
                user_id_int=user_id_num.intValue;
                
                
            }
            
            
        }
        else if ([userDict valueForKey:@"channel_subscription"] && ![[userDict valueForKey:@"channel_subscription"]isEqual:[NSNull null]]){
            
            
            NSMutableDictionary *userDetailDict=[userDict valueForKey:@"channel_subscription"];
        
            if ([userDetailDict valueForKey:@"user_id"] && ![[userDetailDict valueForKey:@"user_id"]isEqual:[NSNull null]]) {
                
                
                NSNumber *user_id_num=[userDetailDict valueForKey:@"user_id"];
                user_id_int=user_id_num.intValue;
                
                
            }

            
            
        }
        
        if (user_id_int>0) {
            
        HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
        profileVC.user_id=[NSString stringWithFormat:@"%d",user_id_int];
        [self.navigationController pushViewController:profileVC animated:YES];
            
            
        }
        
        
    }
    
    
    
}


#pragma maark Did Disappear Functions


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    selectedPageNumber=1;
    subscribersTableView.selectedPageNumber=1;
    searchTextField.text=@"";
    [searchTextField resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
