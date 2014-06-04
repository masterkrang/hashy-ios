//
//  ChatCustomCell.h
//  Hashy
//
//  Created by attmac107 on 6/4/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCustomCell : UITableViewCell
{
    
}

@property(nonatomic,strong)IBOutlet UILabel *userNameLabel;
@property(nonatomic,strong)IBOutlet UILabel *messageLabel;
@property(nonatomic,strong)IBOutlet UIImageView *topLeftImageView;
@property(nonatomic,strong)IBOutlet UIImageView *topRightImageView;

@property(nonatomic,strong)IBOutlet UIImageView *bottomLeftImageView;

@property(nonatomic,strong)IBOutlet UIImageView *bottomRightImageView;

@end
