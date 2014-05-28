//
//  ProfileCustomCell.h
//  Hashy
//
//  Created by attmac107 on 5/27/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@interface ProfileCustomCell : UITableViewCell
{
    
    
}


@property(nonatomic,strong)IBOutlet UILabel *hashTaglabel;
@property(nonatomic,strong)IBOutlet TTTAttributedLabel *userNameLabel;
@property(nonatomic,strong)IBOutlet UILabel *onlineUsersCount;
@property(nonatomic,strong)IBOutlet UIButton *nextButton;
@property(nonatomic,strong)IBOutlet UIImageView *statusImageView;

@end
