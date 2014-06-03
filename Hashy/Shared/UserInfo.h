//
//  UserInfo.h
//  Hashy
//
//  Created by attmac107 on 6/3/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * user_authentication_token;
@property (nonatomic, retain) NSDate * user_creation_date;
@property (nonatomic, retain) NSString * user_email;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * user_profile_image_url;
@property (nonatomic, retain) NSString * userName;

@end
