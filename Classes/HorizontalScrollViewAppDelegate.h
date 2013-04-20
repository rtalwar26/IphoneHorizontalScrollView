//
//  HorizontalScrollViewAppDelegate.h
//  HorizontalScrollView
//
//  Created by rajat talwar on 11/04/11.
//  Copyright 2011 rajat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalScrollViewAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableDictionary *mDataManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,retain) 	NSMutableDictionary *mDataManager;

@end

