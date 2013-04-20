//
//  TFScroller.m
//  HardRock
//
//  Created by Rajat Talwar on 03/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TFScroller.h"

@implementation TFScroller
@synthesize mImageViewsArray,mScrollView,mImageArray,mDelegate,mResumeTimer,scrollingEnabled,mTimer;


-(id)initWithFrame:(CGRect)pFrame 
{
	
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
		//		mImageArray =  [pImageArray retain];
		mFrame = pFrame;
		//[self scrollViewInitialisation];
	}
	
	return self;
}

-(void)goToNextPage
{
	mManual = TRUE;
	CGPoint currentOffset = mScrollView.contentOffset;
	[mScrollView setContentOffset:CGPointMake(currentOffset.x + (mGap+mWidthPage), 0) animated:YES];
	
//	NSInteger normalIndex= mActualPages*((mTotalPages/2)/mActualPages) + (mSelectedIndex%mActualPages)+1;
//	[mScrollView setContentOffset:CGPointMake(mLag +normalIndex*(mWidthPage+mGap), 0) animated:NO];
}
-(void)goToPreviousPage
{
	CGPoint currentOffset = mScrollView.contentOffset;
	
	mManual =TRUE;
	
	[mScrollView setContentOffset:CGPointMake(currentOffset.x - (mGap+mWidthPage), 0) animated:YES];

//	NSInteger normalIndex= mActualPages*((mTotalPages/2)/mActualPages) + (mSelectedIndex%mActualPages) -1;
//	[mScrollView setContentOffset:CGPointMake(mLag +normalIndex*(mWidthPage+mGap), 0) animated:NO];
}
-(CABasicAnimation*)getAnimationforPoint:(CGPoint)pPoint
{
	CGPoint startPoint = pPoint;
	CGPoint endPoint = pPoint;
	endPoint.x-=TRAVERSE_AMOUNT;
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:ANIMATION_PROPERTY];
	[animation setFromValue:[NSValue valueWithCGPoint:startPoint]];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	[animation setToValue:[NSValue valueWithCGPoint:endPoint]];
	[animation setDuration:ANIMATION_DURATION];
	animation.delegate =self;
	animation.removedOnCompletion = NO;
	return animation;
}


-(MagazineTeaserView*)getViewLinkedToAnimation:(CAAnimation*)anim
{
	MagazineTeaserView *imageView= nil;
	
	for (int i = 0; i < [mImageViewsArray count]; i++) {
		imageView = [mImageViewsArray objectAtIndex:i];
		if (anim==[[imageView layer] animationForKey:ANIMATION_PROPERTY]) {
			break;
		}	
		
	}
	
	return imageView;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	
	
	if (!flag) {
		return;
	}
	
	MagazineTeaserView *imageView = [self getViewLinkedToAnimation:anim];
	
	//DLog(@"origin is %f and width is %f",imageView.frame.origin.x,imageView.frame.size.width);
	
	CGFloat leftOffset = imageView.frame.origin.x + imageView.frame.size.width ;
	if (leftOffset < 0) { // if the button has crossed the left margin.
		
		CGRect newFrame = imageView.frame;
		
		//		newFrame.origin.x = ([mImageArray count] -3) * (WIDTH_SCROLLER_THUMBNAIL + TFSCROLLER_SPACING_WIDTH);
		
		[[imageView layer] removeAllAnimations];
		
		//DLog(@"offset is %f and origin of last button is %f",leftOffset,mLastButton.frame.origin.x);
		newFrame.origin.x = mLastButton.frame.origin.x + (WIDTH_SCROLLER_THUMBNAIL + TFSCROLLER_SPACING_WIDTH) + ((imageView==mFirstButton)?TRAVERSE_AMOUNT:0) ;
		imageView.frame = newFrame;
		mLastButton = imageView;
		//		CGPoint newPoint =  imageView.center;
		//newPoint.x = (mScrollView.frame.size.width/2)*([mImageViewsArray count]) - TRAVERSE_AMOUNT ;
		//		[[imageView layer] removeAnimationForKey:ANIMATION_PROPERTY];
		//		
		//		
		//		[[imageView layer] addAnimation:[self getAnimationforPoint:imageView.center] forKey:ANIMATION_PROPERTY];
		//		[[imageView layer] setPosition:newPoint] ;
		
		[[imageView layer] addAnimation:[self getAnimationforPoint:[imageView center]] forKey:ANIMATION_PROPERTY];
		CGPoint newPoint =  imageView.center;
		newPoint.x-=TRAVERSE_AMOUNT;
		[[imageView layer] setPosition:newPoint];
		
		
	}
	else {						// animating the buttons which are still in the view.
		[[imageView layer] removeAnimationForKey:ANIMATION_PROPERTY];
		
		[[imageView layer] addAnimation:[self getAnimationforPoint:imageView.center] forKey:ANIMATION_PROPERTY];
		
		CGPoint newPoint =  imageView.center;
		newPoint.x-=TRAVERSE_AMOUNT;
		[[imageView layer] setPosition:newPoint];
	}
	
	
	
}


-(void)stopScrolling
{
	if (!isScrolling) {
		return;
	}
	isScrolling = FALSE;
	
	CGFloat lowestX = 0;
	for (int   i = 0; i<[mImageViewsArray count]; i++) {
		MagazineTeaserView *imgview = [mImageViewsArray objectAtIndex:i];
		[[imgview layer] removeAllAnimations];
		
		if (imgview.frame.origin.x < lowestX) {
			lowestX = imgview.frame.origin.x;
		}
	}
	
	if (lowestX < 0) {
		
		
		for (UIView *obj in [mScrollView subviews]) {
			
			CGPoint buttonCenter = obj.center;
			buttonCenter.x += -lowestX;
			obj.center =buttonCenter;
		}
	}
	
}

-(void)animateAll
{
	
	DLog(@"animate all");
	for (NSUInteger   i = 0; i<[mImageViewsArray count]; i++)
	{
		MagazineTeaserView *imgview = [mImageViewsArray objectAtIndex:i];
		[[imgview layer] removeAllAnimations];
		[[imgview layer] addAnimation:[self getAnimationforPoint:[imgview center]] forKey:ANIMATION_PROPERTY];
		CGPoint newPoint =  imgview.center;
		newPoint.x-=TRAVERSE_AMOUNT;
		[[imgview layer] setPosition:newPoint];
		
		//	DLog(@"newpoint is %f %f and center is %f %f",newPoint.x,newPoint.y,imgview.center.x,imgview.center.y);
	}
}

-(void)startSrolling
{
	if (!scrollingEnabled) {
		return;
	}
	
	//[self stopScrolling];
	
	
	
	
	//	[self animateAll];
	//	self.mTimer = [NSTimer timerWithTimeInterval:ANIMATION_DURATION target:self selector:@selector(animateAll) userInfo:nil repeats:YES];
	//	
	//	[[NSRunLoop currentRunLoop] addTimer:mTimer forMode:NSDefaultRunLoopMode];
	
	//	NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:ANIMATION_DURATION target:self selector: @selector(animateAll) userInfo:nil repeats:YES];
	//	
	//	self.mTimer = timer;
	//	[timer release];
	
	isScrolling = TRUE;
	[self animateAll];
	//	for (int   i = 0; i<[mImageViewsArray count]; i++) {
	//		ThumbnailButton *imgview = [mImageViewsArray objectAtIndex:i];
	//		[[imgview layer] removeAllAnimations];
	//		[[imgview layer] addAnimation:[self getAnimationforPoint:[imgview center]] forKey:ANIMATION_PROPERTY];
	//		CGPoint newPoint =  imgview.center;
	//		newPoint.x-=TRAVERSE_AMOUNT;
	//		[[imgview layer] setPosition:newPoint];
	//	}
	
}



-(void)scrollViewInitialisation{
	DLog(@"the delegate is %@",self.mDelegate);
	mActualPages = [self.mDelegate numberOfPagesInScroller:self];
	
	mWidthPage = [self.mDelegate widthForPagesInScroller:self];
	mGap = [self.mDelegate gapForPagesInScroller:self ];
	self.scrollingEnabled = TRUE;
	mTotalPages = 50;
	if (mWidthPage<mFrame.size.width) {
		DLog(@"scrollwidth is %f and width is %f",mFrame.size.width,mWidthPage);
		CGFloat ratio =		(mFrame.size.width/mWidthPage);
		mTotalPages = (int)(50*ratio);
	}
	CGFloat step = 2*mGap + mWidthPage;
	
	mLag = step +mWidthPage/2 - mFrame.size.width/2;
	//	if(self.mScrollView!=nil)
	//	{
	//		if(self.mScrollView.superview)
	//		{
	//			[self.mScrollView removeFromSuperview];
	//		}
	//		
	//	}
	
	if (!mScrollView) {
		UIScrollView *temp=[[UIScrollView alloc] initWithFrame:mFrame];
		
		self.mScrollView=temp;
		
		[temp release];
	}
	
	[AppHelper removeAllSubViewsFrom:mScrollView];
	
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < mTotalPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }

	self.mImageViewsArray = [controllers autorelease];
	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:0]];
		[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:1]];
//	[self loadScrollViewWithPage:[NSNumber numberWithInt:0]];
//    [self loadScrollViewWithPage:[NSNumber numberWithInt:1]];
//	self.mImageViewsArray = [self buttonsArray];
	
	//	UIScrollView *temp=[[UIScrollView alloc] initWithFrame:mFrame];
	//	
	//	self.mScrollView=temp;
	//	[temp release];
	
	//mScrollView.pagingEnabled = YES;
	//int pageCount =  ceil([mImageArray count] / 2.0) ;
	
	CGFloat width = mTotalPages * (mGap + mWidthPage)  + mGap;
	//	mScrollView.contentSize = CGSizeMake((mScrollView.frame.size.width * pageCount), mScrollView.frame.size.height);
	mScrollView.contentSize = CGSizeMake(width, mScrollView.frame.size.height);
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    mScrollView.scrollsToTop = YES;
	mScrollView.delegate = self;
	mScrollView.userInteractionEnabled=YES;
	//mScrollView.pagingEnabled = YES;
	
	//[self addAllButtonsToScrollView];
	
}

-(void)setMImageArray:(NSMutableArray*)pImages
{
	[self stopScrolling];
	
	[pImages retain];
	[mImageArray release];
	mImageArray = pImages;
	
	[self scrollViewInitialisation];
	[self startSrolling];
	
}

- (void)loadScrollViewWithPage:(NSNumber*)num
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int page = [num intValue];
	if (page < 0) {
		return;
	}
	if (page>= mTotalPages) {
		return;
	}
	MagazineTeaserView *imageView = [mImageViewsArray objectAtIndex:page];
    if ((NSNull *)imageView == [NSNull null])
    {
		
		imageView = [[MagazineTeaserView alloc] initWithFrame:CGRectMake(0, 0, mWidthPage, self.mScrollView.frame.size.height) andImage:[self.mDelegate tfScroller:self viewForIndex:(page%mActualPages) ] width:mWidthPage height:mFrame.size.height];
		imageView.mDelegate = self;
		imageView.mIndex = (page%mActualPages);
		imageView.mButton.tag = page;
	
		@synchronized(self){
        [mImageViewsArray replaceObjectAtIndex:page withObject:imageView];
			[imageView release];
		}
    }
	
	
	if (nil == imageView.superview) {
		
		CGRect frame = mScrollView.frame;
		//			frame.origin.x = (frame.size.width/2) * i;
		frame.origin.x = mGap + ( mWidthPage +mGap ) * page;
		frame.origin.y = 0;
		
		frame.size = imageView.frame.size;
		
		imageView.frame = frame;
		[mScrollView performSelectorOnMainThread:@selector(addSubview:) withObject:imageView waitUntilDone:NO];
		//[mScrollView addSubview:imageView];
	}
	
	
	[pool release];
}

-(void)addAllButtonsToScrollView
{
	MagazineTeaserView *imageView = nil ;
	
	
	if ([mImageViewsArray count] > 0) {
		mFirstButton = [mImageViewsArray objectAtIndex:0];
		
	}
	
	for (int i = 0; i<[mImageViewsArray count];i++) {
		
		
		imageView = [mImageViewsArray objectAtIndex:i];
		
		if (nil == imageView.superview) {
			
			CGRect frame = mScrollView.frame;
			//			frame.origin.x = (frame.size.width/2) * i;
			frame.origin.x = mGap + ( mWidthPage +mGap ) * i;
			frame.origin.y = 0;
			
			frame.size = imageView.frame.size;
			
			imageView.frame = frame;
			[mScrollView addSubview:imageView];
		}
	}
	
	mLastButton = imageView;
	
	DLog(@"in initialization the origin of last button is %f",mLastButton.frame.origin.x);
	if ([mImageViewsArray count]==1) { // If only one image is to be displayed in scroller
		MagazineTeaserView *imageView = [mImageViewsArray objectAtIndex:0];
		imageView.center = CGPointMake(mScrollView.frame.size.width/2, mScrollView.frame.size.height/2); //center align the single image button
		mScrollView.contentSize = mScrollView.frame.size;                                               //set scrollview's content size to its frame
		//self.scrollingEnabled = FALSE;	//Disable scrolling
	}
}


-(NSMutableArray*)buttonsArray
{
	//	MagazineTeaserView *button;
	NSMutableArray *buttonArray = [NSMutableArray new];
	for (unsigned int i = 0; i < mTotalPages; i++) {
		
		MagazineTeaserView *tempImage = [[MagazineTeaserView alloc] initWithFrame:CGRectMake(0, 0, mWidthPage, self.mScrollView.frame.size.height) andImage:[self.mDelegate tfScroller:self viewForIndex:(i%mActualPages)]];
		
		//	MagazineTeaserView *tempImage=[mImageArray objectAtIndex:i];
//		[tempImage.mButton setBackgroundImage:[self.mDelegate tfScroller:self viewForIndex:i] forState:UIControlStateNormal];
//		[tempImage.mButton addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		tempImage.mButton.tag = i;
		//
		//		button = [[ThumbnailButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCROLLER_THUMBNAIL, HEIGHT_SCROLLER_THUMBNAIL)];
		//		button.mDelegate = self;
		//		button.tag=i;
		//		button.contentMode = UIViewContentModeScaleAspectFit;
		//		[button setBackgroundImage:tempImage forState:UIControlStateNormal];
		//		[button addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		//		[[button layer] setBorderWidth:2];
		//		[[button layer] setBorderColor:[[UIColor whiteColor] CGColor]];
		//		[buttonArray addObject:button];		
		//		
		//
		//		[button release];
		//		button = nil;
		//		
		
		[buttonArray addObject:tempImage];
		[tempImage release];
    }
	
	return  [buttonArray autorelease];
}


-(void)imageButtonClicked:(id)sender
{
	
	if ([(id)mDelegate respondsToSelector:@selector(tfscroller:didSelectImageAtIndex:)]) {
		
		UIButton *button = (UIButton*)sender;
		[self.mDelegate tfscroller:self didSelectImageAtIndex:button.tag];
	}
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//	NSLog(@"scrollViewWillBeginDragging");
//}
-(void)memoryWarning
{
	NSLog(@"memoryWarning");
	NSInteger normalIndex= mActualPages*((mTotalPages/2)/mActualPages) + (mSelectedIndex%mActualPages);

	for (int i =0 ; i< mTotalPages; i++) {
		
		if (i >(normalIndex -2) && i < (normalIndex+2) ) {
			
			continue;
		}
		
		MagazineTeaserView *imageView = [mImageViewsArray objectAtIndex:i];
		
		if ((NSNull *)imageView == [NSNull null]) {
			continue;
		}
		[imageView removeFromSuperview];
		[mImageViewsArray replaceObjectAtIndex:i withObject:[NSNull null]];
	}
}
-(void)magazineTeaser:(MagazineTeaserView*)magazineTeaser didSelectPageAtIndex:(NSInteger)pIndex
{
	
	[self.mDelegate tfscroller:self didSelectImageAtIndex:pIndex];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSLog(@"content offset is x:%f y:%f",mScrollView.contentOffset.x,mScrollView.contentOffset.y	);

	CGFloat pageWidth = scrollView.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - mWidthPage / 2) / mWidthPage) + 1;
	int page = ((int)scrollView.contentOffset.x - mLag)/((int)(mGap+mWidthPage) );

//    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
//	page = page-3;
	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:(page -2)]];

	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:(page -1)]];

	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:page ]];

	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:(page +1)]];

	[NSThread detachNewThreadSelector:@selector(loadScrollViewWithPage:) toTarget:self withObject:[NSNumber numberWithInt:(page + 2)]];

	//[self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(++page)]];
//	[self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(++page)]];
//
//	[self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(++page)]];
//
//	[self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(++page)]];
//
//	[self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(++page)]];


//	[self loadScrollViewWithPage:page - 2];
//    [self loadScrollViewWithPage:page - 1];
//    [self loadScrollViewWithPage:page];
//    [self loadScrollViewWithPage:page + 1];
//    [self loadScrollViewWithPage:page + 2];	
	//[self stopScrolling];
	
	
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	
	NSLog(@"scrollViewDidEndScrollingAnimation");
//	if (!mAnimation) {
//		return;
//	}
//	CGFloat min=mLag;
//	int selectedI=0;
//	for (int i =0; i<mTotalPages; i++) {
//		
//		CGFloat value = mLag +i*(mWidthPage+mGap);
//		
//		
//		int difference = abs((int)value - (int)scrollView.contentOffset.x);
//		NSLog(@"value is %f difference is %d",value,difference);
//		if ((int)min > difference) {
//			min	= (float)difference;
//			selectedI=i;
//			
//		}
//		
//		
//	}
	if (mManual) {
		mManual = FALSE;
		
		int page = ((int)mScrollView.contentOffset.x - mLag)/((int)(mGap+mWidthPage) );

		NSInteger normalIndex= mActualPages*((mTotalPages/2)/mActualPages) + (page%mActualPages);
		DLog(@"the index to scroll to is %d",normalIndex);
		//	[scrollView scrollRectToVisible:CGRectMake(mLag + (selectedI-5)*(mWidthPage+mGap), 0, mWidthPage, self.mScrollView.frame.size.height) animated:YES];
		[scrollView setContentOffset:CGPointMake(mLag +normalIndex*(mWidthPage+mGap), 0) animated:NO];
		return;
	}
	
//	NSLog(@"finally min is %f index is %d",min,mSelectedIndex);
	NSInteger normalIndex= mActualPages*((mTotalPages/2)/mActualPages) + (mSelectedIndex%mActualPages);
	DLog(@"the index to scroll to is %d",normalIndex);
//	[scrollView scrollRectToVisible:CGRectMake(mLag + (selectedI-5)*(mWidthPage+mGap), 0, mWidthPage, self.mScrollView.frame.size.height) animated:YES];
	[scrollView setContentOffset:CGPointMake(mLag +normalIndex*(mWidthPage+mGap), 0) animated:NO];
	

//	mAnimation = FALSE;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
		NSLog(@"content offset is x:%f y:%f",mScrollView.contentOffset.x,mScrollView.contentOffset.y	);


	//[self scheduleScrollingAfter:SCROLLER_RESUME_TIME];
	
	[self scrollToCorrect:scrollView];
}

-(void)scrollToCorrect:(UIScrollView*)scrollView
{
	CGFloat min=mLag;
	int selectedI=0;
//	for (int i =0; i<mTotalPages; i++) {
//		
//		CGFloat value = mLag +i*(mWidthPage+mGap);
//		
//		
//		int difference = abs((int)value - (int)scrollView.contentOffset.x);
//		NSLog(@"value is %f difference is %d",value,difference);
//		if ((int)min > difference) {
//			min	= (float)difference;
//			selectedI=i;
//			
//		}
//		
//		
//	}
	
	selectedI = (int)round( ((int)scrollView.contentOffset.x - mLag)/(mGap+mWidthPage)  ) ;

	
	mSelectedIndex = selectedI;
	
	NSLog(@"finally min is %f index is %d",min,selectedI);
	mAnimation = TRUE;
//	[scrollView scrollRectToVisible:CGRectMake(mLag + selectedI*(mWidthPage+mGap), 0, mWidthPage, self.mScrollView.frame.size.height) animated:YES];
	[scrollView setContentOffset:CGPointMake(mLag + selectedI*(mWidthPage+mGap), 0) animated:YES];
}

-(void)scheduleScrollingAfter:(NSTimeInterval)pSeconds
{
	
	if (mResumeTimer) {
		[mResumeTimer invalidate];
		[mResumeTimer release];
		mResumeTimer=nil;
		
	}
	
	//Timer to resume autoscrolling after pseconds of user interaction with the scroller
	
	self.mResumeTimer = [NSTimer scheduledTimerWithTimeInterval:pSeconds target:self selector:@selector(startSrolling) userInfo:nil repeats:NO];
	
	
	//[self performSelector:@selector(startSrolling) withObject:nil afterDelay:pSeconds];
	
}

#pragma mark -
#pragma mark THUMBNAILBUTTON DELEGATE

-(void)thumbnailButton:(MagazineTeaserView*)thumbnailButton imageLoadedForIndex:(NSInteger)pIndex
{
	//	UIImage *image = [thumbnailButton backgroundImageForState:UIControlStateNormal];
	//	
	//	[mImageArray replaceObjectAtIndex:thumbnailButton.tag withObject:image];
}

#pragma mark -
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[mTimer invalidate];
	[mTimer release];
	mTimer=nil;
	
	if (mScrollView.superview) {
		[mScrollView removeFromSuperview];
	}
	DLog(@"mScrollView retain count is %d",[mScrollView retainCount]);
	
	[mScrollView release];
	mScrollView = nil;
	DLog(@"button retain count is %d",[[mImageViewsArray objectAtIndex:0] retainCount]);	
	[mImageViewsArray release];
	mImageViewsArray = nil;
	
	
	[mImageArray release];
	mImageArray = nil;
	self.mDelegate = nil;
	[mResumeTimer invalidate];
	[mResumeTimer release];
	mResumeTimer = nil;
	[super dealloc];
}


@end
