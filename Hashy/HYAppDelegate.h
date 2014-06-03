//
//  HYAppDelegate.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "HYListChatViewController.h"
#import "HYSignInViewController.h"
#import <CoreData/CoreData.h>
#import "AddImageViewController.h"
#import "Bugsnag.h"

@interface HYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (NSString *)applicationDocumentsDirectory ;

@end
