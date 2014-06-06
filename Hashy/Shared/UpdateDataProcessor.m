//
//  UpdateDataProcessor.m
//  
//
//  Created by Kurt on 5/28/14.
//


#import "UpdateDataProcessor.h"

static UpdateDataProcessor *_sharedProcessor=nil;


@implementation UpdateDataProcessor
//@synthesize dataContext=_dataContext;
@synthesize currentUserInfo=_currentUserInfo;


+(id) sharedProcessor{
    
    @synchronized(self){

        if (_sharedProcessor == nil){
            
            NSManagedObjectContext *newManagedObjectContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [newManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];

            _sharedProcessor=[[self alloc]init];
            
//            /_sharedProcessor = [[self alloc] initWithContext:newManagedObjectContext];
        }
        
    }
                              
return _sharedProcessor;
                              
}


-(UserInfo*)currentUserInfo {
    if(_currentUserInfo)
        return _currentUserInfo;
    
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    
    
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:[kAppDelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError * error;
    NSArray * items = [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    return [items lastObject];
}




- (void) deleteAllObjects: (NSString *) entityDescription {
    
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:[kAppDelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError * error;
    NSArray * items = [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        
        [[kAppDelegate managedObjectContext] deleteObject:managedObject];
    }
    if (![[kAppDelegate managedObjectContext] save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    self.currentUserInfo = nil;
}


-(void) saveUserDetails:(NSDictionary *)userDict {
    [self deleteAllObjects:@"UserInfo"];
    
    
    UserInfo *userInfo=[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:[kAppDelegate managedObjectContext]];
    
    
    if([userDict valueForKey:@"id"] && ![[userDict valueForKey:@"id"] isEqual:[NSNull null]])
        userInfo.user_id=[NSNumber numberWithInt:[[userDict valueForKey:@"id"]intValue]];
    
    
    if([userDict valueForKey:@"user_name"] && ![[userDict valueForKey:@"user_name"] isEqual:[NSNull null]])
        userInfo.userName=[userDict valueForKey:@"user_name"];
    
    if([userDict valueForKey:@"email"] && ![[userDict valueForKey:@"email"] isEqual:[NSNull null]])
        userInfo.user_email=[userDict valueForKey:@"email"];
    

    if([userDict valueForKey:@"authentication_token"] && ![[userDict valueForKey:@"authentication_token"] isEqual:[NSNull null]])
        userInfo.user_authentication_token=[userDict valueForKey:@"authentication_token"];
    
    if([userDict valueForKey:@"avatar_url"] && ![[userDict valueForKey:@"avatar_url"] isEqual:[NSNull null]])
        userInfo.user_profile_image_url=[userDict valueForKey:@"avatar_url"];
    
    

    
    
    [userInfo.managedObjectContext save:nil];
    [[kAppDelegate managedObjectContext]save:nil];
    
    
    
}



-(void)updateUserDetails:(NSDictionary *)userDict{
    
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_id == %@",[userDict valueForKey:@"user_id"]];
    
    UserInfo *userInfo;
    NSArray *array=[self fetchMultipleEntitiesByName:@"UserInfo" withPredicate:predicate] ;
    
    if (array.count) {
        userInfo=[array objectAtIndex:0];
        
    }
    
    
    if (!userInfo) {
        
        userInfo=[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:[kAppDelegate managedObjectContext]];
        
        
    }
    if([userDict valueForKey:@"id"] && ![[userDict valueForKey:@"id"] isEqual:[NSNull null]])
        userInfo.user_id=[NSNumber numberWithInt:[[userDict valueForKey:@"id"]intValue]];
    
    
    if([userDict valueForKey:@"user_name"] && ![[userDict valueForKey:@"user_name"] isEqual:[NSNull null]])
        userInfo.userName=[userDict valueForKey:@"user_name"];
    
    if([userDict valueForKey:@"email"] && ![[userDict valueForKey:@"email"] isEqual:[NSNull null]])
        userInfo.user_email=[userDict valueForKey:@"email"];
    
    
    if([userDict valueForKey:@"authentication_token"] && ![[userDict valueForKey:@"authentication_token"] isEqual:[NSNull null]])
        userInfo.user_authentication_token=[userDict valueForKey:@"authentication_token"];
    
    if([userDict valueForKey:@"avatar_url"] && ![[userDict valueForKey:@"avatar_url"] isEqual:[NSNull null]])
        userInfo.user_profile_image_url=[userDict valueForKey:@"avatar_url"];
    
    
    
    
    
    [userInfo.managedObjectContext save:nil];
    [[kAppDelegate managedObjectContext]save:nil];
    
    
    
    
    
    
}

//
//-(void)updateUserDetails:(NSDictionary *)userDict{
//    
//    
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_id == %@",[userDict valueForKey:@"user_id"]];
//    
//    UserInfo *userInfo;
//    NSArray *array=[self fetchMultipleEntitiesByName:@"UserInfo" withPredicate:predicate] ;
//    
//    if (array.count) {
//        userInfo=[array objectAtIndex:0];
//        
//    }
//    
//    
//    if (userInfo) {
//        if([userDict valueForKey:@"user_id"] && ![[userDict valueForKey:@"user_id"] isEqual:[NSNull null]])
//            userInfo.user_id=[userDict valueForKey:@"user_id"];
//        
//        
//        if([userDict valueForKey:@"user_name"] && ![[userDict valueForKey:@"user_name"] isEqual:[NSNull null]])
//            userInfo.userName=[userDict valueForKey:@"user_name"];
//        
//        if([userDict valueForKey:@"email"] && ![[userDict valueForKey:@"email"] isEqual:[NSNull null]])
//            userInfo.user_email=[userDict valueForKey:@"email"];
//        
//        
//        if([userDict valueForKey:@"authentication_token"] && ![[userDict valueForKey:@"authentication_token"] isEqual:[NSNull null]])
//            userInfo.user_authentication_token=[userDict valueForKey:@"authentication_token"];
//        
//        if([userDict valueForKey:@"avatar_url"] && ![[userDict valueForKey:@"avatar_url"] isEqual:[NSNull null]])
//            userInfo.user_profile_image_url=[userDict valueForKey:@"avatar_url"];
//        
//        
//        
//        
//        
//        [userInfo.managedObjectContext save:nil];
//        [[kAppDelegate managedObjectContext]save:nil];
//
//    }
//    
//  
//    
//    
//}

#pragma mark fetch Entities

-(NSArray *) fetchMultipleEntitiesByName:(NSString *)entityName withPredicate:(NSPredicate *)predicate{

    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[kAppDelegate managedObjectContext]]];

    if (predicate)
        [fetchRequest setPredicate:predicate];
        NSError *error=nil;

    return [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];

}





//
//-(id) initWithContext:(NSManagedObjectContext *) context{
//    
//    self=[super init];
//    if (self) {
//        self.dataContext=context;
//        
//        self.dataContext.parentContext = [kAppDelegate managedObjectContext];
//        
//     /*  [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(saveContextUpdated:)
//                                                     name:NSManagedObjectContextDidSaveNotification
//                                                   object:self.dataContext];
//        ;
//*/
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(fetchContextUpdated:)
//                                                     name:NSManagedObjectContextDidSaveNotification
//                                                   object:[kAppDelegate managedObjectContext]];
//    }
//    return self;
//    
//}

//
//
//-(UserInfo*)currentUserInfo {
//    if(_currentUserInfo)
//        return _currentUserInfo;
//    
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription * entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:[kAppDelegate managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    
//    NSError * error;
//    NSArray * items = [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//    return [items lastObject];
//}
//
//
///** Method for generating temporary Managed Object Context. **/
//
//+(NSManagedObjectContext *) newManagedOBjectContext{
//    NSPersistentStoreCoordinator *coordinator=[kAppDelegate persistentStoreCoordinator];
//    
//    if (coordinator) {
//        NSManagedObjectContext *newManagedObjectContext=[[NSManagedObjectContext alloc]init];
//        [newManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
//        [newManagedObjectContext setPersistentStoreCoordinator:coordinator];
//        return newManagedObjectContext;
//        
//    }
//    return nil;
//}
// 
//
//-(void)saveMainCategoriesDetails:(NSArray *)categoryArray{
//    
//    [self deleteAllObjects:@"CategoryInfo"];
//    
//    
//       
//    for (NSDictionary *dict in categoryArray) {
//        CategoryInfo *mainCategory=[NSEntityDescription insertNewObjectForEntityForName:@"CategoryInfo" inManagedObjectContext:self.dataContext];
//        if (![[dict valueForKey:@"category_id"]isEqual:[NSNull null]] ) {
//            mainCategory.category_id=[dict valueForKey:@"category_id"];
//
//        }
//        if (![[dict valueForKey:@"category_name"]isEqual:[NSNull null]] ) {
//            mainCategory.category_name=[dict valueForKey:@"category_name"];
//            
//        }
//        [mainCategory.managedObjectContext save:nil];
//        [[kAppDelegate managedObjectContext]save:nil];
//    }
//    
//    
//    
//    
//
//}
//
//
//#pragma mark Save User Recommends
//
//-(void)saveUserRecommendsForCurrentUser:(NSDictionary*)recommendDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id   {
//    
//    RecommendInfo *recomInfo= (RecommendInfo*)  [self fetchEntityByName:@"RecommendInfo" forAttribute:@"recommend_id" Value:[recommendDict valueForKey:@"recommend_id"] inConetxt:context];
//    
//    if(!recomInfo) {
//        
//        recomInfo=[NSEntityDescription insertNewObjectForEntityForName:@"RecommendInfo" inManagedObjectContext:self.dataContext];
//        
//        
//        if ([recommendDict valueForKey:@"category_name"]&&![[recommendDict valueForKey:@"category_name"]isEqual:[NSNull null]]) {
//            recomInfo.category_name=[recommendDict valueForKey:@"category_name"];
//        }
//        
//        if ([recommendDict valueForKey:@"main_category"]&&![[recommendDict valueForKey:@"main_category"]isEqual:[NSNull null]]) {
//            recomInfo.main_category=[recommendDict valueForKey:@"main_category"];
//        }
//        
//        
//        
//        if ([recommendDict valueForKey:@"preview_url"]&&![[recommendDict valueForKey:@"preview_url"]isEqual:[NSNull null]]) {
//            recomInfo.preview_url=[recommendDict valueForKey:@"preview_url"];
//            
//        }
//        if ([recommendDict valueForKey:@"recommend_datetime"]&&![[recommendDict valueForKey:@"recommend_datetime"]isEqual:[NSNull null]]) {
//            NSString *dateString=[recommendDict valueForKey:@"recommend_datetime"];
//            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate *recommendPostDate = [[NSDate alloc] init];
//            
//            recommendPostDate = [dateFormatter dateFromString:dateString];
//            if (recommendPostDate) {
//                recomInfo.recommend_datetime=recommendPostDate;
//                
//            }
//            
//        }
//        
//        
//        if ([recommendDict valueForKey:@"recommend_id"]&&![[recommendDict valueForKey:@"recommend_id"]isEqual:[NSNull null]]) {
//            recomInfo.recommend_id=[recommendDict valueForKey:@"recommend_id"];
//        }
//        if ([recommendDict valueForKey:@"recommend_image_url"]&&![[recommendDict valueForKey:@"recommend_image_url"]isEqual:[NSNull null]]) {
//            recomInfo.recommend_image_url=[recommendDict valueForKey:@"recommend_image_url"];
//            
//        }
//        if ([recommendDict valueForKey:@"recommend_item_group"]&&![[recommendDict valueForKey:@"recommend_item_group"]isEqual:[NSNull null]]) {
//            recomInfo.recommend_item_group=[recommendDict valueForKey:@"recommend_item_group"];
//        }
//        if ([recommendDict valueForKey:@"recommend_item_name"]&&![[recommendDict valueForKey:@"recommend_item_name"]isEqual:[NSNull null]]) {
//            recomInfo.recommend_item_name=[recommendDict valueForKey:@"recommend_item_name"];
//            
//        }
//        if ([recommendDict valueForKey:@"source"]&&![[recommendDict valueForKey:@"source"]isEqual:[NSNull null]]) {
//            recomInfo.source=[recommendDict valueForKey:@"source"];
//        }
//        
//        if ([recommendDict valueForKey:@"track_id"]&&![[recommendDict valueForKey:@"track_id"]isEqual:[NSNull null]]) {
//            recomInfo.track_id=[recommendDict valueForKey:@"track_id"];
//        }
//        
//        if ([recommendDict valueForKey:@"user_id"]&&![[recommendDict valueForKey:@"user_id"]isEqual:[NSNull null]]) {
//            
//            recomInfo.user_id=[recommendDict valueForKey:@"user_id"];
//            
//            
//        }
//      
////        UserInfo *user = (UserInfo*)[context objectWithID:object_id];
////        //[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:context];
////        
////        recomInfo.user_recommend_r= user;
//        
//    }
//    
//    
//}
//
//
//-(void)saveUserRecommends:(NSMutableArray*)recommendArray{
//    
//    
//    for (NSMutableDictionary *recommendDict in recommendArray) {
//        
//        RecommendInfo *recomInfo= (RecommendInfo*)  [self fetchEntityByName:@"RecommendInfo" forAttribute:@"recommend_id" Value:[recommendDict valueForKey:@"recommend_id"]];
//
//        if (!recomInfo) {
//            recomInfo=[NSEntityDescription insertNewObjectForEntityForName:@"RecommendInfo" inManagedObjectContext:self.dataContext];
//            
//            
//            if ([recommendDict valueForKey:@"category_name"]&&![[recommendDict valueForKey:@"category_name"]isEqual:[NSNull null]]) {
//                recomInfo.category_name=[recommendDict valueForKey:@"category_name"];
//            }
//            
//            if ([recommendDict valueForKey:@"main_category"]&&![[recommendDict valueForKey:@"main_category"]isEqual:[NSNull null]]) {
//                recomInfo.main_category=[recommendDict valueForKey:@"main_category"];
//            }
//            
//            
//            
//            if ([recommendDict valueForKey:@"preview_url"]&&![[recommendDict valueForKey:@"preview_url"]isEqual:[NSNull null]]) {
//                recomInfo.preview_url=[recommendDict valueForKey:@"preview_url"];
//                
//            }
//            if ([recommendDict valueForKey:@"recommend_datetime"]&&![[recommendDict valueForKey:@"recommend_datetime"]isEqual:[NSNull null]]) {
//                NSString *dateString=[recommendDict valueForKey:@"recommend_datetime"];
//                
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                
//                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                NSDate *recommendPostDate = [[NSDate alloc] init];
//                
//                recommendPostDate = [dateFormatter dateFromString:dateString];
//                if (recommendPostDate) {
//                    recomInfo.recommend_datetime=recommendPostDate;
//                    
//                }
//                
//            }
//            
//            
//            if ([recommendDict valueForKey:@"recommend_id"]&&![[recommendDict valueForKey:@"recommend_id"]isEqual:[NSNull null]]) {
//                recomInfo.recommend_id=[recommendDict valueForKey:@"recommend_id"];
//            }
//            if ([recommendDict valueForKey:@"recommend_image_url"]&&![[recommendDict valueForKey:@"recommend_image_url"]isEqual:[NSNull null]]) {
//                recomInfo.recommend_image_url=[recommendDict valueForKey:@"recommend_image_url"];
//                
//            }
//            if ([recommendDict valueForKey:@"recommend_item_group"]&&![[recommendDict valueForKey:@"recommend_item_group"]isEqual:[NSNull null]]) {
//                recomInfo.recommend_item_group=[recommendDict valueForKey:@"recommend_item_group"];
//            }
//            if ([recommendDict valueForKey:@"recommend_item_name"]&&![[recommendDict valueForKey:@"recommend_item_name"]isEqual:[NSNull null]]) {
//                recomInfo.recommend_item_name=[recommendDict valueForKey:@"recommend_item_name"];
//                
//            }
//            if ([recommendDict valueForKey:@"source"]&&![[recommendDict valueForKey:@"source"]isEqual:[NSNull null]]) {
//                recomInfo.source=[recommendDict valueForKey:@"source"];
//            }
//            
//            if ([recommendDict valueForKey:@"track_id"]&&![[recommendDict valueForKey:@"track_id"]isEqual:[NSNull null]]) {
//                recomInfo.track_id=[recommendDict valueForKey:@"track_id"];
//            }
//            
//            if ([recommendDict valueForKey:@"user_id"]&&![[recommendDict valueForKey:@"user_id"]isEqual:[NSNull null]]) {
//                
//                recomInfo.user_id=[recommendDict valueForKey:@"user_id"];
//                
//                
//            }
//            UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:self.dataContext];
//            
//            
//            recomInfo.user_recommend_r=user;
//            NSError *error=nil;
//            if(![self.dataContext save:&error])
//                NSLog(@"Like save error %@",[error localizedDescription]);
//            
//           // [recomInfo.managedObjectContext save:nil];
//           //[[kAppDelegate managedObjectContext]save:nil];
//        }
//        
//
//    }
//    
//    
//}
//
//
//#pragma mark Save User Saved Recommends
//
//
//-(void)saveUserSavedRecommends:(NSMutableArray*)savedArray{
//    
//    
//    for (NSMutableDictionary *recommendDict in savedArray) {
//        SaveInfo *saveInfo=[NSEntityDescription insertNewObjectForEntityForName:@"SaveInfo" inManagedObjectContext:self.dataContext];
//        
//        
//        if ([recommendDict valueForKey:@"category_name"]&&![[recommendDict valueForKey:@"category_name"]isEqual:[NSNull null]]) {
//            saveInfo.category_name=[recommendDict valueForKey:@"category_name"];
//        }
//        
//        if ([recommendDict valueForKey:@"main_category"]&&![[recommendDict valueForKey:@"main_category"]isEqual:[NSNull null]]) {
//            saveInfo.main_category=[recommendDict valueForKey:@"main_category"];
//        }
//        
//        
//        
//        if ([recommendDict valueForKey:@"preview_url"]&&![[recommendDict valueForKey:@"preview_url"]isEqual:[NSNull null]]) {
//            saveInfo.preview_url=[recommendDict valueForKey:@"preview_url"];
//            
//        }
//        if ([recommendDict valueForKey:@"recommend_datetime"]&&![[recommendDict valueForKey:@"recommend_datetime"]isEqual:[NSNull null]]) {
//            NSString *dateString=[recommendDict valueForKey:@"recommend_datetime"];
//            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate *recommendPostDate = [[NSDate alloc] init];
//            
//            recommendPostDate = [dateFormatter dateFromString:dateString];
//            if (recommendPostDate) {
//                saveInfo.recommend_datetime=recommendPostDate;
//                
//            }
//            
//        }
//        
//        
//        if ([recommendDict valueForKey:@"recommend_id"]&&![[recommendDict valueForKey:@"recommend_id"]isEqual:[NSNull null]]) {
//            saveInfo.recommend_id=[recommendDict valueForKey:@"recommend_id"];
//        }
//        if ([recommendDict valueForKey:@"recommend_image_url"]&&![[recommendDict valueForKey:@"recommend_image_url"]isEqual:[NSNull null]]) {
//            saveInfo.recommend_image_url=[recommendDict valueForKey:@"recommend_image_url"];
//            
//        }
//        if ([recommendDict valueForKey:@"recommend_item_group"]&&![[recommendDict valueForKey:@"recommend_item_group"]isEqual:[NSNull null]]) {
//            saveInfo.recommend_item_group=[recommendDict valueForKey:@"recommend_item_group"];
//        }
//        if ([recommendDict valueForKey:@"recommend_item_name"]&&![[recommendDict valueForKey:@"recommend_item_name"]isEqual:[NSNull null]]) {
//            saveInfo.recommend_item_name=[recommendDict valueForKey:@"recommend_item_name"];
//            
//        }
//        if ([recommendDict valueForKey:@"source"]&&![[recommendDict valueForKey:@"source"]isEqual:[NSNull null]]) {
//            saveInfo.source=[recommendDict valueForKey:@"source"];
//        }
//        
//        if ([recommendDict valueForKey:@"track_id"]&&![[recommendDict valueForKey:@"track_id"]isEqual:[NSNull null]]) {
//            saveInfo.track_id=[recommendDict valueForKey:@"track_id"];
//        }
//        
//        if ([recommendDict valueForKey:@"user_id"]&&![[recommendDict valueForKey:@"user_id"]isEqual:[NSNull null]]) {
//            
//            saveInfo.user_id=[recommendDict valueForKey:@"user_id"];
//            
//            
//        }
//        UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:self.dataContext];
//        
//        
//        saveInfo.user_save_r=user;
//        
//        
//        [saveInfo.managedObjectContext save:nil];
//        [[kAppDelegate managedObjectContext]save:nil];
//    }
//
//    
//    
//}
//
//
////-(void) checkAndSave:(NSManagedObject *)managedObject{
////    
////    NSManagedObject *existingObject=[self findExistingObjects:managedObject];
////    NSError *error=nil;
////    BOOL anyChanged=NO;
////    if (existingObject) {
////        
////    for (NSString *key in [[[managedObject entity]attributesByName]allKeys])
////        {
////            if(! (([existingObject valueForKey:key]==nil)&& ([managedObject valueForKey:key]==nil)) && ![[existingObject valueForKey:key] isEqual:[managedObject valueForKey:key]] ){
////                [existingObject setValue:[managedObject valueForKey:key] forKey:key];
////                anyChanged=YES;
////            }
////        }
////        if (anyChanged) {
////            if (![existingObject.managedObjectContext save:&error]) {
////                NSLog(@"Saving Error: %@",[error localizedDescription]);
////                
////            }
////        }
////        [managedObject.managedObjectContext deleteObject:managedObject];
////        [self handleChangeForObject:managedObject];
////        }
////    
////    else{
////        [self handleChangeForObject:managedObject];
////        if (![[managedObject managedObjectContext]save:&error]) {
////            NSLog(@"Saving Error: %@",[error localizedDescription]);
////        }
////        anyChanged=YES;
////    }
////    
////NSLog(@"%@",managedObject);
////
////
////}
//
//
//
//#pragma  mark Check Object's Existence and then Update or Insert
//
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *)entityName withPredicate:(NSPredicate *)predicate{
//    
//    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[kAppDelegate managedObjectContext]]];
//
//    if (predicate)
//        [fetchRequest setPredicate:predicate];
//        NSError *error=nil;
//        
//    return [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//    
//}
//
//
//
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *)entityName{
//    
//    
//    return [self fetchMultipleEntitiesByName:entityName withPredicate:nil];
//            
//}
//
//-(NSManagedObject *) fetchEntityByName:(NSString *)entityName forAttribute:(NSString *)attributeName Value:(NSString *)value inConetxt:(NSManagedObjectContext *) context{
//
//    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
//    
//    NSPredicate *predicate=nil;
//    
//    predicate=[NSPredicate predicateWithFormat:@"%K=%@",attributeName,value];
//    
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error=nil;
//    NSArray *results=[context executeFetchRequest:fetchRequest error:&error] ;
//    NSManagedObject *resultObject=[results lastObject];
//    fetchRequest=nil;
//    results=nil;
//    return  resultObject;
//    
//    
//}
//
//
//-(NSManagedObject *) fetchEntityByName:(NSString *)entityName forAttribute:(NSString *)attributeName Value:(NSString *)value
//{
//    
//    
//    return [self fetchEntityByName:entityName forAttribute:attributeName Value:value inConetxt:[kAppDelegate managedObjectContext]];
//}
//
//
////- (NSManagedObject *) findExistingObjects:(id)object {
////    
////    return [self findExistingObjects:[object valueForKey:[object identityColumn]] identityColumn:[object identityColumn] inEntity:[[object entity]name]];
////}
////
////
////- (NSManagedObject *) findExistingObjects:(NSString *)identityValue identityColumn:(NSString *)identityName inEntity:(NSString *)entity {
////    
////    
////    return [self fetchEntityByName:entity forAttribute:identityName Value:identityValue];
////    
////    
////}
//
//
//
//-(void) handleChangeForObject:(NSManagedObject *) managedObject{
//    
//}
//                              
//- (void) deleteAllObjects: (NSString *) entityDescription {
//    
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription * entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:[kAppDelegate managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    
//    NSError * error;
//    NSArray * items = [[kAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//    
//    for (NSManagedObject *managedObject in items) {
//        
//        [[kAppDelegate managedObjectContext] deleteObject:managedObject];
//    }
//    if (![[kAppDelegate managedObjectContext] save:&error]) {
//        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
//    }
//    self.currentUserInfo = nil;
//}
//
//
//#pragma mark Save User Details
//
//
//-(void) saveUserDetails:(NSDictionary *)userDict {
//    [self deleteAllObjects:@"UserInfo"];
//    
//    
//        UserInfo *userInfo=[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:self.dataContext];
//  
//    
////    if(![[userDict valueForKey:@"id"] isEqual:[NSNull null]]){
////       // userInfo.user_id=[userDict valueForKey:@"id"];
////        userInfo.user_id=@"151";
////
////        
////    }
//    
//    
//    NSMutableArray *userInfoArray=[userDict valueForKey:@"user_info"];
//    if (userInfoArray.count>0) {
//        
//        NSDictionary *userDetailDict=[userInfoArray objectAtIndex:0];
//        if(![[userDetailDict valueForKey:@"user_id"] isEqual:[NSNull null]])
//            userInfo.user_id=[userDetailDict valueForKey:@"user_id"];
//        
//        if(![[userDetailDict valueForKey:@"username"] isEqual:[NSNull null]])
//            userInfo.user_name=[userDetailDict valueForKey:@"username"];
//        
//        
//        
//        if(![[userDetailDict valueForKey:@"user_firstname"] isEqual:[NSNull null]])
//            userInfo.user_firstname=[userDetailDict valueForKey:@"user_firstname"];
//        
//        if(![[userDetailDict valueForKey:@"user_bio"] isEqual:[NSNull null]]&&(![[userDetailDict valueForKey:@"user_bio"]isEqualToString:@"0"]))
//            userInfo.user_bio=[userDetailDict valueForKey:@"user_bio"];
//        
//        if(![[userDetailDict valueForKey:@"user_location"] isEqual:[NSNull null]] && ![[userDict valueForKey:@"location"] isEqualToString:@"0"] )
//            userInfo.user_location=[userDetailDict valueForKey:@"user_location"];
//        
//        if(![[userDetailDict valueForKey:@"user_lastname"] isEqual:[NSNull null]])
//            userInfo.user_lastname=[userDetailDict valueForKey:@"user_lastname"];
//        
//        
//        if (![[userDetailDict valueForKey:@"user_profile_pic"]isEqual:[NSNull null]])
//            userInfo.user_profile_picture=[userDetailDict valueForKey:@"user_profile_pic"];
//        
//        if(![[userDetailDict valueForKey:@"user_email"] isEqual:[NSNull null]])
//            userInfo.user_email=[userDetailDict valueForKey:@"user_email"];
//        
//        if(![[userDict valueForKey:@"recommend_remain_count"] isEqual:[NSNull null]])
//        {   NSString *count_left=[NSString stringWithFormat:@"%@",[userDict valueForKey:@"recommend_remain_count"]];
//            int recomm_left=[count_left intValue];
//            userInfo.user_recommendation_left= [NSNumber numberWithInt:recomm_left];
//            
//            
//        }
//        NSLog(@"%@",userInfo);
//        [userInfo.managedObjectContext save:nil];
//        [[kAppDelegate managedObjectContext]save:nil];
//    }
//    
//     
//  //      [self checkAndSave:userInfo];
//    
//}
//
////-(BOOL)isBeingFollowed:(NSString*)user_id {
////
////    
////    UserFollowing *followingObject =(UserFollowing*) [self fetchEntityByName:@"UserFollowing" forAttribute:@"user_id" Value:user_id];
////    
////    if(followingObject)
////        return YES;
////    
////    else return NO;
////    
////}
////
////-(void)saveFollowingForCurrentUser:(NSDictionary*)followingDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id    {
////
////    UserFollowing *userFollowing = (UserFollowing*)[self fetchEntityByName:@"UserFollowing" forAttribute:@"user_id" Value:[followingDict valueForKey:@"user_id"] inConetxt:context];
////    if(!userFollowing) {
////        UserFollowing *userFollowing=[NSEntityDescription insertNewObjectForEntityForName:@"UserFollowing" inManagedObjectContext:context];
////        
////        
////        
////        if(![[followingDict valueForKey:@"user_id"] isEqual:[NSNull null]])
////            userFollowing.user_id=[followingDict valueForKey:@"user_id"];
////        if(![[followingDict valueForKey:@"user_name"] isEqual:[NSNull null]])
////            userFollowing.user_name=[followingDict valueForKey:@"user_name"];
////        UserInfo *user = (UserInfo*)[context objectWithID:object_id];
////        
////        userFollowing.user_info_r = user;
//////        if(![context save:nil])
////  //          NSLog(@"ERROR ON SAVE");
////    }
////
////}
////
////
////
////
////-(void)saveFollowingForCurrentUser:(NSDictionary*)followingDict {
////    
////    UserFollowing *userFollowing = (UserFollowing*)[self fetchEntityByName:@"UserFollowing" forAttribute:@"user_id" Value:[followingDict valueForKey:@"user_id"] inConetxt:self.dataContext];
////    if(!userFollowing) {
////    UserFollowing *userFollowing=[NSEntityDescription insertNewObjectForEntityForName:@"UserFollowing" inManagedObjectContext:self.dataContext];
////    
////    
////    
////    if(![[followingDict valueForKey:@"user_id"] isEqual:[NSNull null]])
////        userFollowing.user_id=[followingDict valueForKey:@"user_id"];
////    if(![[followingDict valueForKey:@"user_name"] isEqual:[NSNull null]])
////        userFollowing.user_name=[followingDict valueForKey:@"user_name"];
////    
////    UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:self.dataContext];
////    
////    userFollowing.user_info_r = user;
////        if(![self.dataContext save:nil])
////            NSLog(@"ERROR ON SAVE");
////        [[kAppDelegate managedObjectContext]save:nil];
////    }
//// //   [self checkAndSave:userFollowing];
////    
////}
////
//
//-(BOOL)isBeingLiked:(NSString *) recommend_id{
//    
//    LikeInfo *likeObject =(LikeInfo*) [self fetchEntityByName:@"LikeInfo" forAttribute:@"like_recommend_id" Value:recommend_id];
//   // NSLog(@"%@",likeObject);
//   // LikeInfo *likeObject =(LikeInfo*) [self fetchEntityByName:@"LikeInfo" forAttribute:nil Value:nil];
//
//    
//    if(likeObject)
//        return YES;
//    
//    else return NO;
//
//}
//
//
//
//
//
//
//-(void)saveLikeForCurrentUser:(NSDictionary*)recommendDict inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id   {
//
//    LikeInfo *like_post= (LikeInfo*)  [self fetchEntityByName:@"LikeInfo" forAttribute:@"like_recommend_id" Value:[recommendDict valueForKey:@"recommend_id"] inConetxt:context];
//    
//    if(!like_post) {
//        
//        like_post=[NSEntityDescription insertNewObjectForEntityForName:@"LikeInfo" inManagedObjectContext:context];
//        if(![[recommendDict valueForKey:@"recommend_id"] isEqual:[NSNull null]])
//            like_post.like_recommend_id=[recommendDict valueForKey:@"recommend_id"];
//        
//        UserInfo *user = (UserInfo*)[context objectWithID:object_id];
//        //[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:context];
//        
//        like_post.user_like_r= user;
//      
//    }
//
//}
//
//
////
////-(BOOL)isRetrendSaved:(NSString*)image_id {
////    
////    TrendInfo *trendObj =(TrendInfo*) [self fetchEntityByName:@"TrendInfo" forAttribute:@"trend_id" Value:image_id];
////    
////    if(trendObj)
////        return YES;
////    
////    else return NO;
////
////
////}
////
////-(void)saveRetrendForCurrentUser:(NSDictionary*)imageDict  inContext:(NSManagedObjectContext*)context currentUserObjectID:(NSManagedObjectID*)object_id{
////    TrendInfo *trend_object= (TrendInfo*)  [self fetchEntityByName:@"TrendInfo" forAttribute:@"trend_id" Value:[imageDict valueForKey:@"image_id"] inConetxt:context];
////    if(!trend_object) {
////        trend_object=[NSEntityDescription insertNewObjectForEntityForName:@"TrendInfo" inManagedObjectContext:context];
////
//////        UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:context];
////        
////        trend_object.trend_id  = [imageDict valueForKey:@"image_id"];
////        trend_object.user_trend_r = (UserInfo*)[context objectWithID:object_id];
////        NSError *Error =nil;
////        if(![context save:&Error])
////            NSLog(@"Trend save error %@",[Error localizedDescription]);
////       // [[kAppDelegate managedObjectContext]save:nil];
////        
////    }
////
////
////    
////    
////
////}
////
//
//-(void)saveLikeForCurrentUser:(NSDictionary*)imageDict {
//    
// LikeInfo *like_post= (LikeInfo*)  [self fetchEntityByName:@"LikeInfo" forAttribute:@"like_recommend_id" Value:[imageDict valueForKey:@"recommend_id"]];
//
//    if(!like_post) {
//    
//like_post=[NSEntityDescription insertNewObjectForEntityForName:@"LikeInfo" inManagedObjectContext:self.dataContext];
//    if(![[imageDict valueForKey:@"recommend_id"] isEqual:[NSNull null]])
//        like_post.like_recommend_id=[imageDict valueForKey:@"recommend_id"];
//        
//    UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:self.dataContext];
//    
//    like_post.user_like_r= user;
//        NSError *Error =nil;
//        if(![self.dataContext save:&Error])
//            NSLog(@"Like save error %@",[Error localizedDescription]);
//       // [[kAppDelegate managedObjectContext]save:nil];
//
//    }
//    
//   // [self checkAndSave:like_post];
//    
//}
//
//
//-(void)removeLikeForCurrentUser:(NSDictionary*)imageDict {
//    
//    LikeInfo *like_post= (LikeInfo*)  [self fetchEntityByName:@"LikeInfo" forAttribute:@"like_recommend_id" Value:[imageDict valueForKey:@"recommend_id"]];
//    
//    if(like_post) {
//        
//        [[kAppDelegate managedObjectContext] deleteObject:like_post];
//        
//        NSError *Error =nil;
//        if(![[kAppDelegate managedObjectContext] save:&Error])
//            NSLog(@"Like delete error %@",[Error localizedDescription]);
//    }
//    
//    // [self checkAndSave:like_post];
//    
//}
////
////
////-(void)deleteFollowingForID:(NSString*)follow_id {
////    UserFollowing *following = (UserFollowing*)[self fetchEntityByName:@"UserFollowing" forAttribute:@"user_id" Value:follow_id inConetxt:self.dataContext];
////    
////    if(following) {
////    
////        NSError *error = nil;
////        [self.dataContext deleteObject:following];
////        
////        if(![self.dataContext save:&error])
////            NSLog(@"%@",[error localizedDescription]);
////        [[kAppDelegate managedObjectContext]save:nil];
////
////    }
////    
////    
////}
////
////-(void)deleteNotifications:(NSPredicate*)predicate{
////
////   
////    NSArray *notificationArray = [self fetchMultipleEntitiesByName:@"NotificationInfo" withPredicate:predicate];
////    
////    for (NSManagedObject *object in notificationArray) {
////        [[kAppDelegate managedObjectContext] deleteObject:object];
////    }
////        NSError *error = nil;
////
////        if(![[kAppDelegate managedObjectContext] save:&error])
////            NSLog(@"%@",[error localizedDescription]);
////
////    
////}
////
////-(void)saveNotification:(NSDictionary*)notificationDict inContext:(NSManagedObjectContext*)context{
////    
////    //NSManagedObjectContext *newContext = [UpdateDataProcessor newManagedOBjectContext];
////
////    NotificationInfo *notificationObj = (NotificationInfo*)  [self fetchEntityByName:@"NotificationInfo" forAttribute:@"notificationID" Value:[notificationDict valueForKey:@"notification_id"] inConetxt:context];
////   if(!notificationObj) {
////
////        notificationObj=[NSEntityDescription insertNewObjectForEntityForName:@"NotificationInfo" inManagedObjectContext:context];
////    NSLog(@"NEW NOTIFICATION OBJECT INSERTED");
////        if(![[notificationDict valueForKey:@"notification_id"] isEqual:[NSNull null]])
////            notificationObj.notificationID=[notificationDict valueForKey:@"notification_id"];
////      //  UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:context];
////        notificationObj.is_read = [NSNumber numberWithBool:NO];
////        if(![[notificationDict valueForKey:@"user_id"] isEqual:[NSNull null]])
////            notificationObj.notification_user=[notificationDict valueForKey:@"user_id"];
////
////        if(![[notificationDict valueForKey:@"image_id"] isEqual:[NSNull null]])
////            notificationObj.image_id=[notificationDict valueForKey:@"image_id"];
////        if(![[notificationDict valueForKey:@"user_name"] isEqual:[NSNull null]])
////            notificationObj.notification_user=[notificationDict valueForKey:@"user_name"];
////        if(![[notificationDict valueForKey:@"notification_id"] isEqual:[NSNull null]])
////            notificationObj.notificationID=[notificationDict valueForKey:@"notification_id"];
////        if(![[notificationDict valueForKey:@"date"] isEqual:[NSNull null]])
////            notificationObj.notification_date=[Utility getDateFromString:[notificationDict valueForKey:@"date"]] ;
////        if(![[notificationDict valueForKey:@"type"] isEqual:[NSNull null]])
////            notificationObj.notification_type=[notificationDict valueForKey:@"type"];
////        
////        if(![[notificationDict valueForKey:@"img_tag"] isEqual:[NSNull null]])
////            notificationObj.image_tag=[notificationDict valueForKey:@"img_tag"];
////
////        
////        if(![[notificationDict valueForKey:@"user_picture"] isEqual:[NSNull null]])
////            notificationObj.user_picture=[notificationDict valueForKey:@"user_picture"];
////        
////        if(![[notificationDict valueForKey:@"user_id"] isEqual:[NSNull null]]){
////          //  NSLog(@"%@",notificationObj.notification_user_id);
////            
////            notificationObj.notification_user_id=[notificationDict valueForKey:@"user_id"];
////        }
////    
////    NSLog(@"NEW NOTIFICATION OBJECT ASSIGNED");
////
////
////       // notificationObj.userInfo_notificationInfo_r= user;
////        NSError *Error =nil;
////        if(![context save:&Error])
////            NSLog(@"Notification save error %@",[Error localizedDescription]);
////   }
////  //  }
////
////}
////
////-(void)saveFanForCurrentUser:(NSDictionary*)fanDict {
////    UserFans *userfan =(UserFans*) [self fetchEntityByName:@"UserFans" forAttribute:@"user_id" Value:[fanDict valueForKey:@"user_id"] inConetxt:self.dataContext];
////    if(!userfan) {
////    
////    userfan=[NSEntityDescription insertNewObjectForEntityForName:@"UserFans" inManagedObjectContext:self.dataContext];
////    if(![[fanDict valueForKey:@"user_id"] isEqual:[NSNull null]])
////        userfan.fan_id=[fanDict valueForKey:@"user_id"];
////    if(![[fanDict valueForKey:@"user_name"] isEqual:[NSNull null]])
////        userfan.fan_name=[fanDict valueForKey:@"user_name"];
////    
////    UserInfo *user = (UserInfo*)[self fetchEntityByName:@"UserInfo" forAttribute:@"user_id" Value:self.currentUserInfo.user_id inConetxt:self.dataContext];
////    
////    userfan.userinfo_r = user;
////        
////        [userfan.managedObjectContext save:nil];
////        [[kAppDelegate managedObjectContext]save:nil];
////
////    }
////  //  [self checkAndSave:userfan];
////
////}
//
//
//
//
//-(void)fetchContextUpdated:(NSNotification*)notification {
//    
// [self.dataContext mergeChangesFromContextDidSaveNotification:notification];
//    
//}
//
//-(void)saveContextUpdated:(NSNotification*)notification {
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[kAppDelegate managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
//
//    });
//}
//
//
@end
