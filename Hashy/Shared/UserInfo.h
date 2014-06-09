//
//  UserInfo.h
//  Hashy
//
//  Created by Kurt on 6/3/14.
//
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
