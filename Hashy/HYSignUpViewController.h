//
//  HYSignUpViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "AddImageViewController.h"
#import "HYSignInViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UpdateDataProcessor.h"
#import "HYTermsAndConditionsViewController.h"

@interface HYSignUpViewController : UIViewController<UITextFieldDelegate,TTTAttributedLabelDelegate>{
    
    UIActivityIndicatorView *activityIndicator;
    BOOL isUserNameAvailable;
    
    
}

@property(strong,nonatomic)IBOutlet UIButton *doneButton;
@property(strong,nonatomic)IBOutlet UILabel *signUpLabel;
@property(strong,nonatomic)IBOutlet UITextField *userNameTextField;
@property(strong,nonatomic)IBOutlet UITextField *passwordtextField;
@property(strong,nonatomic)IBOutlet UITextField *emailTextField;
@property(strong,nonatomic)IBOutlet TTTAttributedLabel *alreadySignedUpAttributedLabel;
@property(strong,nonatomic)IBOutlet UIButton *signInButton;
@property(strong,nonatomic)IBOutlet UILabel *termsAcceptingLabel;
@property(strong,nonatomic)IBOutlet UIButton *termsAndConditionsButton;


@property(nonatomic,strong) AFHTTPRequestOperationManager *httpManager;


-(IBAction)doneButtonPressed:(UIButton *)sender;
-(IBAction)signInButtonPressed:(UIButton *)sender;
-(IBAction)termsAndConditionsButtonPressed:(UIButton *)sender;


@end
