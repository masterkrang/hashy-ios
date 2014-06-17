//
//  HYCreateChatViewController.m
//  Hashy
//
//  Created by Kurt on 5/29/14.
//

#import "HYCreateChatViewController.h"

@interface HYCreateChatViewController ()

@end

@implementation HYCreateChatViewController
@synthesize createChatTableView;
@synthesize searchTextField;
@synthesize createChatArray;
@synthesize searchContainerView;
@synthesize createImageView;
@synthesize createView;
@synthesize createViewButton;
@synthesize channelNameAttributedLabel;
@synthesize bottomView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.createChatTableView.selectedPageNumber=1;
    [self getListOfChatsForPageNumber:self.createChatTableView.selectedPageNumber];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Create";
    [self setBarButtonItems];
  
    [self setBarButtonItems];
    [self setPaddingView];
    [self setViewFontsAndFrames];
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;
    bottomView.backgroundColor=[UIColor clearColor];

    searchContainerView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    self.view.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    self.createChatTableView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    createView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    createButton.enabled=NO;
    createView.hidden=YES;

    [createViewButton addTarget:self action:@selector(createHashTagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    

    
    [createChatTableView setupTablePaging];
    createChatTableView.pagingDelegate=self;

	// Do any additional setup after loading the view.
}



-(void)setBarButtonItems{
    
    //self.title=@"Profile";
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
    createButton=[UIButton buttonWithType:UIButtonTypeCustom];
    createButton.frame=CGRectMake(0, 0, 50, 40);
    [createButton setTitleColor:[Utility colorWithHexString:@"157dfb"] forState:UIControlStateNormal];
    [createButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    [createButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:17]];
    [createButton setTitle:@"Create" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(createHashTagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:createButton];
    
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
}

-(void)setPaddingView{
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    paddingView.backgroundColor = [UIColor clearColor];
    
    UILabel *hashLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 10, 30)];
    hashLabel.text=@"#";
    hashLabel.font=[UIFont fontWithName:kHelVeticaNeueLight size:18];
    hashLabel.textColor=[Utility colorWithHexString:@"b3b3b3"];
    [paddingView addSubview:hashLabel];
    
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;

}


-(void)setViewFontsAndFrames{
    
    [createViewButton setTitleColor:[Utility colorWithHexString:@"228aff"] forState:UIControlStateNormal];
    [createViewButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:36]];
    
    searchTextField.textColor=[Utility colorWithHexString:@"585858"];
    
    channelNameAttributedLabel.textVerticalAlignment=UITextVerticalAlignmentTop;
    
    if (!IS_IPHONE_5) {
        
        self.createImageView.hidden=YES;
        
        CGRect createButtonFrame=self.createViewButton.frame;
        createButtonFrame.origin.y-=120;
        self.createViewButton.frame=createButtonFrame;
        
        
        CGRect channelNameAttFrame=self.channelNameAttributedLabel.frame;
        channelNameAttFrame.origin.y-=120;
        self.channelNameAttributedLabel.frame=channelNameAttFrame;
        
        
    }

    
    
}


-(void)setCreateViewText{
    if (searchTextField.text.length<1)
        return;
    
    channelNameAttributedLabel.textAlignment=NSTextAlignmentCenter;

    NSString *searchedText=[NSString stringWithFormat:@"#%@",searchTextField.text];
    NSString *notFoundText=@"not found, create it?";
    NSMutableAttributedString *fullString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@" ,searchedText,notFoundText]];
  //  NSMutableAttributedString *fullString = [[NSMutableAttributedString alloc]initWithString:@"Hi"];

    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [fullString addAttribute:(NSString *)NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, fullString.string.length)];
    
    NSRange search_text_range=[fullString.string rangeOfString:searchedText];
    if (search_text_range.location!=NSNotFound) {
        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"464646"].CGColor range:search_text_range];
        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueMedium size:19.5] range:search_text_range];
        
        
    }
    
    
    NSRange not_found_range=[fullString.string rangeOfString:notFoundText];

    if (not_found_range.location!=NSNotFound) {
        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"858585"].CGColor range:not_found_range];
        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueLight size:19.5] range:not_found_range];
        
        
    }
    
    
    [channelNameAttributedLabel setNumberOfLines:2];
    [channelNameAttributedLabel setAttributedText:fullString];
    channelNameAttributedLabel.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
  
}



#pragma mark API methods


-(void)createNewChannel{
    
    
    if (searchTextField.text.length<1) {
        return;
    }
    
    NSMutableDictionary *nameDict=[[NSMutableDictionary alloc]init];
    [nameDict setValue:searchTextField.text forKey:@"name"];
    
    
    NSMutableDictionary *channelDict=[[NSMutableDictionary alloc]init];
    [channelDict setValue:nameDict forKey:@"channel"];
    
    
    
    [[NetworkEngine sharedNetworkEngine]createNewHashTag:^(id object) {
        
      //  NSLog(@"%@",object);
        
        if ([object valueForKey:@"channel"] && ![[object valueForKey:@"channel"]isEqual:[NSNull null]])
        {
            
            NSMutableDictionary *detailChannelDict=[object valueForKey:@"channel"];
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
            
            
            if ([detailChannelDict valueForKey:@"subscribers_count"] && ![[detailChannelDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]] ) {
                NSNumber *sub_count_num=[detailChannelDict valueForKey:@"subscribers_count"];
                int subscribers_count_int=sub_count_num.intValue;
                
                
                chatVC.subscribersCountString=[NSString stringWithFormat:@"%d",subscribers_count_int];

                
                
            }
            else{
                
                chatVC.subscribersCountString=@"0";
                
            }
            chatVC.chatDict=detailChannelDict;
            
            
            
            [self.navigationController pushViewController:chatVC animated:YES];
            
            
            
            
            
            
        }
        
        
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        
    } params:channelDict];
    
}


-(void)getListOfChatsForPageNumber:(int) pageNumber{
    
    
    if (pageNumber>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
        
    }
    createButton.enabled=NO;
    [[NetworkEngine sharedNetworkEngine]getChatLists:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            if (pageNumber==1) {
                [createChatArray removeAllObjects];
                
            }
            if (!self.createChatArray) {
                
                self.createChatArray=[[NSMutableArray alloc]init];
                
                
            }
            
            
            
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.createChatArray addObjectsFromArray:objectsArray];
            [self.createChatTableView reloadData];
            self.createChatTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
        }
        
        
    } onError:^(NSError *error) {
        self.createChatTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
        NSLog(@"%@",error);
    } forPageNumber:pageNumber forSearchedText:nil];
    
    
}


-(void)searchChannels:(NSString *)searched_text forPageNumber:(int)page_number{
    
    resultsObtained=NO;
//    createChatTableView.pageLocked=YES;
    
    
    if (page_number>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
    }
    createButton.enabled=NO;
    
    [[[[NetworkEngine sharedNetworkEngine]httpManager]operationQueue]cancelAllOperations];
    
    [[NetworkEngine sharedNetworkEngine]searchChannels:^(id object) {
        
        NSLog(@"%@",object);
            resultsObtained=YES;
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (createChatTableView.selectedPageNumber==1)
            [self.createChatArray removeAllObjects];
            
            if (!self.createChatArray) {
                
                self.createChatArray=[[NSMutableArray alloc]init];
                
                
            }
            
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.createChatArray addObjectsFromArray:objectsArray];

            if (resultsObtained && !createChatArray.count) {
                createButton.enabled=YES;
                createView.hidden=NO;
                [self setCreateViewText];
                
            }
            else{
                
                createButton.enabled=NO;
                createView.hidden=YES;
            }
            
            [self.createChatTableView reloadData];
            self.createChatTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];

            
            
        }
        
    } onError:^(NSError *error) {
        
        createChatTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
        NSLog(@"%@",error);
        
    } forSearchedText:searched_text forPageNumber:page_number];
    
}


#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return createChatArray.count;// self.subscribersListArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateChatCellIdentifier"];
    
    cell.hashTaglabel.font=[UIFont fontWithName:kHelVeticaBold size:22.2];
    cell.hashTaglabel.textColor=[Utility colorWithHexString:@"939393"];
    
    cell.userNameLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:10.6];
    
    
    cell.subscribersCount.textColor=[Utility colorWithHexString:@"2fc81e"];
    cell.subscribersCount.font=[UIFont fontWithName:kHelVeticaNeueMedium size:17];
    
    
    if (self.createChatArray.count>indexPath.row) {
        
        NSMutableDictionary *channelDict=[self.createChatArray objectAtIndex:indexPath.row];
        
        
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
                    NSMutableAttributedString *fullString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]]];

                
                    
                    NSRange hash_tag_range=[hashTagString rangeOfString:hashTagString];
                    
                    if (hash_tag_range.location!=NSNotFound) {
                        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"d0d0d0"].CGColor range:hash_tag_range];
                        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaBold size:22.5] range:hash_tag_range];


                    }
                    
                    NSRange searched_text_range=[fullString.string rangeOfString:searchedtext];
                    
                    if (searched_text_range.location!=NSNotFound) {
                        
                        [fullString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"939393"].CGColor range:searched_text_range];
                        
                        [fullString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaBold size:22.5] range:searched_text_range];

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
                
                
              
                
                NSRange messageRange=[liveShowString.string rangeOfString:lastMessageString];

                if (messageRange.location!=NSNotFound ) {
                    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"9a9a9a"].CGColor range:messageRange];
                    [liveShowString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueMedium size:10.5] range:messageRange];


                }
                
                NSRange userNameRange=[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%@:",lastMessageUserName]];
                
                if (userNameRange.location!=NSNotFound) {
                    [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"c0c0c0"].CGColor range:userNameRange];
                    [liveShowString addAttribute:(NSString *)kCTFontAttributeName value:(id)[UIFont fontWithName:kHelVeticaNeueMedium size:10.5] range:userNameRange];
                    
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
    
    
    
    if (self.createChatArray.count>indexPath.row) {
        
        
        NSMutableDictionary *channelDict=[self.createChatArray objectAtIndex:indexPath.row];
        
        
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




-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    
    return headerView;
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
    
    if (searchTextField.text.length>0) {
        
        if (createChatArray.count%25==0)
        [self getListOfChatsForPageNumber:self.createChatTableView.selectedPageNumber];
        
    }
    else{
        if (createChatArray.count%25==0) {
            
            
            [self searchChannels:searchTextField.text forPageNumber:self.createChatTableView.selectedPageNumber];
            
            
        }
        
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
    
    // cell.userNameLabel.backgroundColor=[UIColor orangeColor];
    
    
    
    if ([hashTagDict valueForKey:@"subscribers_count"] && ![[hashTagDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]]) {
        
        
        
    }
    
    
}



#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    
    
        
        
        
        
    
        NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:kCharacterSetString];
        NSRange r = [string rangeOfCharacterFromSet:s];
        if ((r.location != NSNotFound) || [string isEqualToString:@""]) {
            // NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
            
            NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            self.createChatTableView.selectedPageNumber=1;
            
            [self searchChannels:searchString forPageNumber:selectedPageNumber];

            if (searchString && searchString.length>0) {
                [self searchChannels:searchString forPageNumber:self.createChatTableView.selectedPageNumber];
                
            }
            else{
                
                [self getListOfChatsForPageNumber:self.createChatTableView.selectedPageNumber];
           }
            return YES;
            
            
        }
        else{
            
            return NO;
        }
        
        
        
    
    
//    NSString * searchString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
//    
//    
//    [self searchChannels:searchString];
//    
//    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}


#pragma mark Button Pressed methods


-(IBAction)backButtonPressed:(UIButton *)sender
{
    
    
    createChatTableView.scrollEnabled=NO;
    createChatTableView.pagingDelegate=nil;
    createChatTableView.dataSource=nil;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(IBAction)createHashTagButtonPressed:(UIButton *)sender{
    
    
    [self createNewChannel];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    createChatTableView.selectedPageNumber=1;
    searchTextField.text=@"";
    [searchTextField resignFirstResponder];
    
    
}


-(void) viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    createView.hidden=YES;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
