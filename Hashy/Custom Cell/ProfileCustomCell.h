//
//  ProfileCustomCell.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@interface ProfileCustomCell : UITableViewCell
{
    
    
}


@property(nonatomic,strong)IBOutlet UILabel *hashTaglabel;
@property(nonatomic,strong)IBOutlet TTTAttributedLabel *userNameLabel;
@property(nonatomic,strong)IBOutlet UILabel *subscribersCount;
//@property(nonatomic,strong)IBOutlet UIButton *nextButton;
@property(nonatomic,strong)IBOutlet UIImageView *nextImageView;

@property(nonatomic,strong)IBOutlet UIImageView *statusImageView;

@end
