//
//  ProfileCustomCell.m
//  Hashy
//
//  Created by attmac107 on 5/27/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "ProfileCustomCell.h"

@implementation ProfileCustomCell
@synthesize hashTaglabel;
@synthesize userNameLabel;
@synthesize onlineUsersCount;
@synthesize nextButton;
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
