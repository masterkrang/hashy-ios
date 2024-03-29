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
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"#hashy";
    
    [self setPaddingView];
    [self setBarButtonItems];
    
    
    [self.listChatTableView setupTablePaging];
    self.listChatTableView.delegate=self;
    self.listChatTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];
    

    if (!self.hashTagListArray) {
        self.hashTagListArray=[[NSMutableArray alloc]init];
        
    }
    
    [self getListOfChats];
    self.view.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    self.listChatTableView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];

	// Do any additional setup after loading the view.
}


-(void)getListOfChats{
    
    
    
    [[NetworkEngine sharedNetworkEngine]getChatLists:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
         
            
            if (!self.hashTagListArray) {
              
                self.hashTagListArray=[[NSMutableArray alloc]init];
                
                
            }
            
            [self.hashTagListArray addObjectsFromArray:[object mutableCopy]];
            [self.listChatTableView reloadData];
            
            
            
        }
        
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
    } forPageNumber:1 forSearchedText:nil];
    
    
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
                cell.hashTaglabel.text=[NSString stringWithFormat:@"#%@",[hashTagDict valueForKey:@"name"]];
            }
            
            
            if ([hashTagDict valueForKey:@"subscribers_count"] && ![[hashTagDict valueForKey:@"subscribers_count"]isEqual:[NSNull null]] && [[hashTagDict valueForKey:@"subscribers_count"] length]>0) {
                cell.subscribersCount.text=[hashTagDict valueForKey:@"subscribers_count"];
                
            }
            else{
                
                cell.subscribersCount.text=@"0";
  
            }
            
            
            
            NSString *lastMessageUserName=[hashTagDict valueForKey:@"last_message_user_name"];
            NSString *lastMessageString=[hashTagDict valueForKey:@"last_message"];

            
            if (lastMessageUserName && ![lastMessageUserName isEqual:[NSNull null]] &&lastMessageString && ![lastMessageString isEqual:[NSNull null]]) {

                
                NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
                
                [mutParaStyle setAlignment:NSTextAlignmentLeft];
                
                
                NSMutableAttributedString *liveShowString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",lastMessageUserName,lastMessageString]];
                //    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
                
                [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"cecece"].CGColor range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%@:",lastMessageUserName]]];
                
                [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[Utility colorWithHexString:@"9a9a9a"].CGColor range:[liveShowString.string rangeOfString:lastMessageString]];
                
                
                [liveShowString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                                          forKey:NSParagraphStyleAttributeName]
                                        range:NSMakeRange(0,[[liveShowString string] length])];
                [cell.userNameLabel setAttributedText:liveShowString];

            
            
        }
        
    }
    }
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61;
    
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

 
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    return headerView;
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
    
    
}



#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}



#pragma mark Button Presed Methods

-(IBAction)settingsButtonPressed:(UIButton *)sender
{
    
   // [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(IBAction)hashTagButtonPressed:(UIButton *)sender{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
