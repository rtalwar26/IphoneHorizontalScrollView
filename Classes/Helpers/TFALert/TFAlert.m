//
//  TFAlert.m
//  HardRock
//
//  Created by Rajat Talwar on 08/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TFAlert.h"


@implementation TFAlert
@synthesize mLabel;
-(id)initForString:(NSString*)pString
{

	if (self = [super init]) {
		
		CGSize stringSize = [pString sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(200,300) lineBreakMode:UILineBreakModeWordWrap];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, stringSize.width+30, stringSize.height+20)];
		label.textAlignment = UITextAlignmentCenter;
		
		UIColor *backgroundColor = [UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:0.7];
		label.numberOfLines = 5;
		label.backgroundColor = backgroundColor;
		label.textColor = [UIColor whiteColor];
		label.font = [UIFont boldSystemFontOfSize:12];
		label.text=pString;
		[[label layer] setCornerRadius:10];
		[[label layer] setBorderColor:[[UIColor whiteColor] CGColor]];
		
		
		UIColor *borderColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:0.7];
		
		[[label layer] setBorderColor:[borderColor CGColor]];
		
		
		[[label layer] setBorderWidth:2];
		//[[label layer] setShadowOpacity:1];
		[[label layer] setOpacity:0];
		self.mLabel = label;
		[label release];
		label = nil;
		
		
	}
	
	return self;
}

-(void)showInView:(UIView*)pView
{
	//[self retain];
	mLabel.center = CGPointMake(pView.center.x, pView.center.y-30);

	[pView addSubview:mLabel];//
	

	[[mLabel layer] removeAllAnimations];
	[[mLabel layer] addAnimation:[self appearAnimation] forKey:@"opacity"];
}

-(void)showInView:(UIView*)pView forPoint:(CGPoint)pPoint
{
	//[self retain];
	mLabel.center = CGPointMake(pPoint.x+(mLabel.frame.size.width/2), pPoint.y+(mLabel.frame.size.height/2));
	
	[pView addSubview:mLabel];//
	
	
	[[mLabel layer] removeAllAnimations];
	[[mLabel layer] addAnimation:[self appearAnimation] forKey:@"opacity"];
}

- (CAAnimation*)appearAnimation; {

	//	CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,250.0,120.0);
	//	CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,350.0,120.0); 
	//	CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,450.0,120.0);
	CAKeyframeAnimation * animation = [CAKeyframeAnimation
									   animationWithKeyPath:@"opacity"]; 
	
	NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:0],nil];
	
	[animation setValues:array];
	[animation setKeyTimes:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.2],[NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:1.0],nil]];
	
	[animation setDuration:2]; 
	[animation setDelegate:self];
	return animation;
}


-(void)dealloc
{
	if (mLabel.superview) {
		[mLabel removeFromSuperview];
		[[mLabel layer] removeAllAnimations];
	}
	
	
	
	[mLabel release];
	mLabel = nil;
	[super dealloc];
}
@end
