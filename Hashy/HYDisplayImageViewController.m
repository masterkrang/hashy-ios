//
//  HYDisplayImageViewController.m
//  Hashy
//
//  Created by attmac107 on 6/23/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import "HYDisplayImageViewController.h"

@interface HYDisplayImageViewController ()

@end

@implementation HYDisplayImageViewController
@synthesize selectedImageView;
@synthesize image_url_string;
@synthesize selected_image;
@synthesize chat_name_string;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)setBarButtonItems{
    
    //self.title=@"Profile";
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    
       
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=self.chat_name_string;
    
    NSLog(@"%@",self.view);
    
    [self setBarButtonItems];
    
    activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((selectedImageView.frame.size.width-20)/2, (selectedImageView.frame.size.width-20)/2, 20, 20)];
    activityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    [selectedImageView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    selectedImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    if(!IS_IPHONE_5){
        
        CGRect imageFrame=self.selectedImageView.frame;
        imageFrame.size.height-=45;
        self.selectedImageView.frame=imageFrame;
        
    }
    
    if (selected_image) {
        selectedImageView.image=selected_image;
        
    }
    else{
        
        if (image_url_string) {
            
            NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:image_url_string]];
            
            
            typeof (selectedImageView) weakSelf=(selectedImageView);
            typeof (activityIndicatorView) weakSelfIndicator=(activityIndicatorView);
            
            [weakSelfIndicator startAnimating];
            
            
            [selectedImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                weakSelf.image=image;
                [weakSelfIndicator stopAnimating];
                
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                //[activityIndicatorView stopAnimating];
                [weakSelfIndicator stopAnimating];
                NSLog(@"Error while downloading the image");
                
            }];
        }
    }
    
    
    
	// Do any additional setup after loading the view.
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

@end
