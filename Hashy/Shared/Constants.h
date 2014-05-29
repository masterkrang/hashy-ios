//
//  Constants.h
//  Hashy
//
//  Created by Kurt on 5/27/14.
//

#ifndef Hashy_Constants_h
#define Hashy_Constants_h

#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication]delegate]
//#define kServerHostName @"www.hashy.co"
#define kServerHostName @"http://www.hashy.co"

#define kStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define isIOSVersion7 [[UIDevice currentDevice].systemVersion floatValue]>=7
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#endif
