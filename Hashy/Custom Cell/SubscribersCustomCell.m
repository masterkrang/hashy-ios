//
//  SubscribersCustomCell.m
//  Hashy
//
//  Created by attmac107 on 5/30/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
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
