//
//  NetworkEngine.m
//  TrendStartr
//
//  Created by attmac104 on 22/10/12.
//  Copyright (c) 2012 Apptree Studio. All rights reserved.
//
#import "NetworkEngine.h"
#import "UpdateDataProcessor.h"
#import <Foundation/Foundation.h>

#define kLoginViaFacebook @"webservices/insertUserFbProfile"


static NetworkEngine *sharedNetworkEngine=nil;


@implementation NetworkEngine


+(id) sharedNetworkEngine{
    @synchronized(self) {
        
        if (sharedNetworkEngine==nil)
            sharedNetworkEngine=[[self alloc]init];
    }
    return sharedNetworkEngine;
    
}


-(void)checkForUserAvailablity:(completion_block)completionBlock onError:(error_block)errorBlock userID:(NSString *)user_id{
    
    
    [self.httpManager checkUsername:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"status"] &&![[responseObject objectForKey:@"status"]isEqual:[NSNull null]])
        {
            if([[responseObject objectForKey:@"status"]isEqualToString:@"failed"])
            {
                // [theAppDelegate hideProgressHUD];
                // [Utility showAlertWithString:[responseObject valueForKey:@"error_string"]];
                
            }
            else  completionBlock(responseObject);
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    
    
}


-(void) loginViaFacebook:(completion_block)completionBlock onError:(error_block)errorBlock params:(NSArray *)dict{


    [self.httpManager GET:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"status"] &&![[responseObject objectForKey:@"status"]isEqual:[NSNull null]])
        {
            if([[responseObject objectForKey:@"status"]isEqualToString:@"failed"])
            {
               // [theAppDelegate hideProgressHUD];
               // [Utility showAlertWithString:[responseObject valueForKey:@"error_string"]];
                
            }
            else  completionBlock(responseObject);
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    

}


-(void) postSubCategory:(completion_block)completionBlock onError:(error_block)errorBlock categoryName:(NSArray *)categoryNameArray{
    
//    NSMutableURLRequest *request=[Utility makeRequestForservicePathArray:kAddSubcategory httpMethod:@"POST" params:categoryNameArray isSSL:NO withURLParam:nil];
//    
//    [AsyncURLConnection request:request completeBlock:^(NSData *data) {
//        id object=[data objectFromJSONData];
//        //NSLog(@"Object  %@",object);
//        
//        // id object1=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        //NSLog(@"Object 1%@",object1);
//        
//        if (!object) {
//            NSError *error=[NSError errorWithDomain:@"null response" code:1 userInfo:nil];
//            errorBlock(error);
//            
//        }
//        else
//            completionBlock(object);
//        
//        
//        
//    } errorBlock:^(NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//        errorBlock(error);
//        
//    }];
    
    
    
}




@end
