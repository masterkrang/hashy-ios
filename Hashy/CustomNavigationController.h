//
//  CustomNavigationController.h
//  FanOf
//
//  Created by attmac107 on 6/10/13.
//  Copyright (c) 2013 Apptree Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController<UINavigationControllerDelegate>
{
    
    UIButton *backButton;
    UIButton *settingButton;
}
@property(nonatomic,strong)     UIButton *backButton;
@property(nonatomic,strong) UIButton *settingButton;

-(void)hideBackButton;
-(void)showBackButton;
-(void) addSideMenus;

@end
