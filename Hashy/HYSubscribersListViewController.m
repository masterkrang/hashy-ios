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
    
   
    
    
    subscriberButtonCount=[UIButton buttonWithType:UIButtonTypeCustom];
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
    [subscribersTableView setupTablePaging];
    subscribersTableView.pagingDelegate=self;
    
    [self setSearchTextField];
    
    [self setNavigationBarItems];
    
    subscribersTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];
    
    
    if (!subscribersListArray) {
        self.subscribersListArray=[[NSMutableArray alloc]init];
        
    }
    selectedPageNumber=1;
    [self getSubscribersListForChatID:chat_id_string forPageNumber:selectedPageNumber];
    
    
	// Do any additional setup after loading the view.
}


#pragma mark API Methods

-(void)searchSubscribers:(NSString *)searched_user forPageNumber:(int)page_number{
    
    subscribersTableView.pageLocked=YES;

    [[NetworkEngine sharedNetworkEngine]searchSubscribers:^(id object) {
        
        NSLog(@"%@",object);
        subscribersTableView.pageLocked=NO;
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (selectedPageNumber==1)
                [self.subscribersListArray removeAllObjects];
            
            if (!self.subscribersListArray) {
                
                self.subscribersListArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.subscribersTableView reloadData];
            self.subscribersTableView.pageLocked=NO;
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

        NSLog(@"%@",error);
        
    } forSearchedText:searched_user forPageNumber:page_number];
    
    
}

-(void)getSubscribersListForChatID:(NSString *)chat_id forPageNumber:(int)page_number{
    
    subscribersTableView.pageLocked=YES;

    [[NetworkEngine sharedNetworkEngine]getSubscribersList:^(id object) {
        
        NSLog(@"%@",object);
        subscribersTableView.pageLocked=NO;
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (selectedPageNumber==1)
                [self.subscribersListArray removeAllObjects];
            
            if (!self.subscribersListArray) {
                
                self.subscribersListArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.subscribersListArray addObjectsFromArray:objectsArray];
           // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.subscribersTableView reloadData];
            self.subscribersTableView.pageLocked=NO;
          
            
            
        }
        
    } onError:^(NSError *error) {
        NSLog(@"%@",error);
        subscribersTableView.pageLocked=NO;

    } forChatID:chat_id forPageNumber:page_number];
    
}



#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return subscribersListArray.count;// self.subscribersListArray.count;
    
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



-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30)];
    
    headerView.backgroundColor=[UIColor whiteColor];
    
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
    
    return 30;
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
    
    if (searchTextField.text.length>0) {
        
        if (subscribersListArray.count%25==0) {
            
            
            [self getSubscribersListForChatID:chat_id_string forPageNumber:subscribersTableView.selectedPageNumber];
            
            
        }

        
    }
    else{
        if (subscribersListArray.count%25==0) {
            
            
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
        [self searchSubscribers:searchString forPageNumber:selectedPageNumber];
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
    
    
    if (!subscribersTableView.isScrolling) {
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

#pragma maark Did Disappear Functions


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    selectedPageNumber=1;
    searchTextField.text=@"";
    [searchTextField resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
