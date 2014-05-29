//
//  HYSignUpViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
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
    
    userNameTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    emailTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextField.autocorrectionType=UITextAutocorrectionTypeNo;

    [passwordtextField setSecureTextEntry:YES];

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
      //  NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text,string];
        return YES;
        
    }
    else if (textField==passwordtextField){
  //      NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text,string];
      //  textField.text=[NSString stringWithFormat:@"%@%@",textField.text,string];
        
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

    
    if (userNameTextField.text.length<3 || userNameTextField.text.length>25) {
        
        
        [self showAlertViewWithMessaage:@"Your username should lie between 3-25 characters and it should contain only alphanumeric characters. No special characters are allowed."];
        return;
        
    
    }
    
    
    
    if (passwordtextField.text.length<6) {
        
    [self showAlertViewWithMessaage:@"Your password must be at least 6 characters long."];
        return;
    }
    
    
    
//    [self registerUserOnServer];
    
    
    
 
    
    
        
}

-(IBAction)signInButtonPressed:(UIButton *)sender{
    
    
    HYSignInViewController *signInVC = [kStoryBoard instantiateViewControllerWithIdentifier:@"signIn_vc"];
    
    [self.navigationController setViewControllers:[NSArray arrayWithObject:signInVC] animated:YES];
    
    
}


-(void)showAlertViewWithMessaage:(NSString *)message{
    
    
    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    
    
}

-(void)registerUserOnServer{
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setValue:userNameTextField.text forKey:@"user_name"];
    
    [paramDict setValue:emailTextField.text forKey:@"email"];
    [paramDict setValue:passwordtextField.text forKey:@"email"];

    
    
    [[NetworkEngine sharedNetworkEngine]createNewUser:^(id object) {
        
        AddImageViewController *addImageVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"addImage_vc"];
        [self.navigationController pushViewController:addImageVC animated:YES];
        
        
    } onError:^(NSError *error) {
        
    } withParams:paramDict];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
