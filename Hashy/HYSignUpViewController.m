//
//  HYSignUpViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "HYSignUpViewController.h"

#define kString(abc) [NSString stringWithFormat:@"#abc"]

@interface HYSignUpViewController ()

@end

@implementation HYSignUpViewController
@synthesize alreadySignedUpAttributedLabel;
@synthesize doneButton;
@synthesize userNameTextField;
@synthesize passwordtextField;
@synthesize emailTextField;
@synthesize signUpLabel;
@synthesize signInButton;


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


-(void)setPaddingView{
    
    ;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    paddingView.backgroundColor = [UIColor clearColor];
    userNameTextField.leftView = paddingView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *paddingViewEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    paddingViewEmail.backgroundColor = [UIColor clearColor];
    emailTextField.leftView = paddingViewEmail;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    paddingViewPassword.backgroundColor = [UIColor clearColor];
    passwordtextField.leftView = paddingViewPassword;
    passwordtextField.leftViewMode = UITextFieldViewModeAlways;
    
    userNameTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    emailTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    passwordtextField.autocorrectionType=UITextAutocorrectionTypeNo;
    
    [passwordtextField setSecureTextEntry:YES];
}

-(void)setFontsAndFrames{
    
    
    [self.doneButton setTitleColor:[Utility colorWithHexString:@"157dfb"] forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:17]];
    
    
    self.signUpLabel.textColor=[Utility colorWithHexString:@"000000"];
    self.signUpLabel.font=[UIFont fontWithName:kHelVeticaNeueUltralight size:38];

    
    
    self.emailTextField.textColor=[Utility colorWithHexString:@"000000"];
    self.passwordtextField.textColor=[Utility colorWithHexString:@"000000"];
    self.userNameTextField.textColor=[Utility colorWithHexString:@"000000"];

    self.userNameTextField.font=[UIFont fontWithName:kHelVeticaLight size:16.5];
    self.emailTextField.font=[UIFont fontWithName:kHelVeticaLight size:16.5];
    self.passwordtextField.font=[UIFont fontWithName:kHelVeticaLight size:16.5];
    
    
    [self.signInButton setTitleColor:[Utility colorWithHexString:@"6c6c6c"] forState:UIControlStateNormal];
    [self.signInButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:15.5]];
    
    self.alreadySignedUpAttributedLabel.textColor=[Utility colorWithHexString:@"6c6c6c"];
    self.alreadySignedUpAttributedLabel.font=[UIFont fontWithName:kHelVeticaNeueLight size:15.5];
    
    
    
    if (!IS_IPHONE_5) {
        
        CGRect signUpFrame=self.signUpLabel.frame;
        signUpFrame.origin.y-=40;
        self.signUpLabel.frame=signUpFrame;
        
        
        
        CGRect userNameFrame=self.userNameTextField.frame;
        userNameFrame.origin.y-=49;
        self.userNameTextField.frame=userNameFrame;
        
        
        CGRect emailFrame=self.emailTextField.frame;
        emailFrame.origin.y-=56;
        self.emailTextField.frame=emailFrame;
        
        
        CGRect passwordFrame=self.passwordtextField.frame;
        passwordFrame.origin.y-=63;
        self.passwordtextField.frame=passwordFrame;
        
        CGRect alreadySignUpFrame=self.alreadySignedUpAttributedLabel.frame;
        alreadySignUpFrame.origin.y-=60;
        self.alreadySignedUpAttributedLabel.frame=alreadySignUpFrame;
        
        
        CGRect signInFrame=self.signInButton.frame;
        signInFrame.origin.y-=60;
        self.signInButton.frame=signInFrame;
        
     
        
    

        
        
        
    }
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor=[UIColor greenColor];
    
    [self setPaddingView];
    [self setFontsAndFrames];
    


    
    
	// Do any additional setup after loading the view.
}


-(void)setTextColorsAndFrames{
    
    
   


    
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

    
//    if (userNameTextField.text.length<3 || userNameTextField.text.length>25) {
//        
//        
//        [self showAlertViewWithMessaage:@"Your username should lie between 3-25 characters and it should contain only alphanumeric characters. No special characters are allowed."];
//        return;
//        
//    
//    }
//    
//    
//    
//    if (passwordtextField.text.length<6) {
//        
//    [self showAlertViewWithMessaage:@"Your password must be at least 6 characters long."];
//        return;
//    }
    
    
    
//    [self registerUserOnServer];
    
    
    AddImageViewController *addImageVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"addImage_vc"];
    [self.navigationController pushViewController:addImageVC animated:YES];

 
    
    
        
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
