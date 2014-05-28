//
//  HYSignUpViewController.h
//  Hashy
//
//  Created by attmac107 on 5/27/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "AddImageViewController.h"
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
