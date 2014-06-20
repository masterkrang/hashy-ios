//
//  UpdateDataProcessor.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//



#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"
#import "HYAppDelegate.h"

@interface UpdateDataProcessor : NSObject{
    
}
+(id) sharedProcessor;
@property(strong, nonatomic) UserInfo *currentUserInfo;
-(void) saveUserDetails:(NSDictionary *)userDict ;
-(void)updateUserDetails:(NSDictionary *)userDict;
-(NSArray *) fetchMultipleEntitiesByName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (void) deleteAllObjects: (NSString *) entityDescription;

//-(void) checkAndSave:(NSManagedObject *) managedObject;
//-(NSManagedObject *) fetchEntityByName:(NSString *) entityName forAttribute:(NSString *) attribute Value:(NSString *) value;
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *) entityName withPredicate:(NSPredicate *) predicate;
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *) entityName;
//+(NSManagedObjectContext *) newManagedOBjectContext;
//-(void) saveUserDetails:(NSDictionary *)userDict;
//- (void) deleteAllObjects: (NSString *) entityDescription ;
//-(void)saveMainCategoriesDetails:(NSArray *)categoryDict;



@property(strong,nonatomic) NSManagedObjectContext *dataContext;

//@property(strong, nonatomic) UserInfo *currentUserInfo;






//-(BOOL)isBeingFollowed:(NSString*)user_id ;
//-(void)saveRetrendForCurrentUser:(NSDictionary*)imageDict  inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id;
//-(void)saveFollowingForCurrentUser:(NSDictionary*)followingDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id;
//-(void)saveFanForCurrentUser:(NSDictionary*)fanDict;
//-(void)saveFollowingForCurrentUser:(NSDictionary*)followingDict ;
//-(void)deleteFollowingForID:(NSString*)follow_id ;
//-(BOOL) isBeingLiked:(NSString *) imageID;
//-(void)saveLikeForCurrentUser:(NSDictionary*)imageDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id ;
//-(void)saveLikeForCurrentUser:(NSDictionary*)imageDict;
//-(void)removeLikeForCurrentUser:(NSDictionary*)imageDict;
////-(void)saveNotification:(NSDictionary*)notificationDict inContext:(NSManagedObjectContext*)context;
////-(void)deleteNotifications:(NSPredicate*)predicate;
////-(BOOL)isRetrendSaved:(NSString*)image_id;
//
//
//-(void)saveUserRecommends:(NSMutableArray*)recommendArray;
//-(void)saveUserSavedRecommends:(NSMutableArray*)savedArray;
//-(void)saveUserRecommendsForCurrentUser:(NSDictionary*)recommendDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id;


@end
