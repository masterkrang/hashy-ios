//
//  HYSubscribersListViewController.m
//  Hashy
//
//  Created by attmac107 on 5/30/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "HYSubscribersListViewController.h"

@interface HYSubscribersListViewController ()

@end

@implementation HYSubscribersListViewController
@synthesize subscribersTableView;
@synthesize subscribersListArray;
@synthesize searchTextField;
@synthesize subscribersCountString;



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

-(void)setSearchTextField{
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    
    paddingView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *searchIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9,8, 12,12 )];
    searchIconImageView.image=[UIImage imageNamed:@"listChat_search_icon.png"];
    [paddingView addSubview:searchIconImageView];
    
    
    
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;
}


-(void)setNavigationBarItems{
    
   
    
    
    UIButton *subscriberButtonCount=[UIButton buttonWithType:UIButtonTypeCustom];
    subscriberButtonCount.frame=CGRectMake(0, 0, 35+(subscribersCountString.length *6), 40);
    //    subscriberButtonCount.backgroundColor=[UIColor orangeColor];
    [subscriberButtonCount setTitle:subscribersCountString forState:UIControlStateNormal];
    [subscriberButtonCount setTitleColor:[Utility colorWithHexString:kHexValueLightGreenColor] forState:UIControlStateNormal];
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
    self.title=@"subscribers";
    subscribersCountString=@"1";
    [subscribersTableView setupTablePaging];
    subscribersTableView.pagingDelegate=self;
    
    [self setSearchTextField];
    
    [self setNavigationBarItems];
    
    subscribersTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];
    
//    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
//    paddingViewPassword.backgroundColor = [UIColor clearColor];
//    searchTextField.leftView = paddingViewPassword;
//    searchTextField.leftViewMode = UITextFieldViewModeAlways;
//    searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;

    
  
    
    
    if (!subscribersListArray) {
        self.subscribersListArray=[[NSMutableArray alloc]init];
        
    }
    
    [self getSubscribersListForChatID:@"12"];
    
    
	// Do any additional setup after loading the view.
}

-(void)getSubscribersListForChatID:(NSString *)chat_id{
    
    
    [[NetworkEngine sharedNetworkEngine]getSubscribersList:^(id object) {
        
        NSLog(@"%@",object);
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);

    } forChatID:chat_id forPageNumber:1];
    
}



#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;// self.subscribersListArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscribersCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SubscribersCellIdentifier"];
    
    
    cell.userNameLabel.textColor=[Utility colorWithHexString:@"888888"];
    
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
    subscribersLabel.textColor=[Utility colorWithHexString:@"888888"];;
    
    
    [headerView addSubview:imageView];
    [headerView addSubview:subscribersLabel];
    
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



#pragma mark Button Pressed Methods


-(void)backButtonPressed:(UIButton *)sender {
    
    
    if (!subscribersTableView.isScrolling) {
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

#pragma maark Did Disappear Functions




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
