//
//  RootViewController.h
//  HorizontalScrollView
//
//  Created by rajat talwar on 11/04/11.
//  Copyright 2011 rajat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFScroller.h"
@interface RootViewController : UIViewController <TFScrollerDelegate>{
	TFScroller *mScroller;
}
@property(nonatomic,retain)	TFScroller *mScroller;
-(IBAction)nextPage;
-(IBAction)prevPage;
@end
