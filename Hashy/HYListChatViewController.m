//
//  HYListChatViewController.m
//  Hashy
//
//  Created by attmac107 on 5/28/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "HYListChatViewController.h"

@interface HYListChatViewController ()

@end

@implementation HYListChatViewController
@synthesize searchTextField;


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
    
    
	// Do any additional setup after loading the view.
}


-(void)getListOfChats{
    
    
    
}

#pragma mark UItableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ListChatCellIdentifier"];
    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    
    [mutParaStyle setAlignment:NSTextAlignmentLeft];
    
    
    NSMutableAttributedString *liveShowString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"cooldude69: what's up people"]];
    //    [liveShowString addAttribute:NSFontAttributeName value:kRobotoFontRegular(125) range:[liveShowString.string rangeOfString:[NSString stringWithFormat:@"%d",loadedDataPercentage]]];
    
    //[liveShowString addAttribute:NSFontAttributeName value:kRobotoFontBold(40) range:[liveShowString.string rangeOfString:@"what's up people"]];
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
    
    return 61;
    
    
}


-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page{
    
    
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
