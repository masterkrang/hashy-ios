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

@interface HYSignUpViewController : UIViewController<UITextFieldDelegate,TTTAttributedLabelDelegate>{
    
}

@property(strong,nonatomic)IBOutlet UIButton *doneButton;
@property(strong,nonatomic)IBOutlet UILabel *signUpLabel;
@property(strong,nonatomic)IBOutlet UITextField *userNameTextField;
@property(strong,nonatomic)IBOutlet UITextField *passwordtextField;
@property(strong,nonatomic)IBOutlet UITextField *emailTextField;
@property(strong,nonatomic)IBOutlet TTTAttributedLabel *alreadySignedUpAttributedLabel;
@property(strong,nonatomic)IBOutlet UIButton *signInButton;
@property(nonatomic,strong) AFHTTPRequestOperationManager *httpManager;


-(IBAction)doneButtonPressed:(UIButton *)sender;
-(IBAction)signInButtonPressed:(UIButton *)sender;


@end
