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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarButtonItems];
  
    [self setBarButtonItems];
    [self setPaddingView];
    
    
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
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(createHashTagButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
}

-(void)setPaddingView{
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    paddingView.backgroundColor = [UIColor clearColor];
    
    UILabel *hashLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 10, 30)];
    hashLabel.text=@"#";
    hashLabel.font=[UIFont fontWithName:kHelVeticaNeueMedium size:18];
    hashLabel.textColor=[Utility colorWithHexString:@"000000"];
    [paddingView addSubview:hashLabel];
    
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
}


#pragma mark Check Hash tag

-(void)checkTagForSearchedText:(NSString *)searchedText{
    
    
    
}


#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;// self.subscribersListArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateChatCellIdentifier"];
    
    
   // cell.userNameLabel.textColor=[Utility colorWithHexString:@"888888"];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
    
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30)];
    
    //  headerView.backgroundColor=[Utility colorWithHexString:@"#000000"];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 10, 10)];
    [imageView setImage:[UIImage imageNamed:@"profile_green_dot.png"]];
    
    
    UILabel *subscribersLabel=[[UILabel alloc]initWithFrame:CGRectMake(35,0, 200, 30)];
    subscribersLabel.text=@"SUBSCRIBERS";
    subscribersLabel.font=[UIFont systemFontOfSize:17];;
   // subscribersLabel.textColor=[Utility colorWithHexString:@"888888"];;
    
    
    [headerView addSubview:imageView];
    [headerView addSubview:subscribersLabel];
    
    return headerView;
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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



#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}


#pragma mark Button Pressed methods


-(IBAction)backButtonPressed:(UIButton *)sender
{
    
     [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(IBAction)createHashTagButtonPressed:(UIButton *)sender{
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
