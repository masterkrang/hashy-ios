//
//  HYDisplayImageViewController.h
//  Hashy
//
//  Created by attmac107 on 6/23/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+AFNetworking.h>

@interface HYDisplayImageViewController : UIViewController
{
    
    UIActivityIndicatorView *activityIndicatorView;
}

@property(nonatomic,strong) IBOutlet UIImageView *selectedImageView;
@property(nonatomic,strong) NSString  *image_url_string;
@property(nonatomic,strong) NSString  *chat_name_string;

@property(nonatomic,strong) UIImage *selected_image;


@end
