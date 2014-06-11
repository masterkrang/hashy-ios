//
//  ChatCustomCell.h
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//
#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface ChatCustomCell : UITableViewCell
{
    
}

@property(nonatomic,strong)IBOutlet UILabel *userNameLabel;
@property(nonatomic,strong)IBOutlet TTTAttributedLabel *messageLabel;
@property(nonatomic,strong)IBOutlet UIImageView *topLeftImageView;
@property(nonatomic,strong)IBOutlet UIImageView *topRightImageView;

@property(nonatomic,strong)IBOutlet UIImageView *bottomLeftImageView;

@property(nonatomic,strong)IBOutlet UIImageView *bottomRightImageView;
@property(nonatomic,strong)IBOutlet UIImageView *bubbleImageView;
@property(nonatomic,strong)IBOutlet UIImageView *pictureImageView;


@end
