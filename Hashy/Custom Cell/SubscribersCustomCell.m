//
//  SubscribersCustomCell.m
//  Hashy
//
//  Created by Kurt on 5/30/14.
//
//

#import "SubscribersCustomCell.h"

@implementation SubscribersCustomCell
@synthesize userNameLabel;
@synthesize maskButton;
@synthesize userProfilePictureImageView;

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
