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
    self.title=@"Profile";
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_settings_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;

    [profilePageTableView setupTablePaging];
    profilePageTableView.pagingDelegate=self;

    NSLog(@"%@",profilePageTableView);
    
	// Do any additional setup after loading the view.
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
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

    return 67;
    

}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
    
}


#pragma mark UIbutton Methods

-(void)backButtonPressed:(UIButton *)sender {
    
    
   // profilePageTableView.scrollEnabled=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)settingsButtonPressed:(UIButton *)sender
{
    
    HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
    [self.navigationController pushViewController:listChatVC animated:YES];
    
    
    
}


-(IBAction)editButtonPressed:(UIButton *)sender
{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
