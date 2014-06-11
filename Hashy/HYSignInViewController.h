//
//  HYSignInViewController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "HYSignUpViewController.h"
#import "HYSubscribersListViewController.h"
#import "REFrostedViewController.h"
@interface HYSignInViewController : UIViewController<REFrostedViewControllerDelegate>{
    
    
}

@property(nonatomic,strong) IBOutlet UITextField *emailTextField;
@property(nonatomic,strong) IBOutlet UITextField *passwordTextField;
@property(nonatomic,strong) IBOutlet UIButton *doneButton;
@property(nonatomic,strong) IBOutlet UILabel *loginLabel;
@property(strong,nonatomic)IBOutlet UILabel *notAMemberAttributedLabel;
@property(nonatomic,strong) IBOutlet UIButton *signUpButton;



-(IBAction)signUpButtonPressed:(UIButton *)sender;
-(IBAction)doneButtonPressed:(UIButton *)sender;


@end
