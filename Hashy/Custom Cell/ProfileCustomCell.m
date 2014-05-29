//
//  ProfileCustomCell.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//
#import "ProfileCustomCell.h"

@implementation ProfileCustomCell
@synthesize hashTaglabel;
@synthesize userNameLabel;
@synthesize subscribersCount;
@synthesize nextImageView;
@synthesize statusImageView;


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
