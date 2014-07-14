//
//  UIView+Animation.m
//  TrueAirSync
//
//  Created by Brian Russel Davis on 19/10/12.
//  Copyright (c) 2012 Apptree Studio. All rights reserved.
//

/*
 
It is a sub class of UIView.
 */


#import "UIView+Animation.h"

@implementation UIView (Animation)

-(void)hideViewWithAnimation {
    
    if(!self.hidden) {
   [UIView animateWithDuration:0.3 animations:^{
       self.alpha = 0.0;

   } completion:^(BOOL finished) {
       self.hidden = YES;

   }];
    }
  
    
}
- (void)showViewWithAnimation {

    if(self.hidden) {
    self.alpha = 0.0;
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha =1.0;
       
    }];
    }
}
@end
