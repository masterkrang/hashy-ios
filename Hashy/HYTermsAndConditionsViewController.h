//
//  HYTermsAndConditionsViewController.h
//  Hashy
//
//  Created by attmac107 on 7/15/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTermsAndConditionsViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>
{
    
    
}

@property(nonatomic,strong) IBOutlet UIWebView *webView;
@property(nonatomic,strong) NSString *url_string;
@end
