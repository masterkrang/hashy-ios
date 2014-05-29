//
//  HYSignInViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "HYSignInViewController.h"

@interface HYSignInViewController ()

@end

@implementation HYSignInViewController
@synthesize emailTextField;
@synthesize passwordTextField;
@synthesize signUpButton;


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
    
    UIView *paddingViewEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewEmail.backgroundColor = [UIColor clearColor];
    emailTextField.leftView = paddingViewEmail;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewPassword.backgroundColor = [UIColor clearColor];
    passwordTextField.leftView = paddingViewPassword;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    

    
	// Do any additional setup after loading the view.
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


-(IBAction)signUpButtonPressed:(UIButton *)sender{
    HYSignUpViewController *signUpVC = [kStoryBoard instantiateViewControllerWithIdentifier:@"signUp_vc"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:signUpVC] animated:YES];
    
}

-(IBAction)forwardButtonPressed:(UIButton *)sender{
    
    
//    
//HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];  [self.navigationController pushViewController:listChatVC animated:YES];

 //   [NetworkEngine sharedNetworkEngine]
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
