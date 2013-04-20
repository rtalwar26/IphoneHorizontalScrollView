//
//  RootViewController.m
//  HorizontalScrollView
//
//  Created by rajat talwar on 11/04/11.
//  Copyright 2011 rajat. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize mScroller;
-(IBAction)nextPage
{
	[self.mScroller goToNextPage];
}
-(IBAction)prevPage
{
	[self.mScroller goToPreviousPage];
}
#pragma mark -
#pragma mark View lifecycle
-(TFScroller*)mScroller
{
	if (!mScroller) {
		
		//		self.mArrayPromotions = [self getPromotionsButtonPressed];
		//		
		//		if (!mArrayPromotions || ([mArrayPromotions count] == 0)) {
		//			
		//			return nil;
		//		}
		//		
		
		//NSMutableArray *imageArray = [[NSMutableArray alloc] init];
		
		//		for (unsigned int i = 0; i < 1; i++) {
		//			
		//			NSString *path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%d",(i+1)] ofType:@"jpg"];
		//			
		//			UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:path];
		//			UIImage *emptyImage = [[UIImage alloc] init];
		//	//		[imageArray addObject:[[AppHelper mDataManager] objectForKey:_KEY(KEY_IMAGE_NO_IMAGE)]];
		//			[imageArray addObject:emptyImage];
		//			[emptyImage release];
		//			[tempImage release];
		//			tempImage = nil;
		//		}
		mScroller = [[TFScroller alloc] initWithFrame:CGRectMake(0, 175, self.view.frame.size.width, 200) ];
		mScroller.mDelegate = self;
		[mScroller scrollViewInitialisation];
		
		
		//	[self refreshScrollerWithNewImages];
		//[mScroller scrollViewInitialisation];
	}
	
	return mScroller;
}

#pragma mark -
#pragma mark TFSCROLLER DELEGATE FUNCTIONS
-(void)tfscroller:(TFScroller*)tfscroller didSelectImageAtIndex:(NSInteger)pIndex
{
	[AppHelper showAlert:[NSString stringWithFormat:@"clicked image at index %d",pIndex]];

}
-(UIImage*)tfScroller:(TFScroller*)tfscroller viewForIndex:(NSInteger)pInteger
{
	pInteger = pInteger%5;
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Pic%d.png",(pInteger+1)]];
	return image;
	
}
-(NSUInteger)numberOfPagesInScroller:(TFScroller*)tfscroller 
{
	return 5;
}
-(CGFloat)widthForPagesInScroller:(TFScroller*)tfscroller 
{
	return 200;
}
-(CGFloat)gapForPagesInScroller:(TFScroller*)tfscroller 
{
	return 50;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	UIButton *button = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	button.frame = CGRectMake(210, 10, 75, 30);
	[button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Next" forState:UIControlStateNormal];
	[self.view addSubview:button];
	[button release];
	
	button = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	button.frame = CGRectMake(10, 10, 75, 30);

	[button addTarget:self action:@selector(prevPage) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Prev" forState:UIControlStateNormal];
	[self.view addSubview:button];
	[button release];
	if ([mScroller.mScrollView superview]) {
		[mScroller.mScrollView removeFromSuperview];
	}
	[self.view addSubview:self.mScroller.mScrollView];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


//#pragma mark -
//#pragma mark Table view data source
//
//// Customize the number of sections in the table view.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//
//// Customize the number of rows in the table view.
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}
//
//
//// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//	// Configure the cell.
//
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[mScroller release];
	mScroller = nil;
    [super dealloc];
}


@end

