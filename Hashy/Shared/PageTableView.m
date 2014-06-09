//
//  PageTableView.m
//  Hashy
//
//  Created by Kurt on 5/28/14.
//

#import "PageTableView.h"

@implementation PageTableView
@synthesize pagingDelegate;
@synthesize selectedPageNumber;
@synthesize pageLocked;
@synthesize pageLimit;
@synthesize pageSize;
@synthesize total_pages;
@synthesize activityIndicator;
@synthesize remaining_records;
@synthesize numberOfSections;
@synthesize isScrolling;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setupTablePaging {
    
    self.selectedPageNumber = 1;
    isScrolling=NO;
    
    //self.pagingDelegate=self;
    self.delegate = self;
    //self.pageSize = 20;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // if([self.pagingDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])

   return [self.pagingDelegate tableView:self heightForRowAtIndexPath:indexPath];

    
}

//-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//   
//    activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicator.frame=CGRectMake(130,8,30,20);
//    [self.tableFooterView addSubview:activityIndicator];
//    return [self.pagingDelegate tableView:self viewForFooterInSection:section];
//}



-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self.pagingDelegate tableView:self viewForHeaderInSection:section];
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.pagingDelegate tableView:self heightForHeaderInSection:section];
    
    
}
//
//-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return [self.pagingDelegate tableView:self heightForFooterInSection:section];
//    
//}
//
//-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    return [self.pagingDelegate tableView:self viewForFooterInSection:section];
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
if([self.pagingDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    [self.pagingDelegate tableView:self didSelectRowAtIndexPath:indexPath];
   
    
}





#pragma matk Scrolling Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    isScrolling=NO;
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ 

    if([self.pagingDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    [self.pagingDelegate scrollViewDidEndDragging:self willDecelerate:decelerate];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScrolling=YES;

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
    
    //NSIndexPath *indexPath=[self indexPathForSelectedRow];
    if(self.pagingDelegate && [self.pagingDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
    [self.pagingDelegate scrollViewDidScroll:self];

    NSArray *paths = [self indexPathsForVisibleRows];
    for (NSIndexPath *path in paths) {
        //NSLog(@"%d",path.row);
        //if(path.row==[self.dataSource tableView:self numberOfRowsInSection:indexPath.section] &&!pageLocked){

        //NSLog(@"%d",path.row);
        
//        NSLog(@"%d",path.row);
//        NSLog(@"%@",self);
//        NSLog(@"%@",self.dataSource);
//        NSLog(@"%d",[self.dataSource tableView:self numberOfRowsInSection:0]);
        
        
        if(path.row== [self.dataSource tableView:self numberOfRowsInSection:0]-1 &&!pageLocked){
          //  NSLog(@"REACHED END");
            //if(self.selectedPageNumber<self.total_pages) {
            if(self.remaining_records>0) {

            pageLocked = YES;
            self.selectedPageNumber +=1;
        
            if([self.pagingDelegate respondsToSelector:@selector(tableView:didReachEndOfPage:)])
                
                [self.pagingDelegate tableView:self didReachEndOfPage:self.selectedPageNumber];
            }
            break;
        }
    }
}
@end
