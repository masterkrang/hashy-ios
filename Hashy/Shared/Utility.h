//
//  Utility.h
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

 @protocol TrendStartrUser<NSObject>

@end



@interface Utility : NSObject
{
   
}


+ (UIColor *) colorWithHexString: (NSString *) hexString;

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;
+(void)showAlertWithString:(NSString * )message ;
+(CGSize)heightOfTextString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;

//+(void)setGridImage:(UIImage*)image forButton:(UIButton *)button ;
//+(void)loadAudioForURL:(NSString*)sound_url inView:(UIView*)view ;
//+(NSString*)getFormattedNumberStringFor:(int)number ;
//+(NSDate *) getDateFromString:(NSString *) dateString;
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL;
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+(void)showAlertWithString:(NSString*)message;
//+(void)showAlertForError:(NSError*)error;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc;
//+(void) paddingTextField:(UITextField *) textField;
//+(UIImage* )resizedImage:(UIImage *)inImage rect:(CGRect) thumbRect;
//+ (NSMutableURLRequest*) makeMultipartDataForParams:(NSDictionary*)paramDict path:(NSString *)service httpMethod:(NSString *)method;
//+ (BOOL)savePic:(UIImage*)image ;
//+(UIImage*)loadImageWithName:(NSString*)file_name;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type overLay:(UIView*)overlayView;
//+(void)setGridImage:(NSString*)urlString forButton:(UIButton*)button changeURL:(BOOL)shouldChange;
//+(void) paddingTextFieldInSearchController:(UITextField *) textField;
//+(CGFloat) heightOfLabel :(NSString*)text andWidth:(CGFloat)width fontSize:(CGFloat)size;
//+ (UIView *)loadViewFromNib:(NSString *)nibName forClass:(id)forClass;
//
//+(NSMutableURLRequest *) makeRequestForservicePathArray:(NSString *)service httpMethod:(NSString *)method params:(NSArray*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+(NSMutableURLRequest *) makeRequestForservicePathString:(NSString *)service httpMethod:(NSString *)method params:(NSString *)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//
//+(NSMutableURLRequest *) makeRequestForservicePathForItunes:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
//+(NSString *) getMainCategoryNameFromCategoryID:(NSString *)categoryID;
//+(NSString *) getMainCategoryIDFromCategoryName:(NSString *)categoryName;


@end
