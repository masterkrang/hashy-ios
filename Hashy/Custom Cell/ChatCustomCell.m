//
//  ChatCustomCell.m
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import "ChatCustomCell.h"

@implementation ChatCustomCell
@synthesize userNameLabel;
@synthesize messageLabel;
//@synthesize topLeftImageView;
//@synthesize topRightImageView;
//@synthesize bottomLeftImageView;
//@synthesize bottomRightImageView;
@synthesize bubbleImageView;
@synthesize pictureImageView;
@synthesize activityIndicatorView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
