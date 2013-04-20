//
//  AppHelper.m
//  WiTap
//
//  Created by Rajat Talwar on 26/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppHelper.h"
#import "TFAlert.h"
#import "HorizontalScrollViewAppDelegate.h"
@implementation AppHelper

+(HorizontalScrollViewAppDelegate*)appDelegate
{
	return (HorizontalScrollViewAppDelegate*)[[UIApplication sharedApplication] delegate];
}

//+(void)popAllNavigationControllersExceptSelecteOne          // In case of memory warning this method will be called
//{
//	NSArray *navControllers = [[AppHelper getTabBarController] viewControllers];
//	
//	NSUInteger selectedIndex = [[AppHelper getTabBarController] selectedIndex];
//	
//	for (NSUInteger i = 0; i < [navControllers count]; i++) {
//		
//		if (i== selectedIndex) {
//			continue;
//		}
//		
//		UINavigationController *nav ;
//		@try {
//			nav  = (UINavigationController*)[navControllers objectAtIndex:i];
//		}
//		@catch (NSException * e) {
//			[AppHelper showAlert:[e description]];
//			continue;
//		}
//		@finally {
//			
//		}
//		
//		if ([nav respondsToSelector:@selector(popToRootViewControllerAnimated:)]) {
//			[nav popToRootViewControllerAnimated:NO];
//		}
//	}
//}
//+(UITabBarController*)getTabBarController
//{
//	MyGameKitAppDelegate *appDelegate =  (MyGameKitAppDelegate*)[[UIApplication sharedApplication] delegate];
//	
//	return [appDelegate mTabBarController];
//}

//+(UIViewController*) getRedeemController
//{
//	MyGameKitAppDelegate *appDelegate =  (MyGameKitAppDelegate*)[[UIApplication sharedApplication] delegate];
//	
//	return [appDelegate mTabBarController];
//}

+ (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSUserDefaults*)mPersistantDataManager
{
	return [NSUserDefaults standardUserDefaults];
}

+(UITabBarController*)getTabBarController
{
	HorizontalScrollViewAppDelegate *appDelegate =  (HorizontalScrollViewAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	return [appDelegate mTabBarController];
}

+(NSMutableDictionary*)mDataManager
{

	HorizontalScrollViewAppDelegate *obj =	(HorizontalScrollViewAppDelegate*)[[UIApplication sharedApplication] delegate];

	return [obj mDataManager];
}


+(void)showAlert:(NSString *)pMsg withTag:(NSInteger)pTag delegate:(id)pDelegate
{
	UIAlertView *temp=[[UIAlertView alloc] initWithTitle:APP_NAME message:pMsg delegate:pDelegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	temp.tag=pTag;
	[temp show];
	[temp release];
}


+(void)showAlert:(NSString *)pMsg withTag:(NSInteger)pTag
{
	[AppHelper showAlert:pMsg withTag:pTag delegate:nil];
}


+(void)showAlert:(NSString*)pMsg
{
	[AppHelper showAlert:pMsg withTag:0 delegate:nil];
	

}

+(void)showBannerForMesg:(NSString*)pMsg inView:(UIView*)pView 
{
	//[AppHelper showAlert:pMsg withTag:0 delegate:nil];
	
	TFAlert *alert = [[TFAlert alloc] initForString:pMsg];
	[alert showInView:pView];
	[alert autorelease];
}

+(void)showBannerForMesg:(NSString*)pMsg inView:(UIView*)pView forPoint:(CGPoint)pPoint
{
	//[AppHelper showAlert:pMsg withTag:0 delegate:nil];
	
	TFAlert *alert = [[TFAlert alloc] initForString:pMsg];
	[alert showInView:pView forPoint:pPoint];
	[alert autorelease];
}



//+(BOOL)validateText:(NSString*)pText forKey:(NSString*)pKey
//{
//
//	if ([pKey isEqualToString:STR_KEY_EMAIL]) {
//		
//		return [AppHelper isEmailValid:pText];
//				
//	}
//	
//	return TRUE;
//	
//}

+(BOOL)isEmailValid:(NSString*)pEmail
{
	int i;
	unichar c;
	BOOL atTheRateFound=FALSE;
	BOOL dotFoundOnce=FALSE;
	int dotFoundPos;
	for(i = 0;i < [pEmail length] ; i++)
	{
		
		c = [pEmail characterAtIndex:i];
		if((c >= 'A' && c <= 'z')||(c >= 'a' && c <= 'z')||(c == '-'||c=='_')||(c >= '0' &&c<='9')){
			
			continue;
		}
		if(c=='@')
		{
			if(atTheRateFound)
			{
				return FALSE;
			}
			if(i==0)
			{
				return FALSE;
			}
			atTheRateFound=TRUE;
			
			
		}
		else if(c=='.')
		{
			if(atTheRateFound)
			{
				if(dotFoundOnce)
				{
					if(i==(dotFoundPos+1))
						return FALSE;
					
					dotFoundPos=i;
				}
				dotFoundOnce=TRUE;
				//dotFoundPos=i;
			}
		}
		else if(c==' '){
			return FALSE;
		}
		else {
			return FALSE;
		}
		
		
	}
	if(dotFoundOnce==FALSE || atTheRateFound==FALSE)
	{
		return FALSE;
	}
	return TRUE;
	
}

+(void)removeAllSubViewsFrom:(UIView*)pView
{
	for (UIView *subView in [pView subviews]) {
		
		[subView removeFromSuperview];
	}
}

+(BOOL)shouldUpdateForKey:(NSString*)pKey
{

	return  (([[AppHelper mDataManager] valueForKey:pKey])?FALSE:TRUE);
}

+(void)updateDoneForKey:(NSString*)pKey
{

	[[AppHelper mDataManager] setValue:@"1" forKey:pKey];
	
	
}
+(void)needsUpdateForKey:(NSString*)pKey
{
	[[AppHelper mDataManager] setValue:nil forKey:pKey];

}

+(void)replaceAllObjectsOfArray:(NSMutableArray*)pArray withObject:(id)pObject
{
	NSUInteger i ;

	for ( i = 0; i < [pArray count]; i++) {
		
		[pArray replaceObjectAtIndex:i withObject:pObject];
		
	}

}

+(UILabel*)labelForTitle:(NSString*)pString frame:(CGRect)pFrame
{
	UILabel *titleView = [[UILabel alloc] initWithFrame:pFrame];
	titleView.backgroundColor = [UIColor clearColor];
	titleView.textColor = [UIColor blackColor];
	titleView.textAlignment = UITextAlignmentLeft;
	titleView.font = [UIFont boldSystemFontOfSize:16];
	titleView.text= pString;
	
	return [titleView autorelease];
}

+(void)sendMailTo:(NSString*)pTo subject:(NSString*)pSubject body:(NSString*)pBody
{
	
 NSString *emptyString = @"";
	
	if (![pTo length]) {
		pTo = emptyString;
	}
	
	if (![pSubject length]) {
		pSubject = emptyString;
	}
	
	if (![pBody length]) {
		pBody = emptyString;
	}
	
	NSString *mailString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",[pTo stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],[pSubject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]
							,[pBody stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mailString]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
	}
	else {
		[AppHelper showAlert:@"This device cannot send emails"];
	}
}
+(NSString*)getFormatedNumberStringFrom:(NSInteger)pInt
{
	NSNumberFormatter *formater = [NSNumberFormatter new];
	[formater setNumberStyle:NSNumberFormatterDecimalStyle];
	
	NSNumber *num = [[NSNumber alloc] initWithInt:pInt];
	NSString *formatedString = [[NSString alloc] initWithString:[formater stringFromNumber:num]] ;
	
	[num release];
	[formater release];
	
	return [formatedString autorelease];
}
-(void)dealloc
{
	[super dealloc];
}
@end
