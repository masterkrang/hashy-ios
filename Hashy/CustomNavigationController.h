//
//  CustomNavigationController.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
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
