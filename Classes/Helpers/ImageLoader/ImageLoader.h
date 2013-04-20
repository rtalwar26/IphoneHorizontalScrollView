//
//  ImageLoader.h
//  OfficeDrop
//
//  Created by Rajat Talwar on 30/03/10.
//  Copyright 2010 Rajat Technologies. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol ImageLoaderDelegate;


@interface ImageLoader : UIImageView {

	NSString *mUrl;
	NSMutableData *mData;
	NSURLConnection *mConnection;
	BOOL mLoadable;
	NSInteger mIndex;
	
	id <ImageLoaderDelegate>mDelegate;
	
	
}
@property(assign) id <ImageLoaderDelegate> mDelegate;
@property(readwrite) NSInteger mIndex;
@property(nonatomic,retain) NSURLConnection *mConnection;
@property(nonatomic,retain) NSMutableData *mData;
@property(nonatomic,retain) NSString *mUrl;

-(id)initWithUrl:(NSString*)pUrl andFrame:(CGRect)pFrame;

-(void)loadWithUrl:(NSString*)pUrl;
-(void)startConnection;
@end

@protocol ImageLoaderDelegate

@optional
-(void)imageLoader:(ImageLoader*)imageloader imageLoadedForIndex:(NSInteger)pIndex;

@end