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

@interface HYSignUpViewController : UIViewController<UITextFieldDelegate>{
    
}

@property(strong,nonatomic)IBOutlet TTTAttributedLabel *alreadySignedUpAttributedLabel;
@property(strong,nonatomic)IBOutlet UIButton *doneButton;
@property(strong,nonatomic)IBOutlet UITextField *userNameTextField;
@property(strong,nonatomic)IBOutlet UITextField *passwordtextField;
@property(strong,nonatomic)IBOutlet UITextField *emailTextField;

-(IBAction)doneButtonPressed:(UIButton *)sender;
-(IBAction)signInButtonPressed:(UIButton *)sender;


@end
