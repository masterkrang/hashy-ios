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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"#hashy";
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"listChat_hashtag_icon.png"] style:UIBarButtonItemStyleDone target:self action:@selector(hashTagButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
    
    [self.listChatTableView setupTablePaging];
    self.listChatTableView.delegate=self;
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    
    paddingView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *searchIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9,8, 12,12 )];
    searchIconImageView.image=[UIImage imageNamed:@"listChat_search_icon.png"];
    [paddingView addSubview:searchIconImageView];
    
    
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    if (!self.hashTagListArray) {
        self.hashTagListArray=[[NSMutableArray alloc]init];
        
    }
    
    [self getListOfChats];
    
    
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
            
            
            
            NSString *lastMessageUserName=[hashTagDict valueForKey:@"last_message_user_name"];
            NSString *lastMessageString=[hashTagDict valueForKey:@"last_message"];

            
            if (lastMessageUserName && ![lastMessageUserName isEqual:[NSNull null]] &&lastMessageString && ![lastMessageString isEqual:[NSNull null]]) {

                
                NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
                
                [mutParaStyle setAlignment:NSTextAlignmentLeft];
                
                
                NSMutableAttributedString *liveShowString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",lastMessageUserName,lastMessageString]];
                //    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
                
                [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor lightGrayColor].CGColor range:[liveShowString.string rangeOfString:lastMessageUserName]];
                [liveShowString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor darkGrayColor].CGColor range:[liveShowString.string rangeOfString:lastMessageString]];
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
    
    headerView.backgroundColor=[Utility colorWithHexString:@"#000000"];
    return headerView;
    
    
}



#pragma mark UITextField Deleagte Methods


//- (BOOL) isIntegerNumber: (NSString*)input
//{
//    return [input integerValue] != 0 || [input isEqualToString:@"0"];
//}


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
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(IBAction)hashTagButtonPressed:(UIButton *)sender{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
