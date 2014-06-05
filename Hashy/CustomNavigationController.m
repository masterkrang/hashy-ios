//
//  CustomNavigationController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "CustomNavigationController.h"
#define kNavigationBackground [UIImage imageNamed:@"profile_back_buttonwefg.png"]

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController
@synthesize backButton;
@synthesize settingButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}



-(void)backButtonPressed:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
  
    
    

    self.delegate=self;
    
    
    if([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //        //iOS 5 new UINavigationBar custom background
  //  [self.navigationBar setBackgroundImage:kNavigationBackground forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setBackgroundImage:[UIColor colorWithPatternImage: [UIImage imageNamed: @"red.png"]] forBarMetrics:UIBarMetricsDefault];

        ;
    }
   // self.navigationBar.tintColor=[UIColor orangeColor];

    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:kHelVeticaNeueMedium size:17] forKey: NSFontAttributeName];

    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    

    
    
    self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationItem.hidesBackButton=YES;
    UIButton *backArrowButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backArrowButton.frame=CGRectMake(0, 0, 20, 30);
    [backArrowButton setBackgroundImage:[UIImage imageNamed:@"profile_back_button.png"] forState:UIControlStateNormal];
    [backArrowButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
   // UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backArrowButton];
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    
    
    // self.navigationItem.backBarButtonItem=leftBarButtonItem;
//    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    //[self.navigationBar addSubview:self.settingButton];
    
//    
//    UIBarButtonItem *settingBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:settingButton];
//    self.navigationItem.leftBarButtonItem=settingBarButtonItem;
//    
    

	// Do any additional setup after loading the view.
}



-(void)addSideMenus
{
    
}
//{
//    NSLog(@"%@",self.slidingViewController.underLeftViewController);
//    NSLog(@"%@",self.slidingViewController);
//
//    
//    if (![self.slidingViewController.underLeftViewController isKindOfClass:[SidebarScreenViewController class]]) {
//        
//        
//      SidebarScreenViewController   *sideBarVC = [kStoryBoard instantiateViewControllerWithIdentifier:@"sidebar_screen"];
//       // CustomNavigationController *customNav=[[CustomNavigationController alloc]initWithRootViewController:sideBarVC];
//
//        self.slidingViewController.underLeftViewController  = sideBarVC;
//    }
//    [self.slidingViewController setAnchorRightRevealAmount:237.0f];
//    
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//   //settingButton=[[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(setttingButtonPressed:)];
//    
//    
//}

-(void)showBackButton {
    
    
    if(!backButton)
    {
        
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //backButton.frame = CGRectMake(self.view.frame.origin.x-50, 2, 50, 41);
        backButton.frame = CGRectMake(self.view.frame.origin.x-30, 0, 30, 44);

        //[backButton setBackgroundImage:[UIImage imageNamed:@"music_back_button.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *buttonImageView=[[UIImageView alloc]initWithFrame:CGRectMake(8, 10, 16, 22)];
        buttonImageView.image=[UIImage imageNamed:@"music_back_button.png"];
        buttonImageView.userInteractionEnabled=NO;
        [backButton addSubview:buttonImageView];
        
        
        [self.navigationBar addSubview:backButton];
        
        
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.settingButton.hidden=YES;

        CGRect frame =   backButton.frame;
        if(frame.origin.x==self.view.frame.origin.x-30){
            frame.origin.x+=backButton.frame.size.width;
            backButton.frame = frame;
        }
    }];
    
    
    
    
}

-(void)hideBackButton {
    if(backButton){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame =   backButton.frame;
            //frame.origin.x=self.view.frame.origin.x-16;
            frame.origin.x=-30;
            backButton.frame = frame;
            self.settingButton.hidden=NO;
            
        }];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
   

}

//{
//    
//    
//    if ([self.visibleViewController isKindOfClass:[GetStartedViewController class]]||[self.visibleViewController isKindOfClass:[StartARecommendationViewController class]]) {
//        [self hideBackButton];
//        [self.settingButton setHidden:YES];
//        //[self showBackButton];
//        
//    }
//    else if ([self.visibleViewController isKindOfClass:[FeedViewController class]]||[self.visibleViewController isKindOfClass:[LeaderboardViewController class]]){
//        [self hideBackButton];
//        
//    }
//    
//    else if ([[navigationController viewControllers]count]==1){
//        
//        [self hideBackButton];
//        [self.settingButton setHidden:YES];
//
//    }
//    
//    else {
//        
//        [self showBackButton];
//        [self.settingButton setHidden:YES];
//    }
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
