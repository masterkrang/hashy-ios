//
//  ChatCustomCell.h
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//
#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@protocol ChatCustomCellDelegate <NSObject>
-(void)startLongPressGestureCallForCell:(id)cell;
@end
@interface ChatCustomCell : UITableViewCell
{
   
}

@property(nonatomic,strong)IBOutlet UILabel *userNameLabel;
@property(nonatomic,strong)IBOutlet TTTAttributedLabel *messageLabel;
//@property(nonatomic,strong)IBOutlet UIImageView *topLeftImageView;
//@property(nonatomic,strong)IBOutlet UIImageView *topRightImageView;
//
//@property(nonatomic,strong)IBOutlet UIImageView *bottomLeftImageView;
//
//@property(nonatomic,strong)IBOutlet UIImageView *bottomRightImageView;
@property(unsafe_unretained) id<ChatCustomCellDelegate> delegate;
@property(nonatomic,strong)IBOutlet UIImageView *bubbleImageView;
@property(nonatomic,strong)IBOutlet UIImageView *pictureImageView;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end
