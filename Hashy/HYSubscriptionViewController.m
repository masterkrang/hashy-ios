//
//  HYSubscriptionViewController.m
//  Hashy
//
//  Created by attmac107 on 6/20/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import "HYSubscriptionViewController.h"

@interface HYSubscriptionViewController ()

@end

@implementation HYSubscriptionViewController
@synthesize subscriptionsArray;
@synthesize bottomView;
@synthesize subscriptionTableView;
@synthesize user_id;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark FrostedViewController Delegate Methods


- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}

#pragma mark View Methods


-(void) setBarButtonItems{
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"side_bar_screen_hamburger_menu_icon.png"] style:UIBarButtonItemStyleDone target:(CustomNavigationController *)self.navigationController action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
   
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    selectedPageNumber=1;
    self.subscriptionTableView.selectedPageNumber=1;
    
    
    [self getUserRecentChats:user_id forPageNumber:self.subscriptionTableView.selectedPageNumber];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"subscriptions";
    
    [self setBarButtonItems];
    selectedPageNumber=1;
    
    
    [self.subscriptionTableView setupTablePaging];
    self.subscriptionTableView.pagingDelegate=self;
    self.subscriptionTableView.separatorColor=[Utility colorWithHexString:@"cbcbcb"];

    
    if (!self.subscriptionsArray) {
        self.subscriptionsArray=[[NSMutableArray alloc]init];
        
    }
    
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame=CGRectMake((self.view.frame.size.width/2)-10, 0, 20, 20);
    [activityIndicatorView setColor:[UIColor darkGrayColor]];
    [bottomView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    bottomView.hidden=YES;
    
    bottomView.backgroundColor=[UIColor clearColor];
    
    
    self.view.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    self.subscriptionTableView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    

    
	// Do any additional setup after loading the view.
}



#pragma mark API methods

-(void)getUserRecentChats:(NSString *)user_id_str forPageNumber:(int)page_number{
    
    
    if (page_number>1) {
        bottomView.hidden=NO;
        [activityIndicatorView startAnimating];
        
    }
    
    
    [[NetworkEngine sharedNetworkEngine]getRecentChatsForAUser:^(id object) {
        
        NSLog(@"%@",object);
        
        if (![object isEqual:[NSNull null]] && [object isKindOfClass:[NSArray class]]) {
            
            
            if (subscriptionTableView.selectedPageNumber==1)
                [self.subscriptionsArray removeAllObjects];
            
            if (!self.subscriptionsArray) {
                
                self.subscriptionsArray=[[NSMutableArray alloc]init];
                
                
            }
            NSMutableArray *objectsArray=[object mutableCopy];
            [self.subscriptionsArray addObjectsFromArray:objectsArray];
            // [self.subscribersListArray addObjectsFromArray:[object mutableCopy]];
            
            
            [self.subscriptionTableView reloadData];
            self.subscriptionTableView.pageLocked=NO;
            bottomView.hidden=YES;
            [activityIndicatorView stopAnimating];
            
            
            
        }
        
    } onError:^(NSError *error) {
        subscriptionTableView.pageLocked=NO;
        bottomView.hidden=YES;
        [activityIndicatorView stopAnimating];
        NSLog(@"%@",error);
        
        
    } forUserID:user_id_str forPageNumber:page_number];
    
}


#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.subscriptionsArray.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscriptionCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SubscriptionCellIdentifier"];
    cell.contentView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    cell.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    cell.hashTitleLabel.font=[UIFont fontWithName:kHelVeticaBold size:18];
    cell.hashTitleLabel.textColor=[Utility colorWithHexString:@"939393"];
    [cell.subscriptionSwitch setOn:YES];
    

    if (subscriptionsArray.count>indexPath.row) {
        
        NSMutableDictionary *channelDict=[self.subscriptionsArray objectAtIndex:indexPath.row];
        
        if ([channelDict valueForKey:@"channel"] && ![[channelDict valueForKey:@"channel"]isEqual:[NSNull null]]) {
            
            
            NSMutableDictionary *channelDetailDict=[channelDict valueForKey:@"channel"];
            
            if ([channelDetailDict valueForKey:@"name"] && ![[channelDetailDict valueForKey:@"name"]isEqual:[NSNull null]] && [[channelDetailDict valueForKey:@"name"] length]>0) {
                
                
                cell.hashTitleLabel.text=[NSString stringWithFormat:@"#%@",[channelDetailDict valueForKey:@"name"]];
                
                
            }
            
            
        }
        
        
        
    }

    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
    
    
}




-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
    
    headerView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];
    return headerView;
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
    
}



-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
  
    
    
    UIView *customFooterView= [[UIView alloc]initWithFrame:CGRectMake(0,0 , 0   ,  1)];
    customFooterView.backgroundColor=[Utility colorWithHexString:@"f2f2f2"];;
    return customFooterView;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}






-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
    NSLog(@"Reached end");
    
    
    if (self.subscriptionsArray.count>0) {
        
        [self getUserRecentChats:user_id forPageNumber:self.subscriptionTableView.selectedPageNumber];
        
        
        
        
    }
    
    
}




#pragma mark Button Presed Methods

-(IBAction)subscriptionSwitchPressed:(UISwitch *)sender{
    
    
    NSLog(@"Value changed");
    
    
    SubscriptionCustomCell *cell;
    if (isIOSVersion7) {
    cell=(SubscriptionCustomCell *)[[[sender superview]superview]superview];
    }
    else
    cell=(SubscriptionCustomCell *)[[sender superview]superview];
    
    NSIndexPath *indexPath=[self.subscriptionTableView indexPathForCell:cell];
    
    
    if (subscriptionsArray.count>indexPath.row) {
        
        NSMutableDictionary *channelDict=[self.subscriptionsArray objectAtIndex:indexPath.row];
        
        if ([channelDict valueForKey:@"channel"] && ![[channelDict valueForKey:@"channel"]isEqual:[NSNull null]]) {
            
            
            NSMutableDictionary *channelDetailDict=[channelDict valueForKey:@"channel"];
            
            if ([channelDetailDict valueForKey:@"id"] && ![[channelDetailDict valueForKey:@"id"]isEqual:[NSNull null]] ) {
                
                
                NSNumber *chat_id_num=[channelDetailDict valueForKey:@"id"];
                int chat_id_int=chat_id_num.intValue;
                
                
                NSString *chat_id_string=[NSString stringWithFormat:@"%d",chat_id_int];
                
                
                if (chat_id_string && ![chat_id_string isEqual:[NSNull null]] && chat_id_string.length>0) {
                    
                   // [kAppDelegate showProgressHUD:self.view];
                    [kAppDelegate showProgressAnimatedView];
                    [[NetworkEngine sharedNetworkEngine]deleteSubscription:^(id object) {
                        
                        NSLog(@"Deleted");
                     //   [kAppDelegate hideProgressHUD];
                        [kAppDelegate hideProgressAnimatedView];
                        if (subscriptionsArray.count) {
                            
                            
                            
                            [subscriptionTableView beginUpdates];
                            [subscriptionsArray removeObjectAtIndex:indexPath.row];
                            
                            NSLog(@"IndexPath %@",indexPath);
                            
                            [subscriptionTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
                            
                            
                            
                            
                            [subscriptionTableView endUpdates];
                            
                           
                            
                            
                        }

                        
                        
                        
                    } onError:^(NSError *error) {
                        
                    NSLog(@"error");
                  //  [kAppDelegate hideProgressHUD];
                      [kAppDelegate hideProgressAnimatedView];  
                    } forChatID:chat_id_string];
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    
}




-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    selectedPageNumber=1;
    self.subscriptionTableView.selectedPageNumber=1;

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
