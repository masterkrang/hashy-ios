//
//  HYChatRoomViewController.h
//  Hashy
//
//  Created by attmac107 on 6/4/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "JSQMessagesViewController.h"
#import "JSQMessages.h"
#import "Utility.h"
#import "NetworkEngine.h"

@interface HYChatRoomViewController : JSQMessagesViewController<JSQMessagesCollectionViewDataSource,JSQMessagesCollectionViewDelegateFlowLayout>
{
    
    
}
@property(nonatomic,strong)IBOutlet UICollectionView *chatRoomCollectionView;

@property(nonatomic,strong) NSMutableDictionary *chatDict;


@property(nonatomic,strong) NSMutableArray * messages;
@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;
@property(nonatomic,strong) NSString *subscribersCountString;
@property(nonatomic,strong) NSString *chatNameString;

@property (copy, nonatomic) NSDictionary *avatars;


@end
