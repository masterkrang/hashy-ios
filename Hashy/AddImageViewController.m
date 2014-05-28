//
//  AddImageViewController.m
//  Hashy
//
//  Created by attmac107 on 5/26/14.
//  Copyright (c) 2014 Apptree Technologies. All rights reserved.
//

#import "AddImageViewController.h"

@interface AddImageViewController ()

@end

@implementation AddImageViewController

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
    self.navigationController.navigationBarHidden=YES;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



#pragma mark Button Methods


-(IBAction)doneButtonPressed:(UIButton *)sender{
    
    
//    HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
//    [self.navigationController pushViewController:profileVC animated:YES];
    
}


-(IBAction)changeImageButtonPressed:(UIButton *)sender{
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
