//
//  HYSignUpViewController.m
//  Hashy
//
//  Created by attmac107 on 5/27/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "HYSignUpViewController.h"

@interface HYSignUpViewController ()

@end

@implementation HYSignUpViewController
@synthesize alreadySignedUpAttributedLabel;
@synthesize doneButton;
@synthesize userNameTextField;
@synthesize passwordtextField;
@synthesize emailTextField;


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
   // self.view.backgroundColor=[UIColor greenColor];
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingView.backgroundColor = [UIColor clearColor];
    userNameTextField.leftView = paddingView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *paddingViewEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewEmail.backgroundColor = [UIColor clearColor];
    emailTextField.leftView = paddingViewEmail;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewPassword.backgroundColor = [UIColor clearColor];
    passwordtextField.leftView = paddingViewPassword;
    passwordtextField.leftViewMode = UITextFieldViewModeAlways;
    

	// Do any additional setup after loading the view.
}




-(void)checkForUsernameAvailability{
    
    
    
    
    
    
}

#pragma mark UITextField Deleagte Methods


//- (BOOL) isIntegerNumber: (NSString*)input
//{
//    return [input integerValue] != 0 || [input isEqualToString:@"0"];
//}


-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField==userNameTextField) {
       
        
       // NSLog(@"Username text Field");
        
        NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
        NSRange r = [string rangeOfCharacterFromSet:s];
        if ((r.location != NSNotFound) || [string isEqualToString:@""]) {
            [self checkForUsernameAvailability];
            
            return YES;
        }
        else{
            
            return NO;
        }
        

        
    }
    else if (textField==emailTextField){
//        NSString *searchString
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        return YES;
        
    }
    else if (textField==passwordtextField){
  //      NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text,string];
        textField.text=[NSString stringWithFormat:@"%@%@",textField.text,string];
        
        return YES;
        
    }
    else
        return NO;
    
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    return [textField resignFirstResponder];


}




#pragma mark Button Pressed Methods

-(IBAction)doneButtonPressed:(UIButton *)sender{

    AddImageViewController *addImageVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"addImage_vc"];
    [self.navigationController pushViewController:addImageVC animated:YES];
    
    
        
}

-(IBAction)signInButtonPressed:(UIButton *)sender{
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
