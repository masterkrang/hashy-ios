//
//  NetworkEngine.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//
#import "NetworkEngine.h"
#import "UpdateDataProcessor.h"
#import <Foundation/Foundation.h>

#define kGetRandomAvatar @"/random_avatar.json"
#define kCreateNewUser @"/users.json"

//#define kCreateNewUser @"/users/sign_up.json"

#define kGetChats @"/chats.json"
#define kGetUsernameAvailability @"/user_name_available.json"
#define kLoginHashy @"/login.json"



static NetworkEngine *sharedNetworkEngine=nil;


@implementation NetworkEngine



-(id)init {
    
    self = [super init];
    
    if(self) {
        self.httpManager = [AFHTTPRequestOperationManager manager];
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
        
    }
    
    return self;
}

+(id) sharedNetworkEngine{
    @synchronized(self) {
        
        if (sharedNetworkEngine==nil)
            sharedNetworkEngine=[[self alloc]init];
    }
    return sharedNetworkEngine;
    
}


-(void)getRandomAvatar:(completion_block)completionBlock onError:(error_block)errorBlock{

    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kGetRandomAvatar];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"avatar_url"] &&![[responseObject objectForKey:@"avatar_url"]isEqual:[NSNull null]])
        {
            if([[responseObject objectForKey:@"avatar_url"]isEqualToString:@"failed"])
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




-(void)checkForUserAvailablity:(completion_block)completionBlock onError:(error_block)errorBlock userName:(NSString *)user_name forRequestManager:(AFHTTPRequestOperationManager *)manager{
    
    //user_name_available.json
    ///user_name_available.json?user_name=bobby
    NSString *urlString=[NSString stringWithFormat:@"%@%@?user_name=%@",kServerHostName,kGetUsernameAvailability,user_name];
//
//    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kGetUsernameAvailability];
//
//    
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//    [dict setObject:user_name forKey:@"user_name"];
    
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"status"] &&![[responseObject objectForKey:@"status"]isEqual:[NSNull null]])
        {
            
                        
            completionBlock(responseObject);
//            BOOL status=[[responseObject valueForKey:@"status"]boolValue] ;
//            
//            
//            if(!status)
//            {
//                errorBlock(nil);
//                // [theAppDelegate hideProgressHUD];
//                // [Utility showAlertWithString:[responseObject valueForKey:@"error_string"]];
//                
//            }
//            else  completionBlock(responseObject);
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    
    
//    [manager checkUsername:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        
//        if([responseObject objectForKey:@"status"] &&![[responseObject objectForKey:@"status"]isEqual:[NSNull null]])
//        {
//            if([[responseObject objectForKey:@"status"]isEqualToString:@"failed"])
//            {
//                // [theAppDelegate hideProgressHUD];
//                // [Utility showAlertWithString:[responseObject valueForKey:@"error_string"]];
//                
//            }
//            else  completionBlock(responseObject);
//        }
//        else errorBlock(nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //[Utility showAlertWithString:@"Network problem \n try again later"];
//        //[theAppDelegate hideProgressHUD];
//        errorBlock(error);
//    }];
    
    
}



-(void)loginHashy:(completion_block)completionBlock onError:(error_block)errorBlock withParams:(NSMutableDictionary *)params{

    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kLoginHashy];
    
    
    [self.httpManager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"session"] &&![[responseObject objectForKey:@"session"]isEqual:[NSNull null]])
        {
            
            NSHTTPURLResponse *response=operation.response;
            
            if (response.statusCode == 200 ) {
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(nil);
            }
            
               }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSHTTPURLResponse *response= operation.response;
        NSLog(@"%@",response);
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    
    //[self.httpManager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)  failure:^(AFHTTPRequestOperation *operation, NSError *error) ];
    
}


-(void)putRequestForNewUser:(completion_block)completionBlock onError:(error_block)errorBlock withParams:(NSMutableDictionary *)params {
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kCreateNewUser];
    
    NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token);
    
   // [manager.requestSerializer
 //   [self.httpManager.requestSerializer setValue:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token forHTTPHeaderField:@"authentication_token"];
    [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];

    [self.httpManager PUT:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if(responseObject && ![responseObject isEqual:[NSNull null]])
        {
            
            NSHTTPURLResponse *response=operation.response;
            
            if (response.statusCode == 200 ) {
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(nil);
            }
            
   
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        errorBlock(error);
        
        
    }];
    
}


-(void)createNewUser:(completion_block)completionBlock onError:(error_block)errorBlock withParams:(NSMutableDictionary *)params{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kCreateNewUser];
    
    [self.httpManager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"user"] &&![[responseObject objectForKey:@"user"]isEqual:[NSNull null]])
        {
            
            NSHTTPURLResponse *response=operation.response;
            
            if (response.statusCode == 200 ) {
                completionBlock(responseObject);

            }
            else{
                errorBlock(nil);
            }
            
//            if([[responseObject objectForKey:@"user"]isEqualToString:@"failed"])
//            {
//                // [theAppDelegate hideProgressHUD];
//                // [Utility showAlertWithString:[responseObject valueForKey:@"error_string"]];
//                
//            }
//            else
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    
}

-(void)getChatLists:(completion_block)completionBlock onError:(error_block)errorBlock forPageNumber:(int) pageNumber forSearchedText:(NSString *)searchedText{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kGetChats];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSHTTPURLResponse *response= operation.response;
        
        if (response.statusCode==200) {
            
            if(responseObject &&![responseObject isEqual:[NSNull null]])
            {
                completionBlock(responseObject);
            }
            else errorBlock(nil);

            
        }
        else{
            errorBlock(nil);
        }
        
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
