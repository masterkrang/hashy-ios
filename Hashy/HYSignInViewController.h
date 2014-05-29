//
//  HYSignInViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "HYSignUpViewController.h"

@interface HYSignInViewController : UIViewController{
    
    
}

@property(nonatomic,strong) IBOutlet UITextField *emailTextField;
@property(nonatomic,strong) IBOutlet UITextField *passwordTextField;
@property(nonatomic,strong) IBOutlet UIButton *signUpButton;

-(IBAction)signUpButtonPressed:(UIButton *)sender;
-(IBAction)forwardButtonPressed:(UIButton *)sender;


@end
