//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "DEMOSecondViewController.h"
#import "CustomNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "HYListChatViewController.h"
#import "HYProfileViewController.h"
@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
      imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = nil;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
       label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = [[UpdateDataProcessor sharedProcessor]currentUserInfo].userName;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });

     [self performSelectorInBackground:@selector(loadImageInBackground) withObject:nil];
    }
- (void) loadImageInBackground
{
   
    
    // N.B. an instance of my 'Menu' class has been created, called 'menuItem'
    
    NSURL *imgURL = [NSURL URLWithString:[[UpdateDataProcessor sharedProcessor]currentUserInfo].user_profile_image_url];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *img = [[UIImage alloc] initWithData:imgData];
    [self performSelectorOnMainThread:@selector(assignImageToImageView:) withObject:img waitUntilDone:YES];
  
}

- (void) assignImageToImageView:(UIImage *)img
{
    
    imageView.image=img;
}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    headerLabel.text = @"Friends Online";
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    [headerLabel sizeToFit];
    [view addSubview:headerLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.section == 0 && indexPath.row == 0)    || indexPath.row==1) {
        HYListChatViewController *homeViewController = [[HYListChatViewController alloc] init];
        CustomNavigationController *navigationController = [[CustomNavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    } else if ((indexPath.section == 0 && indexPath.row == 2)) {
        HYProfileViewController *secondViewController = [[HYProfileViewController alloc] init];
        CustomNavigationController *navigationController = [[CustomNavigationController alloc] initWithRootViewController:secondViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    else if ((indexPath.section == 0 && indexPath.row == 3)) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Message" message:@"logout clicked" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Chats", @"Subscriptions", @"Profile",@"logout"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"John Appleseed", @"John Doe", @"Test User"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

@end
