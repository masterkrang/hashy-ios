//
//  NetworkEngine.h
//  TrendStartr
//
//  Created by attmac104 on 22/10/12.
//  Copyright (c) 2012 Apptree Studio. All rights reserved.
//

/*
 
 Class used for declaring webservices. It is a sub class of NSObject.
 */
#import <Accounts/Accounts.h>
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
typedef void (^completion_block)(id object);
typedef void (^error_block)(NSError *error);
typedef void (^upload_completeBlock)(NSString *url);
//static NSString * const kGoogleClientId = @"27209247905.apps.googleusercontent.com";

@interface NetworkEngine : NSObject{
    
    
}
+ (id)sharedNetworkEngine;
@property(nonatomic,strong) AFHTTPRequestOperationManager *httpManager;


-(void) loginViaFacebook:(completion_block) completionBlock onError:(error_block)errorBlock params:(NSArray *)dict;

-(void)checkForUserAvailablity:(completion_block)completionBlock onError:(error_block)errorBlock userID:(NSString *)user_id;



@end
