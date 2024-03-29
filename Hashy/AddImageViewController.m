//
//  AddImageViewController.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "AddImageViewController.h"

@interface AddImageViewController ()

@end

@implementation AddImageViewController
@synthesize avatarImageButton;
@synthesize avatarImageView;
@synthesize doneButton;
@synthesize tapChangeLabel;
@synthesize addYourImagelabel;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)setFontsAndFrames{
    
    [self.doneButton setTitleColor:[Utility colorWithHexString:@"157dfb"] forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:kHelVeticaNeueLight size:17]];
    
    
    self.addYourImagelabel.textColor=[Utility colorWithHexString:@"000000"];
    self.addYourImagelabel.font=[UIFont fontWithName:kHelVeticaNeueUltralight size:31.5];
   
    
    self.tapChangeLabel.textColor=[Utility colorWithHexString:@"000000"];
    self.tapChangeLabel.font=[UIFont fontWithName:kHelVeticaNeueLight size:14];

    
    
    
    if (!IS_IPHONE_5) {
        
        CGRect addImageFrame=self.addYourImagelabel.frame;
        addImageFrame.origin.y-=23;
        self.addYourImagelabel.frame=addImageFrame;
        
        
        CGRect tapChangeFrame=self.tapChangeLabel.frame;
        tapChangeFrame.origin.y-=30;
        self.tapChangeLabel.frame=tapChangeFrame;
        
        CGRect avatarImageFrame=self.avatarImageView.frame;
        avatarImageFrame.origin.y-=48;
        self.avatarImageView.frame=avatarImageFrame;
        
        CGRect avatarButtonFrame=self.avatarImageButton.frame;
        avatarButtonFrame.origin.y-=48;
        self.avatarImageButton.frame=avatarButtonFrame;
        
        
        
//        CGRect passwordFrame=self.passwordTextField.frame;
//        passwordFrame.origin.y-=41;
//        self.passwordTextField.frame=passwordFrame;
//        
//        
//        CGRect signUpFrame=self.signUpButton.frame;
//        ///        signUpFrame.origin.y-=41;
//        signUpFrame.origin.y-=55;
//        
//        self.signUpButton.frame=signUpFrame;
        
        
        
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    doneButton.enabled=NO;
    NSLog(@"%@",[kUserDefaults valueForKey:@"user_dict"]);
    
    
    

    [self setFontsAndFrames];
    
    [self getRandomImage];
    
	// Do any additional setup after loading the view.
}


#pragma mark Other methods


-(void)getRandomImage{
    
    [[NetworkEngine sharedNetworkEngine]getRandomAvatar:^(id object) {
        
        doneButton.enabled=YES;
        
        NSLog(@"%@",object);
        
        
        if ([object valueForKey:@"avatar_url"] && ![[object valueForKey:@"avatar_url"]isEqual:[NSNull null]]) {
            
            randomAvatarImageURL=[object valueForKey:@"avatar_url"];
            
            //  UIImageView *imageView;
            [avatarImageView setImageWithURL:[NSURL URLWithString:[object valueForKey:@"avatar_url"]] placeholderImage:nil];
            
            
        }
        
        
        
    } onError:^(NSError *error) {
        doneButton.enabled=YES;

    }];
    
    
}




-(void)postRandomAvatarImage{
    
//    {
//        "user": {
//            "avatar_url": "amzon.com/picture.jpg"
//        }
//    }
    
    
    
    NSMutableDictionary *imageDict=[[NSMutableDictionary alloc]init];
    
    if (randomAvatarImageURL) {
        [imageDict setValue:randomAvatarImageURL forKey:@"avatar_url"];

    }
   // [imageDict setValue: forKey:@"authentication_token"];
    
    
    
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc]init];
    [userDict setValue:imageDict forKey:@"user"];
    
    [[NetworkEngine sharedNetworkEngine]putRequestForNewUser:^(id object) {
        
        
        NSLog(@"%@",object);
        
        
        if (object && ![object isEqual:[NSNull null]]) {
            
            
            
            if ([object valueForKey:@"avatar_url"] && ![[object valueForKey:@"avatar_url"]isEqual:[NSNull null]] ) {
                [[UpdateDataProcessor sharedProcessor]currentUserInfo].user_profile_image_url=[object valueForKey:@"avatar_url"];
                [[kAppDelegate managedObjectContext]save:nil];

            }
            
        }
        
        
        
        
        
        HYListChatViewController *listChatVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"listChat_vc"];
        [self.navigationController pushViewController:listChatVC animated:YES];
        
        
        
    } onError:^(NSError *error) {
        
    } withParams:userDict];
    
    
    
}

-(void)postMultipartImage{
    
    
}





#pragma mark Button Methods


-(IBAction)doneButtonPressed:(UIButton *)sender{
    
    
    if (!isImageSelectedFromDevice) {
        [self postRandomAvatarImage];
        
    }
    else{
        [self postMultipartImage];
        
    }
    
    
//        HYSubscribersListViewController *subscribersVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"subscribers_vc"];
//        [self.navigationController pushViewController:subscribersVC animated:YES];
    
//    
//    if (isImageSelectedFromDevice) {
//        
//        [self postMultipartImage];
//        
//        
//    }
//    else{
//        
//        [self postRandomAvatarImage];
// 
//    }
    
    
//    HYProfileViewController *profileVC=[kStoryBoard instantiateViewControllerWithIdentifier:@"profile_vc"];
//    [self.navigationController pushViewController:profileVC animated:YES];
    
}


-(IBAction)changeImageButtonPressed:(UIButton *)sender{
    
    
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Existing",nil];
    
    [popup showInView:self.view];
    
    
    
    
}

#pragma mark UIactionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openPhotoLibrary];
            break;
            
            break;
        default:
            break;
    }
}


- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
    avatarImageView.image = image;
    [self hideImagePicker];
}

- (void)hideImagePicker{
    
        [imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
        
    

}


#pragma mark UIImagePicker Contrller Methods

-(void) openCamera{
    
    
    if (!imagePicker) {
        imagePicker = [[GKImagePicker alloc] init];

    }
    imagePicker.imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
    imagePicker.resizeableCropArea = YES;

    imagePicker.cropSize = CGSizeMake(300 ,300);

    imagePicker.delegate = self;
    [self presentViewController:imagePicker.imagePickerController animated:YES completion:nil];

    
//    UIImagePickerController *pickerController;//=[[UIImagePickerController alloc]init];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        if (pickerController==nil) {
//            pickerController = [[UIImagePickerController alloc] init];
//            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//            pickerController.delegate = self;
//            pickerController.showsCameraControls = YES;
//            pickerController.allowsEditing = YES;
//            
//        }// create once!
//        
//        [self presentViewController:pickerController animated:YES completion:nil];
//    }
    
    
    
}


-(void)openPhotoLibrary{
    
    
    
    if (!imagePicker) {
        imagePicker = [[GKImagePicker alloc] init];
        
    }
    imagePicker.imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.resizeableCropArea = YES;
    
    imagePicker.cropSize = CGSizeMake(300 ,300);
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker.imagePickerController animated:YES completion:nil];
    
    
//    UIImagePickerController *pickerController;//=[[UIImagePickerController alloc]init];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        if (pickerController==nil) {
//            pickerController = [[UIImagePickerController alloc] init];
//            pickerController.delegate = self;
////            pickerController.showsCameraControls = NO;
////            pickerController.allowsEditing = YES;
//        }// create once!
//        
//        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:pickerController animated:YES completion:nil];
//    }
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img)
    img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    if (img) {
        [avatarImageView setImage:img];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
