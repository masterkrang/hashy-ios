//
//  HYTermsAndConditionsViewController.m
//  Hashy
//
//  Created by attmac107 on 7/15/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import "HYTermsAndConditionsViewController.h"

@interface HYTermsAndConditionsViewController ()

@end

@implementation HYTermsAndConditionsViewController
@synthesize url_string;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)setBarButtonItems{
    
    

        NSLog(@"Multiple");
        UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
        self.navigationItem.leftBarButtonItem=leftBarButtonItem;
        
        
   
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Terms And Conditions";
    [self setBarButtonItems];
    NSURL *url = [NSURL URLWithString:self.url_string];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    [kAppDelegate showProgressAnimatedView];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark UIWebView Delegate methods


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //NSLog(@"%@",request);
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [kAppDelegate hideProgressAnimatedView];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //NSLog(@"Finished loading");
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [kAppDelegate hideProgressAnimatedView];

    // [Utility showAlertWithString:@"Error "];
    
}

#pragma mark Button Pressed methods


-(IBAction)backButtonPressed:(UIButton *)sender
{
    
    
      [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
