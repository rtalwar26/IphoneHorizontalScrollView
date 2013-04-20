//
//  TFAlert.h
//  HardRock
//
//  Created by Rajat Talwar on 08/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface TFAlert : NSObject {
	NSString *mString;
}
@property (nonatomic , retain)	UILabel *mLabel;
-(id)initForString:(NSString*)pString;
-(void)showInView:(UIView*)pView;
-(void)showInView:(UIView*)pView forPoint:(CGPoint)pPoint;

- (CAAnimation*)appearAnimation; 

@end
