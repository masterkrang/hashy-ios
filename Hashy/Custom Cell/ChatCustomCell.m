//
//  ChatCustomCell.m
//  Hashy
//
//  Created by Kurt on 6/6/14.
//
//

#import "ChatCustomCell.h"
//#define kLongPressMinimumDuration 1.0f
#define kLongPressMinimumDuration 0.5f

@implementation ChatCustomCell
@synthesize userNameLabel;
@synthesize messageLabel;
//@synthesize topLeftImageView;
//@synthesize topRightImageView;
//@synthesize bottomLeftImageView;
//@synthesize bottomRightImageView;
@synthesize bubbleImageView;
@synthesize pictureImageView;
@synthesize activityIndicatorView,delegate;
-(void)awakeFromNib
{
   UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
     longPressGestureRecognizer.delegate = self;
    longPressGestureRecognizer.minimumPressDuration = kLongPressMinimumDuration;
    [self.messageLabel addGestureRecognizer:longPressGestureRecognizer];
    
    
    UILongPressGestureRecognizer *longPressPictureGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressPictureGestureRecognizer.delegate = self;
    longPressPictureGestureRecognizer.minimumPressDuration = kLongPressMinimumDuration;

    [self.pictureImageView addGestureRecognizer:longPressPictureGestureRecognizer];
}

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
//-(void)longPress:(UILongPressGestureRecognizer*)gesture
//{
//    NSLog(@"Log press gesture call");
//}
- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    // BOOL isLongPressOpen;
    if (gesture.state==UIGestureRecognizerStateBegan) {
      
        if([self.delegate respondsToSelector:@selector(startLongPressGestureCallForCell:)])
            [self.delegate startLongPressGestureCallForCell:self];
    }
    
    
    
//    if ( gesture.state == UIGestureRecognizerStateEnded ) {
//        
//        
//        if([self.delegate respondsToSelector:@selector(startLongPressGestureCallForCell:)])
//            [self.delegate startLongPressGestureCallForCell:self];
//        
//        
//        //Do something on long press....for example ill code for UIAlertView.
////        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Demo" message:@"Long Press Countered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
////        [alert show];
//    }
}
@end
