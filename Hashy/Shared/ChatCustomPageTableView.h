//
//  ChatCustomPageTableView.h
//  Hashy
//
//  Created by Kurt on 6/13/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChatPagingDelegate<UITableViewDelegate>

@optional
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page;
@end


@interface ChatCustomPageTableView : UITableView<UIScrollViewDelegate,UITableViewDelegate> {
    
    BOOL pageLocked;
}
@property(unsafe_unretained) id pagingDelegate;
@property(nonatomic,assign) int selectedPageNumber;
@property(nonatomic,assign) int total_pages;
@property(nonatomic,assign)int remaining_records;
@property(nonatomic,assign) int numberOfSections;

@property(nonatomic,assign)  BOOL pageLocked;
@property(nonatomic,assign)  int pageSize;
@property(nonatomic,assign)  int pageLimit;

@property(strong,nonatomic)     UIActivityIndicatorView *activityIndicator;
@property(nonatomic,assign)  BOOL isScrolling;
-(void)setupTablePaging;


@end
