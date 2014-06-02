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
@synthesize doneButton;
@synthesize loginLabel;
@synthesize notAMemberAttributedLabel;


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
    
    UIView *paddingViewEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewEmail.backgroundColor = [UIColor clearColor];
    emailTextField.leftView = paddingViewEmail;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
    paddingViewPassword.backgroundColor = [UIColor clearColor];
    passwordTextField.leftView = paddingViewPassword;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)setFontsAndFrames{
    
    
    NSString *hexColortexString=@"eaeaea";
    self.emailTextField.backgroundColor=[Utility colorWithHexString:hexColortexString];
    self.passwordTextField.backgroundColor=[Utility colorWithHexString:hexColortexString];
    
    [self.doneButton setTitleColor:[Utility colorWithHexString:@"157dfb"] forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:17]];
    
    
    self.loginLabel.textColor=[Utility colorWithHexString:@"000000"];
    self.loginLabel.font=[UIFont fontWithName:kHelVeticaNeueUltralight size:38];
    
    self.emailTextField.textColor=[Utility colorWithHexString:@"000000"];
    self.passwordTextField.textColor=[Utility colorWithHexString:@"000000"];

    self.emailTextField.font=[UIFont fontWithName:kHelVeticaLight size:16.5];
    self.passwordTextField.font=[UIFont fontWithName:kHelVeticaLight size:16.5];

    [self.signUpButton setTitleColor:[Utility colorWithHexString:@"96b8ff"] forState:UIControlStateNormal];
    [self.signUpButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:15.5]];
    
    self.notAMemberAttributedLabel.textColor=[Utility colorWithHexString:@"6c6c6c"];
    self.notAMemberAttributedLabel.font=[UIFont fontWithName:kHelVeticaNeueLight size:15.5];
    
    
    
    
    if (!IS_IPHONE_5) {
        
        CGRect loginFrame=self.loginLabel.frame;
        loginFrame.origin.y-=38;
        self.loginLabel.frame=loginFrame;
        

        CGRect emailFrame=self.emailTextField.frame;
        emailFrame.origin.y-=51;
        self.emailTextField.frame=emailFrame;
        
        
        CGRect passwordFrame=self.passwordTextField.frame;
        passwordFrame.origin.y-=51;
        self.passwordTextField.frame=passwordFrame;
        
        
        int changedFrameValue=60;
        
        CGRect notAMemberFrame=self.notAMemberAttributedLabel.frame;
        notAMemberFrame.origin.y-=changedFrameValue;
        self.notAMemberAttributedLabel.frame=notAMemberFrame;
        
        
        CGRect signUpFrame=self.signUpButton.frame;
///        signUpFrame.origin.y-=41;
        signUpFrame.origin.y-=changedFrameValue;

        self.signUpButton.frame=signUpFrame;
        
        
        
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPaddingView];
    [self setFontsAndFrames];
    

    
    
    
	// Do any additional setup after loading the view.
}


-(void)checkLoginCredentials{
    
    
    NSMutableDictionary *loginDict=[[NSMutableDictionary alloc]init];
    [loginDict setValue:emailTextField.text forKey:@"email"];
    [loginDict setValue:passwordTextField.text forKey:@"password"];
    
    
    NSMutableDictionary *sessionDict=[[NSMutableDictionary alloc]init];
    [sessionDict setValue:loginDict forKey:@"session"];
    
    doneButton.enabled=NO;
    
    
    [[NetworkEngine sharedNetworkEngine]loginHashy:^(id object) {
        
      //  NSLog(@"%@",object);
        doneButton.enabled=YES;

        
        if ([object valueForKey:@"session"] && ![[object valueForKey:@"session"]isEqual:[NSNull null]]) {
           
            NSMutableDictionary *dict=[[object valueForKey:@"session"] mutableCopy];
            
            [[UpdateDataProcessor sharedProcessor]updateUserDetails:dict];
            
            HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
            [self.navigationController pushViewController:listChatVC animated:YES];
            

        }
        
        
        
        
        
    } onError:^(NSError *error) {
        doneButton.enabled=YES;

        NSLog(@"%@",error);
        [Utility showAlertWithString:@"Invalid username or password."];
        
        
    } withParams:sessionDict];
}

#pragma mark UITextField Deleagte Methods



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
   // textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    
    NSString * proposedNewString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    
    NSLog(@"%@",proposedNewString);
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

-(IBAction)doneButtonPressed:(UIButton *)sender{
    
    
    if (emailTextField.text.length<1) {
        
        [Utility showAlertWithString:@"Please enter username."];
        return;
        
    }
    else if (passwordTextField.text.length<1){
        [Utility showAlertWithString:@"Please enter password."];
        return;
        
    }
    
    
    
    [self checkLoginCredentials];

    
//    HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
//    [self.navigationController pushViewController:listChatVC animated:YES];
   
    
    
//    HYSubscribersListViewController *subscribersVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"subscribers_vc"];
//    [self.navigationController pushViewController:subscribersVC animated:YES];

 //   [NetworkEngine sharedNetworkEngine]
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
