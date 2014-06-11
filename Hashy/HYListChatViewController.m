//
//  HYListChatViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "HYListChatViewController.h"

@interface HYListChatViewController ()

@end

@implementation HYListChatViewController
@synthesize searchTextField;
@synthesize hashTagListArray;
@synthesize bottomView;
@synthesize listChatTableView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




-(void) setBarButtonItems{
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"listChat_hashtag_icon.png"] style:UIBarButtonItemStyleDone target:self action:@selector(hashTagButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
}


-(void)setPaddingView{
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    paddingView.backgroundColor = [UIColor clearColor];
    
    UIImageView *searchIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9,8, 12,12 )];
    searchIconImageView.image=[UIImage imageNamed:@"listChat_search_icon.png"];
    [paddingView addSubview:searchIconImageView];
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)numberFormatter{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    selectedPageNumber=1;
    self.listChatTableView.selectedPageNumber=1;
    
    [self getListOfChatsForPageNumber:self.listChatTableView.selectedPageNumber];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"#hashy";
    
    [self setPaddingView];
    [self setBarButtonItems];
    selectedPageNumber=1;
    
    
    [self.listChatTableView setupTablePaging];
    self.listChatTableView.pagingDelegate=self;
    self.listChatTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];
    

    if (!self.hashTagListArray) {
        self.hashTagListArray=[[NSMutableArray alloc]init];
        
    }
    
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;

    bottomView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];

    
    
    self.view.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    self.listChatTableView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];

	// Do any additional setup after loading the view.
}

#pragma mark API methods


-(void)searchChannels:(NSString *)searched_text forPageNumber:(int)pageNumber{
    
    [[[[NetworkEngine sharedNetworkEngine]httpManager]operationQueue]cancelAllOperations];

    [[NetworkEngine sharedNetworkEngine]searchChannels:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (pageNumber==1)
            [self.hashTagListArray removeAllObjects];
            
            if (!self.hashTagListArray) {
                
                self.hashTagListArray=[[NSMutableArray alloc]init];
                
                
            }
            
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.hashTagListArray addObjectsFromArray:objectsArray];
            [self.listChatTableView reloadData];
            self.listChatTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
//            if (objectsArray.count>24) {
//                
//                selectedPageNumber+=1;
//                
//                [self searchChannels:searched_text forPageNumber:selectedPageNumber];
//                
//                
//            }
//            
            
            
            
        }
        
    } onError:^(NSError *error) {
        
        
        NSLog(@"%@",error);
        
    } forSearchedText:searched_text forPageNumber:pageNumber];
    
}

-(void)getListOfChatsForPageNumber:(int) pageNumber{
    
    if (pageNumber>1) {
        [activityIndicatorView startAnimating];

        bottomView.hidden=NO;


    }

    [[NetworkEngine sharedNetworkEngine]getChatLists:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
         
            if (pageNumber==1) {
                [hashTagListArray removeAllObjects];
                
            }
            if (!self.hashTagListArray) {
              
                self.hashTagListArray=[[NSMutableArray alloc]init];
                
                
            }
            
           
            
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.hashTagListArray addObjectsFromArray:objectsArray];
            [self.listChatTableView reloadData];
            self.listChatTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
            
        }
        
        
    } onError:^(NSError *error) {
        self.listChatTableView.pageLocked=YES;
        bottomView.hidden=YES;
        
        [activityIndicatorView stopAnimating];

        NSLog(@"%@",error);
    } forPageNumber:pageNumber forSearchedText:nil];
    
    
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hashTagListArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ListChatCellIdentifier"];
   
    cell.hashTaglabel.font=[UIFont fontWithName:kHelVeticaBold size:22.2];
    cell.hashTaglabel.textColor=[Utility colorWithHexString:@"939393"];
    
    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.6];
    
    
    cell.subscribersCount.textColor=[Utility colorWithHexString:@"2fc81e"];
    cell.subscribersCount.font=[UIFont fontWithName:kHelVeticaNeueMedium size:17];

    
    if (self.hashTagListArray.count>indexPath.row) {
        
        NSMutableDictionary *channelDict=[self.hashTagListArray objectAtIndex:indexPath.row];
        
        
        if ([channelDict valueForKey:@"channel"] && ![[channelDict valueForKey:@"channel"]isEqual:[NSNull null]]) {
           
            
            
            NSMutableDictionary *hashTagDict=[[channelDict valueForKey:@"channel"] mutableCopy];
            
            if ([hashTagDict valueForKey:@"name"] && ![[hashTagDict valueForKey:@"name"] isEqual:[NSNull null]]) {
                
                
                NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
                
                [mutParaStyle setAlignment:NSTextAlignmentLeft];
                NSString *searchedtext;
                
                if (searchTextField.text.length<1) {
                    cell.hashTaglabel.text=[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]];
                }
                else{
                searchedtext=[NSString stringWithFormat:@"#%@",searchTextField.text];
                
                
                
                NSString *hashTagString=[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]];
//                NSRange range=[hashTagString rangeOfString:searchedtext];
//                    
//                    if (range.location!=NSNotFound) {
//                        hashTagString=[hashTagString substringWithRange:range];
//
//                    }
                    
                
                NSMutableAttributedString *fullString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]]];
                //    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
                
               // [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"cecece"].CGColor range:[fullString.string rangeOfString:[NSString stringWithFormat:@"%@:",searchedtext]]];
                
                    NSRange hashTagRange=[fullString.string rangeOfString:hashTagString];
                    if (hashTagRange.location!=NSNotFound) {
                        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"d0d0d0"].CGColor range:hashTagRange];
                        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaBold size:22.5] range:hashTagRange];


                    }
                    
                
                    NSRange searchTextRange=[fullString.string rangeOfString:searchedtext];
                    if (searchTextRange.location!=NSNotFound) {
                        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"939393"].CGColor range:searchTextRange];
                        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaBold size:22.5] range:searchTextRange];

                    }
                    

                
                [fullString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                                          forKey:NSParagraphStyleAttributeName]
                                        range:NSMakeRange(0,[[fullString string] length])];
                [cell.hashTaglabel setAttributedText:fullString];
                }
                //cell.hashTaglabel.text=[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]];
            }
            
            
            
            
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
    
    
    
    if (self.hashTagListArray.count>indexPath.row) {
        
        
        NSMutableDictionary *channelDict=[self.hashTagListArray objectAtIndex:indexPath.row];

        
        if (channelDict && ![channelDict isEqual:[NSNull null]]) {
            
            NSMutableDictionary *detailChannelDict=[channelDict valueForKey:@"channel"];
            NSLog(@"%@",detailChannelDict);
            
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




-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

 
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    return headerView;
    
    
}


-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    
//    UIView *customFooterView= [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-20, 320, 20)];
//    
//    customFooterView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];;
//    
//    if (!self.listChatTableView.activityIndicator) {
//        self.listChatTableView.activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        self.listChatTableView.activityIndicator.frame=CGRectMake(100,0,100, 30);
//
//    }
//    [customFooterView addSubview:self.listChatTableView.activityIndicator];
//    
//    if (self.listChatTableView.pageLocked && selectedPageNumber>1) {
//        [self.listChatTableView.activityIndicator startAnimating];
//    }
//    else{
//        [self.listChatTableView.activityIndicator stopAnimating];
//    }
    
    
    UIView *customFooterView= [[UIView alloc]initWithFrame:CGRectMake(0,0 , 0   ,  1)];
    customFooterView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];;
    return customFooterView;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
    
    
}





-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
 
    NSLog(@"Reached end");
    
    
    if (searchTextField.text.length>0) {
       
        
        if (self.hashTagListArray.count%25==0) {
            
            //selectedPageNumber+=1;
            [self searchChannels:searchTextField.text forPageNumber:self.listChatTableView.selectedPageNumber];

            
            
        }

        
    }
    else{
        
        
        if (self.hashTagListArray.count%25==0) {
            
            [self getListOfChatsForPageNumber:self.listChatTableView.selectedPageNumber];

            
            
        }

        
    }
    
    
}


#pragma mark Set Cell


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
    
    
    
   
    
    
}

#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:kCharacterSetString];
    NSRange r = [string rangeOfCharacterFromSet:s];
    if ((r.location != NSNotFound) || [string isEqualToString:@""]) {
        // NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        
        NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
        selectedPageNumber=1;
        self.listChatTableView.selectedPageNumber=1;

        [self searchChannels:searchString forPageNumber:selectedPageNumber];

//        if (searchString && searchString.length>0) {
//            
//        }
        return YES;
        
        
    }
    else{
        
        return NO;
    }

    
    
//    NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
//    
//    
//    [self searchChannels:searchString forPageNumber:1];
//    
//    
//    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}



#pragma mark Button Presed Methods

-(IBAction)settingsButtonPressed:(UIButton *)sender
{
    
   // [self.navigationController popViewControllerAnimated:YES];
    HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
    NSNumber *user_id_num=[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_id;
    int user_int=user_id_num.intValue;
    profileVC.user_id=[NSString stringWithFormat:@"%d",user_int];
    
    
    [self.navigationController pushViewController:profileVC animated:YES];

    
}


-(IBAction)hashTagButtonPressed:(UIButton *)sender{
    
    
//    HYSubscribersListViewController *subscribersVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"subscribers_vc"];
//    [self.navigationController pushViewController:subscribersVC animated:YES];
    
    
    HYCreateChatViewController *createChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"createChat_vc"];
    [self.navigationController pushViewController:createChatVC animated:YES];
    
    
 
    
}


-(void)getChatWithID:(NSString *)chatIDString{
    
    [[NetworkEngine sharedNetworkEngine]getChatForChatRoom:^(id object) {
        
        NSLog(@"%@",object);
        
        
       [[NetworkEngine sharedNetworkEngine]getChatMessagesForChatRoom:^(id object) {
           
           NSLog(@"%@",object);

       } onError:^(NSError *error) {
           NSLog(@"%@",error);

       } forChatID:@"11" forPageNumber:1];
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        
    } forChatID:chatIDString forPageNumber:1];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    selectedPageNumber=1;
    self.listChatTableView.selectedPageNumber=1;
    searchTextField.text=@"";
    [searchTextField resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
