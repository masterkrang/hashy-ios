//
//  SubscriptionCustomCell.m
//  Hashy
//
//  Created by attmac107 on 6/20/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import "SubscriptionCustomCell.h"

@implementation SubscriptionCustomCell
@synthesize hashTitleLabel;
@synthesize subscriptionSwitch;


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
