//
//  AppHelper.h
//  WiTap
//
//  Created by Rajat Talwar on 26/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HorizontalScrollViewAppDelegate.h"

@interface AppHelper : NSObject {

}

//+(void)popAllNavigationControllersExceptSelecteOne ;         // In case of memory warning this method will be called

+(HorizontalScrollViewAppDelegate*)appDelegate;

+(UITabBarController*)getTabBarController;


+(NSString *)applicationDocumentsDirectory ;

+(NSMutableDictionary*)mDataManager;

+(UITabBarController*)getTabBarController;

+(NSUserDefaults*)mPersistantDataManager;

+(void)showAlert:(NSString *)pMsg withTag:(NSInteger)pTag delegate:(id)pDelegate;
+(void)showAlert:(NSString *)pMsg withTag:(NSInteger)pTag;
+(void)showAlert:(NSString*)pMsg;
+(void)showBannerForMesg:(NSString*)pMsg inView:(UIView*)pView;
+(void)showBannerForMesg:(NSString*)pMsg inView:(UIView*)pView forPoint:(CGPoint)pPoint;
+(BOOL)validateText:(NSString*)pText forKey:(NSString*)pKey;
+(BOOL)isEmailValid:(NSString*)pEmail;
+(void)removeAllSubViewsFrom:(UIView*)pView;
+(BOOL)shouldUpdateForKey:(NSString*)pKey;
+(void)updateDoneForKey:(NSString*)pKey;
+(void)needsUpdateForKey:(NSString*)pKey;
+(void)replaceAllObjectsOfArray:(NSMutableArray*)pArray withObject:(id)pObject;
+(UILabel*)labelForTitle:(NSString*)pString frame:(CGRect)pFrame;
+(void)sendMailTo:(NSString*)pTo subject:(NSString*)pSubject body:(NSString*)pBody;
+(NSString*)getFormatedNumberStringFrom:(NSInteger)pInt;

@end
