//
//  TFScroller.h
//  HardRock
//
//  Created by Rajat Talwar on 03/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MagazineTeaserView.h"
#define TRAVERSE_AMOUNT 10
#define ANIMATION_PROPERTY @"position"
#define ANIMATION_DURATION 0.6
#define	WIDTH_SCROLLER_THUMBNAIL 150
#define HEIGHT_SCROLLER_THUMBNAIL 150
#define TFSCROLLER_SPACING_WIDTH 50
#define SCROLLER_RESUME_TIME 15
@protocol TFScrollerDelegate;

@interface TFScroller : NSObject<UIScrollViewDelegate,MagazineTeaserDelegate> {

	NSMutableArray *mImageArray;
	NSMutableArray *mImageViewsArray;
	UIScrollView *mScrollView;
	int currentPage;
	BOOL mPageControlUsed;
	CGRect mFrame;
	id<TFScrollerDelegate> mDelegate;
	NSTimer *mResumeTimer;
	BOOL isScrolling;
	BOOL scrollingEnabled;
	MagazineTeaserView *mLastButton;
		MagazineTeaserView *mFirstButton;

	NSTimer *mTimer;
	NSInteger mTotalPages;
	NSInteger mCurrentPage;
	
	CGFloat mWidthPage;
	
	CGFloat mGap;
	BOOL mWasScrolling;
	
	CGFloat mLag;
	BOOL mAnimation;
	NSInteger mActualPages;
	NSInteger mSelectedIndex;
	BOOL mManual;
}
@property ( assign )			 id<TFScrollerDelegate> mDelegate;
@property ( nonatomic , retain ) NSMutableArray *mImageArray;
@property ( nonatomic , retain ) UIScrollView *mScrollView;
@property ( nonatomic , retain ) NSMutableArray *mImageViewsArray;
@property (nonatomic,retain) 	NSTimer *mResumeTimer;
@property (nonatomic,readwrite) 	BOOL scrollingEnabled;
@property (nonatomic,retain) 	NSTimer *mTimer;
-(id)initWithFrame:(CGRect)pFrame ;
-(void)scrollViewInitialisation;


- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

-(void)startSrolling;
-(void)stopScrolling;

-(MagazineTeaserView*)getViewLinkedToAnimation:(CAAnimation*)anim;
-(void)addAllButtonsToScrollView;
-(NSMutableArray*)buttonsArray;

-(CABasicAnimation*)getAnimationforPoint:(CGPoint)pPoint;
-(void)imageButtonClicked:(id)sender;
-(void)scheduleScrollingAfter:(NSTimeInterval)pSeconds;
-(void)animateAll;
-(void)scrollToCorrect:(UIScrollView*)scrollView;
- (void)loadScrollViewWithPage:(NSNumber*)num;
-(void)memoryWarning;
-(void)goToNextPage;
-(void)goToPreviousPage;
@end


//TFScrollerDelegate definition
@protocol TFScrollerDelegate

@optional

-(void)tfscroller:(TFScroller*)tfscroller didSelectImageAtIndex:(NSInteger)pIndex;
-(UIImage*)tfScroller:(TFScroller*)tfscroller viewForIndex:(NSInteger)pInteger;
-(NSUInteger)numberOfPagesInScroller:(TFScroller*)tfscroller ;
-(CGFloat)widthForPagesInScroller:(TFScroller*)tfscroller ;
-(CGFloat)gapForPagesInScroller:(TFScroller*)tfscroller ;

@end