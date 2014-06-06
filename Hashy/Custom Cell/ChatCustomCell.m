//
//  ChatCustomCell.m
//  Hashy
//
//  Created by attmac107 on 6/4/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "ChatCustomCell.h"

@implementation ChatCustomCell
@synthesize userNameLabel;
@synthesize messageLabel;
@synthesize topLeftImageView;
@synthesize topRightImageView;
@synthesize bottomLeftImageView;
@synthesize bottomRightImageView;
@synthesize bubbleImageView;


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
