//
//  Constants.h
//  Hashy
//
//  Created by Kurt on 5/27/14.
//

#ifndef Hashy_Constants_h
#define Hashy_Constants_h

#define kAppDelegate (HYAppDelegate *)[[UIApplication sharedApplication]delegate]
//#define kServerHostName @"www.hashy.co"
#define kServerHostName @"http://www.hashy.co"

#define kStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define isIOSVersion7 [[UIDevice currentDevice].systemVersion floatValue]>=7
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define kHexValueLightGreenColor @"2fc81e"
#define kHexValueInvalidSignUpColor @"ffbbbc"
#define kHexValueValidSignUpColor @"bfeeba"
#define kHexValueNonActiveSignUpColor @"eaeaea"

#define kHelVeticaNeueUltralight @"HelveticaNeue-UltraLight"
#define kHelVeticaNeueLight @"HelveticaNeue-Light"
#define kHelVeticaNeueMedium @"HelveticaNeue-Medium"
//#define kHelVeticaNeueRegular @"HelveticaNeue-Regular"
#define kHelVeticaNeueRegular @"HelveticaNeue"

#define kHelVeticaLight @"Helvetica-Light"
#define kHelVeticaBold @"Helvetica-Bold"

#define kGetColor(x) [Utility colorWithHexString:@"x"]
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kBugSnagAPIKey @"a74e21a5a5aba85cd06a66257cc22c27"
#define AWSAccessKeyId @"AKIAJGVJQYYLQOVZGJWQ"
#define AWSSecretKey   @"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"

#define kPubNubSubscribeKey   @"sub-c-815bc3d0-ebb3-11e3-b0c6-02ee2ddab7fe"
#define kPubNubPublishKey   @"sub-c-815bc3d0-ebb3-11e3-b0c6-02ee2ddab7fe"
#define kPubNubSecretKey   @"sec-c-MTE3MmFjNzEtN2Q4NC00Y2MxLWJlODYtNGMwMTE1ZGZlMzFh"
#define kNewMessageReceived @"NewMessageReceivedNotification"


#endif
