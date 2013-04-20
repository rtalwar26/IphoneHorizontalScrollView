//
//  AppScrollView.m
//  iCard
//
//  Created by Rajat Talwar on 19/10/09.
//  Copyright 2009 Wirkle Technologies. All rights reserved.
//

#import "AppScrollView.h"


@implementation AppScrollView

- (id)initWithFrame:(CGRect)frame 
{
	return [super initWithFrame:frame];
}


- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
	// If not dragging, send event to next responder
	if (!self.dragging) 
		[self.nextResponder touchesEnded: touches withEvent:event]; 
	else
		[super touchesEnded: touches withEvent: event];
}




@end
