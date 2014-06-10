//
//  HYAppDelegate.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "HYAppDelegate.h"

@implementation HYAppDelegate
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


-(void)addImage{
    
    NSMutableDictionary *imageDict=[[NSMutableDictionary alloc]init];
    
    [imageDict setValue:@"http://hashyapi.heroku.com/assets/Vintage-Controller.png" forKey:@"avatar_url"];
    
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc]init];
    [userDict setValue:imageDict forKey:@"user"];
    
    
    [[NetworkEngine sharedNetworkEngine]putRequestForNewUser:^(id object) {
        
    } onError:^(NSError *error) {
        
    } withParams:userDict  ];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    NSLog(@"App started");
    [PubNub setDelegate:self];
    CustomNavigationController *navController =[kStoryBoard instantiateViewControllerWithIdentifier:@"custom_nav"];
    self.window.rootViewController =navController;
    
    
//    HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
//    
//    [navController setViewControllers:[NSArray arrayWithObject:profileVC] animated:YES];
    
//    AddImageViewController *imageVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"addImage_vc"];
//    
//    [navController setViewControllers:[NSArray arrayWithObject:imageVC] animated:YES];

    
    
//    HYSignInViewController *signInVC = [kStoryBoard instantiateViewControllerWithIdentifier:@"signIn_vc"];
//    
//    [navController setViewControllers:[NSArray arrayWithObject:signInVC] animated:YES];
    
    // add bugsnag bug tracking
  //  [Bugsnag startBugsnagWithApiKey:kBugSnagAPIKey];

    
     
    
    if ([[UpdateDataProcessor sharedProcessor]currentUserInfo]) {
        
        HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
        [navController setViewControllers:[NSArray arrayWithObject:listChatVC] animated:YES];
        
    }
    else{
       
        HYSignInViewController *signInVC = [kStoryBoard instantiateViewControllerWithIdentifier:@"signIn_vc"];
        
        [navController setViewControllers:[NSArray arrayWithObject:signInVC] animated:YES];

        
    }
    

    

    
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Core Data stack
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    //    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Whoorli" withExtension:@"momd"];
    __managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSString *storePath = [[HYAppDelegate applicationDocumentsDirectory] stringByAppendingPathComponent: @"Hashy.sqlite"];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    
    NSError * error = nil;
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                              [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}



#pragma mark Pub Nub Delegate Methods

// #1 Delegate looks for subscribe events
- (void)pubnubClient:(PubNub *)client didSubscribeOnChannels:(NSArray *)channels {

    NSLog(@"DELEGATE: Subscribed to channel:%@", channels);
    
    
}

- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    
    
    
    PNLog(PNLogGeneralLevel, self, @"PubNub client received message: %@", message);
    NSMutableDictionary *messageDict=[[NSMutableDictionary alloc]init];
    [messageDict setValue:message forKey:@"message"];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNewMessageReceived object:nil userInfo:messageDict];
    
    
}


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
+ (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark HUD methods
-(void)showProgressHUD  {
    if(HUD)
        HUD = nil;
    
    HUD = [[MBProgressHUD alloc] initWithWindow:self.window];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    
	[HUD show:YES];
    
    //[self showProgressHUDWithText:@"Loading" inView:self.window];
    
}

-(void)showProgressHUDWithText:(NSString*)labelText inView:(UIView*)view{
    if(HUD){
        [HUD removeFromSuperview];
        HUD = nil;
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = labelText;
    
	[HUD show:YES];
    
}

-(void)showProgressHUD:(UIView*)view {
    
    [self showProgressHUDWithText:@"Loading" inView:view];
}


-(void)hideProgressHUD {
    if(HUD){
        
        [HUD hide:YES];
    }
}


@end
