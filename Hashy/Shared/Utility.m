//
//  Utility.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "Utility.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+animatedGIF.h"
@implementation Utility


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//+(NSMutableURLRequest *) makeRequestForservicePathString:(NSString *)service httpMethod:(NSString *)method params:(NSString *)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param{
//    
//    NSString *httpRequest=is_SSL?@"https://":@"http://";
//    NSString *servicePath=[NSString stringWithFormat:@"%@%@%@",httpRequest,kServerHostName,service];
//    if(param &&[param length]>0)
//        servicePath = [servicePath stringByAppendingFormat:@"/%@",param];
//    
//    
//    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:servicePath];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    [request setHTTPMethod:method];
//    if ([method isEqualToString:@"POST"]) {
//        [request setHTTPBody:[paramDict JSONData]];
//        
//        //NSLog(@"%@",[paramDict JSONData]);
//        //NSLog(@"%@",[paramDict JSONString]);
//    
//        //NSLog(@"%@",[NSArray arrayWithObjects:[NSJSONSerialization JSONObjectWithData:[paramDict JSONData] options:0 error:nil],nil]);
//        
//       // [NSJSONSerialization JSONObjectWithData:[paramDict JSONString] options:0 error:nil],nil]
//      //  NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:[paramDict dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]);
//               //        if ([paramDict count] > 0) {
//        //            NSMutableString *postString = [[NSMutableString alloc] init];
//        //            NSArray *allKeys = [paramDict allKeys];
//        //            for (int i = 0; i < [allKeys count]; i++) {
//        //                NSString *key = [allKeys objectAtIndex:i];
//        //                NSString *value = [paramDict objectForKey:key];
//        //                [postString appendFormat:( (i == 0) ? @"%@=%@" : @"&%@=%@"),key,value];
//        //            }
//        //
//        //            //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//        //            [request setHTTPBody:[paramDict JSONData]];
//        ////NSLog(@"Dict %@",[postString dataUsingEncoding:NSUTF8StringEncoding]);
//        //            NSError *error=nil;
//        //            NSLog(@"Json Data%@",[NSJSONSerialization dataWithJSONObject:paramDict  options:kNilOptions error:&error]);
//        //        }
//    }
//    
//    NSLog(@"%@",[request description]);
//    return request;
//    
//    
//}
//
//
//+(NSMutableURLRequest *) makeRequestForservicePathArray:(NSString *)service httpMethod:(NSString *)method params:(NSArray*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param{
//    
//    NSString *httpRequest=is_SSL?@"https://":@"http://";
//    NSString *servicePath=[NSString stringWithFormat:@"%@%@%@",httpRequest,kServerHostName,service];
//    if(param &&[param length]>0)
//        servicePath = [servicePath stringByAppendingFormat:@"/%@",param];
//    
//    
//    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:servicePath];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    [request setHTTPMethod:method];
//    if ([method isEqualToString:@"POST"]) {
//        NSError *error=nil;
//        
//        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:paramDict
//                                                         options:kNilOptions
//                                                           error:&error];
//        [request setHTTPBody:jsonData];
//       // NSLog(@"JSON Array \n%@\n",[paramDict JSONString]);
//        
//        //        if ([paramDict count] > 0) {
//        //            NSMutableString *postString = [[NSMutableString alloc] init];
//        //            NSArray *allKeys = [paramDict allKeys];
//        //            for (int i = 0; i < [allKeys count]; i++) {
//        //                NSString *key = [allKeys objectAtIndex:i];
//        //                NSString *value = [paramDict objectForKey:key];
//        //                [postString appendFormat:( (i == 0) ? @"%@=%@" : @"&%@=%@"),key,value];
//        //            }
//        //
//        //            [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//        //
//        //        }
//    }
//    
//    NSLog(@"%@",[request description]);
//    return request;
//    
//    
//}
//
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param{
//    
//    NSString *httpRequest=is_SSL?@"https://":@"http://";
//    NSString *servicePath=[NSString stringWithFormat:@"%@%@%@",httpRequest,kServerHostName,service];
//    if(param &&[param length]>0)
//        servicePath = [servicePath stringByAppendingFormat:@"/%@",param];
//    
//    
//    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:servicePath];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    [request setHTTPMethod:method];
//    if ([method isEqualToString:@"POST"]) {
////        NSError *error=nil;
////        
////        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:paramDict
////                                                         options:kNilOptions
////                                                           error:&error];
////        [request setHTTPBody:[paramDict JSONData]];
////        NSLog(@"JSON Array \n%@\n",[paramDict JSONString]);
////
//////        NSError *error=nil;
//////        
//////        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:paramDict
//////                                                         options:kNilOptions
//////                                                           error:&error];
////       // [request setHTTPBody:[paramDict JSONData]];
////        //NSLog(@"JSON Array \n%@\n",[paramDict JSONString]);
//        
//        if ([paramDict count] > 0) {
//            NSMutableString *postString = [[NSMutableString alloc] init];
//            NSArray *allKeys = [paramDict allKeys];
//            for (int i = 0; i < [allKeys count]; i++) {
//                NSString *key = [allKeys objectAtIndex:i];
//                NSString *value = [paramDict objectForKey:key];
//                [postString appendFormat:( (i == 0) ? @"%@=%@" : @"&%@=%@"),key,value];
//            }
//            
//            [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//            //[request setHTTPBody:[paramDict JSONData]];
//            //NSLog(@"Dict %@",[postString dataUsingEncoding:NSUTF8StringEncoding]);
//            //NSError *error=nil;
//            //NSLog(@"Json Data%@",[NSJSONSerialization dataWithJSONObject:paramDict  options:kNilOptions error:&error]);
//        }
//    }
//    
//    NSLog(@"%@",[request description]);
//    return request;
//    
//    
//}



+(NSString*)getFormattedNumberStringFor:(int)number {

    float float_num = (float)number;
    NSString *formatted_number = @"";
    if(number>1000) {
          float remainder =(float)(number%1000);
if(remainder>0)
        formatted_number = [NSString stringWithFormat:@"%.1fK", (float_num/1000)];
else formatted_number = [NSString stringWithFormat:@"%dK", (number/1000)];

        
    }
    else if(number>10000){
        float remainder =(float)(number%10000);

        if(remainder>0)
        formatted_number = [NSString stringWithFormat:@"%.1fK", float_num/10000];
        else formatted_number = [NSString stringWithFormat:@"%dK", (number/10000)];

    }
    else if(number>1000000){
        float remainder =(float)(number%1000000);
        
        if(remainder>0)
        formatted_number = [NSString stringWithFormat:@"%.1fM", float_num/1000000];
        
        else formatted_number = [NSString stringWithFormat:@"%dM", (number/1000000)];

    }
    else if(number>10000000){
        
        float remainder =(float)(number%10000000);

        if(remainder>0)
        formatted_number = [NSString stringWithFormat:@"%.1fM", float_num/10000000];
        else formatted_number = [NSString stringWithFormat:@"%dM", (number/10000000)];

        
    }
    
    else formatted_number = [NSString stringWithFormat:@"%d", number];
    return formatted_number;
}

//+(UIImage*)loadImageWithName:(NSString*)file_name {
//NSString * filePath = [AppDelegate applicationDocumentsDirectory];
//    filePath = [filePath stringByAppendingPathComponent:file_name];
//
//    return [[UIImage alloc]initWithContentsOfFile:filePath];
//}

//+ (BOOL)savePic:(UIImage*)image {
//    
//    NSData * imageData = UIImagePNGRepresentation(image);
//    NSString * filePath = [AppDelegate applicationDocumentsDirectory];
//    
//    
//    NSString * fileName = @"user_cover_image";
//    
//    fileName = [fileName stringByAppendingPathExtension:@"png"];
//    filePath = [filePath stringByAppendingPathComponent:fileName];
//    
//    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//       [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//
//    return [imageData writeToFile:filePath atomically:YES];
//}


//+(CGFloat) heightOfLabel :(NSString*)text andWidth:(CGFloat)width fontSize:(CGFloat)size
//{
//    CGSize titleSize = {0, 0};
//    
//   // NSLog(@"text=%@,size=%f",text,size);
//    if (text && ![text isEqualToString:@""])
////    titleSize=[text ]
//        
//        
//    titleSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:size]
//                             constrainedToSize:CGSizeMake(width, 999)
//                             lineBreakMode:UILineBreakModeWordWrap];
//    return titleSize.height;
//    
//    
//}



+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{
    // iOS7
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        CGSize sizeOfText = [aString boundingRectWithSize: aSize
                                                  options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                               attributes: [NSDictionary dictionaryWithObject:aFont
                                                                                       forKey:NSFontAttributeName]
                                                  context: nil].size;
        
        return ceilf(sizeOfText.height);
    }
    
    // iOS6
    CGSize textSize = [aString sizeWithFont:aFont
                          constrainedToSize:aSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(textSize.height);


}


+(CGSize)heightOfTextString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{
    // iOS7
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        CGSize sizeOfText = [aString boundingRectWithSize: aSize
                                                  options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                               attributes: [NSDictionary dictionaryWithObject:aFont
                                                                                       forKey:NSFontAttributeName]
                                                  context: nil].size;
        
        return sizeOfText;
    }
    
    // iOS6
    CGSize textSize = [aString sizeWithFont:aFont
                          constrainedToSize:aSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return textSize;
    
    
}



+ (NSMutableURLRequest*) makeMultipartDataForParams:(NSDictionary*)paramDict path:(NSString *)service httpMethod:(NSString *)method{
    
    
        NSString *boundary = [NSString stringWithFormat:@"---------------------------44247638221121663601275327610"];
        NSMutableData *body = [NSMutableData data];
    
    for (NSString *key in [paramDict allKeys]) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
         
        if([key isEqualToString:@"recomm_image_url"]){
             [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"user_pic.png\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
               [body appendData:[paramDict objectForKey:key] ];
        }
    
        else {
          [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[paramDict valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
        }

     
       
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
      //  [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"submit\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
   [body appendData:[@"SUBMIT" dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
     NSString *httpRequest=@"http://";
    
    NSString *servicePath=[NSString stringWithFormat:@"%@%@%@",httpRequest,kServerHostName,service];

    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:servicePath];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];

    [request setHTTPBody:body];
    NSLog(@"%@",request);
    return request;
    //
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Disposition: form-data; name= \"user[display_photo]\"; filename=\hulk.jpg\\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    //this appends the image data
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//       // [body appendData:data];
//       [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //   return body;
}

+(void)showAlertForError:(NSError*)error {

    [Utility showAlertWithString:[NSString stringWithFormat:@"Error: %@",error.localizedDescription]];
}

+(void)showAlertWithString:(NSString*)message {

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    
}
+(NSDate *) getDateFromString:(NSString *)dateString{

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
  //  NSLog(@"%@",[dateFormatter dateFromString:dateString]);
    
    return [dateFormatter dateFromString:dateString];
    
    
}
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param{
//
//    NSString *httpRequest=is_SSL?@"https://":@"http://";
//    NSString *servicePath=[NSString stringWithFormat:@"%@%@/%@/%@",httpRequest,kServerHostName,service,kAPIKey];
//    if(param &&[param length]>0)
//        servicePath = [servicePath stringByAppendingFormat:@"/%@",param];
//    
//    
//    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:servicePath];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:method];
//    if ([method isEqualToString:@"POST"]) {
//        if ([paramDict count] > 0) {
//            NSMutableString *postString = [[NSMutableString alloc] init];
//            NSArray *allKeys = [paramDict allKeys];
//            for (int i = 0; i < [allKeys count]; i++) {
//                NSString *key = [allKeys objectAtIndex:i];
//                NSString *value = [paramDict objectForKey:key];
//                [postString appendFormat:( (i == 0) ? @"%@=%@" : @"&%@=%@"),key,value];
//            }
//            
//            [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//            
//        }
//    }
//    
//    NSLog(@"%@",[request description]);
//    return request;
//
//    
//}

+(void) paddingTextField:(UITextField *) textField

{

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
	textField.leftView = paddingView;
	textField.leftViewMode = UITextFieldViewModeAlways;
    
}

+(void) paddingTextFieldInSearchController:(UITextField *) textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
	textField.leftView = paddingView;
	textField.leftViewMode = UITextFieldViewModeAlways;

}

//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL{
//    
//    return [Utility makeRequestForservicePath:service httpMethod:method params:paramDict isSSL:is_SSL withURLParam:nil];
//
//}

+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type overLay:(UIView*)overlayView {
    
    
    
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    if([vc conformsToProtocol:@protocol(UIImagePickerControllerDelegate)])
        imagePickerController.delegate = vc;
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.wantsFullScreenLayout = YES;
    
       
    NSArray * media = [UIImagePickerController availableMediaTypesForSourceType:
                       UIImagePickerControllerSourceTypeCamera];
    if([media count] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        if(overlayView){
            imagePickerController.showsCameraControls = NO;

            imagePickerController.cameraOverlayView = overlayView;
        }

        imagePickerController.mediaTypes = [NSArray arrayWithObject:@"public.image"];
        [imagePickerController setSourceType:source_type];
        
    }
    else {
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }
    [vc presentViewController:imagePickerController animated:YES completion:nil];
    
}

+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type {
  
    return [Utility openImagePickerControllerForViewController:vc source:source_type overLay:nil];

}
+(void)openImagePickerControllerForViewController:(UIViewController<  UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc {

    return [Utility openImagePickerControllerForViewController:vc source:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

+(UIImage* )resizedImage:(UIImage *)inImage rect:(CGRect) thumbRect
{
    CGImageRef	imageRef = [inImage CGImage];
    CGImageAlphaInfo	alphaInfo = CGImageGetAlphaInfo(imageRef);
    // There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
    // see Supported Pixel Formats in the Quartz 2D Programming Guide
    // Creating a Bitmap Graphics Context section
    // only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
    // and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
    // The images on input here are likely to be png or jpeg files
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,	// width
                                                thumbRect.size.height,	// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage*	result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);	// ok if NULL
    CGImageRelease(ref);
    
    return result;
}
+(void)setGridImage:(UIImage*)image forButton:(UIButton *)button {

    UIImageView *gridImageView;
    gridImageView = (UIImageView*)[button viewWithTag:1];
    
    if(!gridImageView){
        gridImageView = [[UIImageView alloc]init];
        gridImageView.frame = CGRectMake(5, 5, button.frame.size.width-11, button.frame.size.height-11);
        [button addSubview:gridImageView];
        gridImageView.tag = 1;
    }
    gridImageView.hidden = NO;
    gridImageView.image = image;
   
    UIImageView *placeholderImageView;
    placeholderImageView = (UIImageView*)[button viewWithTag:2];
    
    if(!placeholderImageView){
        placeholderImageView = [[UIImageView alloc]init];
        placeholderImageView.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
        [button addSubview:placeholderImageView];
        [button sendSubviewToBack:placeholderImageView];
        placeholderImageView.tag = 2;
        placeholderImageView.image = [UIImage imageNamed:@"thumbnail_placeholder.png"];
    }
    placeholderImageView.hidden = NO;
    UIImageView *playImageView;
    playImageView = (UIImageView*)[button viewWithTag:23];
    
    if(!playImageView){
        playImageView = [[UIImageView alloc]init];
        playImageView.frame = CGRectMake(25, 25, button.frame.size.width/2, button.frame.size.height/2);
        
        [button addSubview:playImageView];
        //  [button sendSubviewToBack:placeholderImageView];
        playImageView.tag = 23;
        playImageView.image = [UIImage imageNamed:@"feed_play_watermark.png"];
        playImageView.hidden = YES;
    }


}
//
//+(void)setGridImage:(NSString*)urlString forButton:(UIButton*)button changeURL:(BOOL)shouldChange{
//    
//    if(shouldChange){
//    NSString *component = [urlString lastPathComponent];
//    NSString *path = [urlString stringByDeletingLastPathComponent];
//    
//    component = [NSString stringWithFormat:@"small_%@",component];
//    ;
//
//    urlString = [path stringByAppendingPathComponent:component];
//        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//
//    }
//    UIImageView *gridImageView;
//    gridImageView = (UIImageView*)[button viewWithTag:1];
//    
//    if(!gridImageView){
//        gridImageView = [[UIImageView alloc]init];
//        gridImageView.frame = CGRectMake(1, 1, button.frame.size.width-2, button.frame.size.height-2);
//        
//        [button addSubview:gridImageView];
//        gridImageView.tag = 1;
//    }
//
//    gridImageView.hidden = NO;
//    if(urlString&&![urlString isEqual:[NSNull null]])
//    [gridImageView  setImageWithURL:[NSURL URLWithString:urlString]];
//    
//    UIImageView *placeholderImageView;
//    placeholderImageView = (UIImageView*)[button viewWithTag:2];
//    
//    if(!placeholderImageView){
//        placeholderImageView = [[UIImageView alloc]init];
//        placeholderImageView.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
//        //placeholderImageView.contentMode=UIViewContentModeScaleAspectFill;
//        [button addSubview:placeholderImageView];
//        [button sendSubviewToBack:placeholderImageView];
//        placeholderImageView.tag = 2;
//        //placeholderImageView.image = [UIImage imageNamed:@"tag_imageView_frame.png"];
//    }
//    placeholderImageView.hidden = NO;
//    UIImageView *playImageView;
//    playImageView = (UIImageView*)[button viewWithTag:23];
//    
//    if(!playImageView){
//        playImageView = [[UIImageView alloc]init];
//        playImageView.frame = CGRectMake(25, 25, button.frame.size.width/2, button.frame.size.height/2);
//    
//        [button addSubview:playImageView];
//      //  [button sendSubviewToBack:placeholderImageView];
//        playImageView.tag = 23;
//        playImageView.image = [UIImage imageNamed:@"feed_play_watermark.png"];
//        playImageView.hidden = YES;
//    }
//}


+ (UIView *)loadViewFromNib:(NSString *)nibName forClass:(id)forClass{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for(id currentObject in topLevelObjects)
        if([currentObject isKindOfClass:forClass])
    {
        //[currentObject retain];
        // [topLevelObjects release];
                  return currentObject ;
    }
    
return nil;


}



+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}





@end
