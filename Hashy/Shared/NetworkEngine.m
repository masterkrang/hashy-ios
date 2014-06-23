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

//#define bucketName @"Hashy_Bucket"
#define bucketName @"hashyimages"
#define kSearchChannels @"/search_channels.json"
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

#pragma mark Register For Push Notifications

-(void)registerForPushNotifications:(completion_block)completionBlock onError:(error_block)errorBlock for_device_token:(NSString *)device_token{
    if(!device_token || ![[device_token class] isSubclassOfClass:[NSString class]])
        return;
    NSString *urlString=[NSString stringWithFormat:@"%@/push_service_tokens",kServerHostName];


    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setValue:device_token forKey:@"device_token"];
    [paramDict setValue:@"iOS" forKey:@"platform"];
    
    NSMutableDictionary *push_param_dict=[[NSMutableDictionary alloc]init];
    [push_param_dict setValue:paramDict forKey:@"push_service_token"];
    
    NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token);
    
    [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];

    
    [self.httpManager POST:urlString parameters:push_param_dict success:^(AFHTTPRequestOperation *operation, id responseObject) {

                  NSLog(@"%@",operation);
          NSLog(@"%@",responseObject);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        
//        NSLog(@"%@",error);
//        NSLog(@"Failed to send APNS token to platform");
 
        
        
    }];
    

       
//    
//    [self.httpManager postPath:@"push_service_tokens" parameters:@{@"push_service_token":@{@"device_token":device_token, @"service":@"apns"}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"Failed to send APNS token to platform");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed to send APNS token to platform");
//    }];

    
}

#pragma mark Other API methods


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



-(void)getUserProfile:(completion_block)completionBlock onError:(error_block)errorBlock forUserID:(NSString *)user_id{
    
    
    NSLog(@"%@",[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token);
    
    NSString *urlString=[NSString stringWithFormat:@"%@/users/%@/profile.json",kServerHostName,user_id];
   // [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];

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


-(void)getChatLists:(completion_block)completionBlock onError:(error_block)errorBlock forPageNumber:(int) pageNumber forSearchedText:(NSString *)searchedText{
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];

    NSString *urlString=[NSString stringWithFormat:@"%@%@?page=%@&per=25",kServerHostName,kGetChats,pageNumberStr];
    

    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //  NSLog(@"JSON: %@", responseObject);
        
        NSHTTPURLResponse *response= operation.response;
        
        NSLog(@"%@",response.allHeaderFields);
        
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




-(void)getChatMessagesForChatRoom:(completion_block)completionBlock onError:(error_block)errorBlock forChatID:(NSString *)chat_id forPageNumber:(int) pageNumber
{
    
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];

    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/messages.json?per=25&page=%@",kServerHostName,chat_id,pageNumberStr];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"JSON: %@", responseObject);
        
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




-(void)getChatForChatRoom:(completion_block)completionBlock onError:(error_block)errorBlock forChatID:(NSString *)chat_id forPageNumber:(int) pageNumber
{
    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@.json",kServerHostName,chat_id];
    
    [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //  NSLog(@"JSON: %@", responseObject);
        
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



-(void)getSubscribersList:(completion_block)completionBlock onError:(error_block)errorBlock forChatID:(NSString *)chat_id forPageNumber:(int) pageNumber{
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];

    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/subscribers.json?page=%@&per=15",kServerHostName,chat_id,pageNumberStr];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     //   NSLog(@"JSON: %@", responseObject);
        
        NSHTTPURLResponse *response= operation.response;
        
        if (response.statusCode==200) {
            
            if(responseObject &&![responseObject isEqual:[NSNull null]] && [responseObject isKindOfClass:[NSArray class]])
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



-(void)getRecentChatsForAUser:(completion_block)completionBlock onError:(error_block)errorBlock forUserID:(NSString *)user_id forPageNumber:(int) pageNumber{
    
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];

    NSString *urlString=[NSString stringWithFormat:@"%@/users/%@/chats.json?page=%@&per=25",kServerHostName,user_id,pageNumberStr];
    
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


//
//-(void)getAllHashTags:(completion_block)completionBlock onError:(error_block)errorBlock forSearchedText:(NSString *)searchedText forPageNumber:(int) pageNumber{
//
//    
//    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/subscribers.json",kServerHostName,searchedText];
//    
//    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        
//        NSHTTPURLResponse *response= operation.response;
//        
//        if (response.statusCode==200) {
//            
//            if(responseObject &&![responseObject isEqual:[NSNull null]])
//            {
//                completionBlock(responseObject);
//            }
//            else errorBlock(nil);
//            
//            
//        }
//        else{
//            errorBlock(nil);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //[Utility showAlertWithString:@"Network problem \n try again later"];
//        //[theAppDelegate hideProgressHUD];
//        errorBlock(error);
//    }];
//    
//
//    
//    
//}



-(void)createNewHashTag:(completion_block)completionBlock onError:(error_block)errorBlock params:(NSDictionary *)param {
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kGetChats];
    
    [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];

    
    [self.httpManager POST:urlString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"channel"] &&![[responseObject objectForKey:@"channel"]isEqual:[NSNull null]])
        {
            completionBlock(responseObject);

//            NSHTTPURLResponse *response=operation.response;
//            
//            if (response.statusCode == 200 ) {
//                
//            }
//            else{
//                errorBlock(nil);
//            }
            
          
        }
        else errorBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[Utility showAlertWithString:@"Network problem \n try again later"];
        //[theAppDelegate hideProgressHUD];
        errorBlock(error);
    }];
    
    
    
}

-(void)searchChannels:(completion_block)completionBlock onError:(error_block)errorBlock forSearchedText:(NSString *)searched_text forPageNumber:(int) pageNumber{
    
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];
    NSString *urlString=[NSString stringWithFormat:@"%@%@?term=%@&page=%@&per=25",kServerHostName,kSearchChannels,searched_text,pageNumberStr];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //  NSLog(@"JSON: %@", responseObject);
        
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



-(void)searchSubscribers:(completion_block)completionBlock onError:(error_block)errorBlock forChat_id:(NSString *)chat_id forSearchedText:(NSString *)searched_text forPageNumber:(int) pageNumber{
    
    NSString *pageNumberStr=[NSString stringWithFormat:@"%d",pageNumber];
    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/search_subscribers.json?term=%@&page=%@&per=15",kServerHostName,chat_id,searched_text,pageNumberStr];
    
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

-(void)sendMessage:(completion_block)completionBlock onError:(error_block)errorBlock forChatID:(NSString *)chat_id withParams:(NSMutableDictionary *)params{
    
    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/messages.json",kServerHostName,chat_id];
    
    [self.httpManager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
     //   NSLog(@"JSON: %@", responseObject);
        
        if([responseObject objectForKey:@"message"] &&![[responseObject objectForKey:@"message"]isEqual:[NSNull null]])
        {
            completionBlock(responseObject);
//
//            NSHTTPURLResponse *response=operation.response;
//            
//            if (response.statusCode == 200 ) {
//                
//            }
//            else{
//                errorBlock(nil);
//            }
            
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



- (void)saveAmazoneURLImage:(UIImage*)image completionBlock:(upload_completeBlock)completionBlock onError:(error_block)errorBlock{
    
    NSString* idName=[NSString stringWithFormat:@"%@.jpg", [[NSProcessInfo processInfo] globallyUniqueString]];
    
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWSAccessKeyId withSecretKey:AWSSecretKey];
    if(![AWSAccessKeyId isEqualToString:@"AKIAJGVJQYYLQOVZGJWQ"]
       && s3 == nil)
    {
        // Initial the S3 Client.
        s3 = [[AmazonS3Client alloc] initWithAccessKey:AWSAccessKeyId withSecretKey:AWSSecretKey] ;
        // s3.endpoint = [AmazonEndpoints s3Endpoint:US_WEST_2];
        
        // Create the picture bucket.
        S3CreateBucketRequest *createBucketRequest = [[S3CreateBucketRequest alloc] initWithName:bucketName andRegion:nil] ;
        S3CreateBucketResponse *createBucketResponse = [s3 createBucket:createBucketRequest];
        if(createBucketResponse.error != nil)
        {
            NSLog(@"Error: %@", createBucketResponse.error);
        }
    }
    
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        @try {
            // Upload image data.  Remember to set the content type.
            S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:idName inBucket:bucketName];
            por.contentType = @"image/jpeg";
            por.data        = imageData;
            por.cannedACL   = [S3CannedACL publicRead];
            // Put the image data into the specified s3 bucket and object.
            S3PutObjectResponse *putObjectResponse = [s3 putObject:por];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(putObjectResponse.error != nil)
                {
                    NSLog(@"Error: %@", putObjectResponse.error);
                    [self valueForKey:[putObjectResponse.error.userInfo objectForKey:@"message"]];
                }
            });
        }
        
        @catch(AmazonClientException *exception) {
            NSLog(@"exception");
        }
        
    });
    
    
    S3ResponseHeaderOverrides *override = [[S3ResponseHeaderOverrides alloc] init] ;
    override.contentType = @"image/jpeg";
    
    S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init] ;
    gpsur.key     = idName;
    gpsur.bucket  =bucketName;
    gpsur.expires = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 3600];  // Added an hour's worth of seconds to the current time.
    gpsur.responseHeaderOverrides = override;
    
    
    NSURL *url = [s3 getPreSignedURL:gpsur];
    NSString *pathString=[NSString stringWithFormat:@"%@%@%@",@"https://",[url host],[url path]];
    
    completionBlock(pathString);
    
}



- (void)saveAmazoneURLImageInChatRoomScreen:(UIImage*)image completionBlock:(upload_completeBlock)completionBlock onError:(error_block)errorBlock{
    
    NSString* idName=[NSString stringWithFormat:@"%@.jpg", [[NSProcessInfo processInfo] globallyUniqueString]];
    __block NSString *pathString;
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWSAccessKeyId withSecretKey:AWSSecretKey];
    if(![AWSAccessKeyId isEqualToString:@"AKIAJGVJQYYLQOVZGJWQ"]
       && s3 == nil)
    {
        // Initial the S3 Client.
        s3 = [[AmazonS3Client alloc] initWithAccessKey:AWSAccessKeyId withSecretKey:AWSSecretKey] ;
        // s3.endpoint = [AmazonEndpoints s3Endpoint:US_WEST_2];
        
        // Create the picture bucket.
        S3CreateBucketRequest *createBucketRequest = [[S3CreateBucketRequest alloc] initWithName:bucketName andRegion:nil] ;
        S3CreateBucketResponse *createBucketResponse = [s3 createBucket:createBucketRequest];
        if(createBucketResponse.error != nil)
        {
            NSLog(@"Error: %@", createBucketResponse.error);
        }
    }
    
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        @try {
            // Upload image data.  Remember to set the content type.
            S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:idName inBucket:bucketName];
            por.contentType = @"image/jpeg";
            por.data        = imageData;
            por.cannedACL   = [S3CannedACL publicRead];
            // Put the image data into the specified s3 bucket and object.
            S3PutObjectResponse *putObjectResponse = [s3 putObject:por];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(putObjectResponse.error != nil)
                {
                    NSLog(@"Error: %@", putObjectResponse.error);
                    [self valueForKey:[putObjectResponse.error.userInfo objectForKey:@"message"]];
                }
                else{
                    
                    completionBlock(pathString);
                    
                }
            });
        }
        
        @catch(AmazonClientException *exception) {
            NSLog(@"exception");
        }
        
    });
    
    
    S3ResponseHeaderOverrides *override = [[S3ResponseHeaderOverrides alloc] init] ;
    override.contentType = @"image/jpeg";
    
    S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init] ;
    gpsur.key     = idName;
    gpsur.bucket  =bucketName;
    gpsur.expires = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 3600];  // Added an hour's worth of seconds to the current time.
    gpsur.responseHeaderOverrides = override;
    
    
    NSURL *url = [s3 getPreSignedURL:gpsur];
    pathString=[NSString stringWithFormat:@"%@%@%@",@"https://",[url host],[url path]];
    
    
}

-(void)deleteSubscription:(completion_block)completionBlock onError:(error_block)errorBlock forChatID:(NSString *)chat_id{
    
    NSString *urlString=[NSString stringWithFormat:@"%@/chats/%@/remove_subscription.json",kServerHostName,chat_id];
    [self.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_authentication_token] forHTTPHeaderField:@"Authorization"];

    [self.httpManager DELETE:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //   NSLog(@"JSON: %@", responseObject);
        
        completionBlock(responseObject);

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
