//
//  ImageLoader.m
//  OfficeDrop
//
//  Created by Rajat Talwar on 30/03/10.
//  Copyright 2010 Rajat Technologies. All rights reserved.
//

#import "ImageLoader.h"


@implementation ImageLoader
@synthesize mUrl,mData,mConnection,mIndex,mDelegate;

-(id)init
{
if(self=[super init])
{
	

	
	//mUrl=[[NSString alloc] initWithString:pUrl];
	
	self.backgroundColor=[UIColor whiteColor];
	
	//[self loadWithUrl:mUrl];

}
	return self;
}

- (id)initWithFrame:(CGRect)frame          // default initializer
{

	if (self=[super initWithFrame:frame]) {

		self.backgroundColor=[UIColor whiteColor];

	}
	return self;
}
-(id)initWithUrl:(NSString*)pUrl andFrame:(CGRect)pFrame
{

	if (self=[super initWithFrame:pFrame]) {
		//mUrl=[[NSString alloc] initWithString:];
		[self loadWithUrl:(pUrl?pUrl:@"http://")];
		
	}
	return self;
}
-(void)setFrame:(CGRect)pFrame
{

	[super setFrame:pFrame];


}
-(void)loadWithUrl:(NSString*)pUrl 
{
	self.mUrl=pUrl;
	[self startConnection];
}
-(void)loadWithUrl:(NSString*)pUrl forId:(NSString*)pId 
{
	
	self.mUrl=pUrl;
	[self startConnection];
}
-(void)startConnection
{
		
	NSMutableData *tempData=[[NSMutableData alloc] init];
	self.mData=tempData;
	[tempData release];
	
//	DLog(@"activity indicator is %@ and its superview:%@",mActivityIndicator,[mActivityIndicator superview]);
	
	
	
	[mConnection cancel];
	NSMutableURLRequest *tempUrlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:mUrl]];
	//NSMutableURLRequest *tempUrlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.officedropqa.com/ze/api/documents/2307/cover"]];
	

	
	NSURLConnection *temp=[[NSURLConnection alloc] initWithRequest:tempUrlRequest delegate:self];
	self.mConnection=temp;
	[temp release];
	
	
}

#pragma mark -
#pragma mark Connection Delegate Functions



//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
//{
//	//NSHTTPURLResponse *temp = (NSHTTPURLResponse*)redirectResponse;
//	
//	NSMutableURLRequest* modifiedRequest;
//	if(redirectResponse!=nil)
//	{
//		//DLog(@"the content-type is %@",[temp allHeaderFields]);
//		
//		//DLog(@"New URL is : %@",[request URL]);
//		
//		modifiedRequest=[[NSMutableURLRequest alloc] initWithURL:[request URL]];
//		
//		return [modifiedRequest autorelease];
//
//	}
//
//	
//	
//	return request;
//}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)tempData 
{ 
	[mData appendData:tempData];
} 


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{	
	
	DLog(@"mindex is %d",mIndex);
	[mData release];
	mData = nil;
	self.image = [[AppHelper mDataManager] objectForKey:_KEY(KEY_IMAGE_NO_IMAGE)];

	if ([(id)mDelegate respondsToSelector:@selector(imageLoader:imageLoadedForIndex:)]) {
	
		[self.mDelegate imageLoader:self imageLoadedForIndex:mIndex];
	}
	
}



/*
 * This method invokes by the class when network finished with the loading of the request.
 */
- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{ 	
	
	DLog(@"mindex is %d",mIndex);

		DLog(@"imageLoadedForIndex for path :%@",mUrl);
	UIImage *tempImage=[[UIImage alloc] initWithData:mData];
	DLog(@"image size is width: %f height:%f",self.image.size.width,self.image.size.height);

	if (tempImage.size.width>2) {
		self.image=tempImage;
	}
	else {
		self.image = [[AppHelper mDataManager] objectForKey:_KEY(KEY_IMAGE_NO_IMAGE)];
	}



	DLog(@"image size is width: %f height:%f",tempImage.size.width,tempImage.size.height);
	[tempImage release];
	
	//DLog(@"image: %@ and Data:%@",self.image,mData);
	[mData release];
	mData = nil;
	DLog(@"imageloader delegate method");

	if ([(id)mDelegate respondsToSelector:@selector(imageLoader:imageLoadedForIndex:)]) {
		
	[self.mDelegate imageLoader:self imageLoadedForIndex:mIndex];
	}
	
	

	
}


-(void)dealloc
{
	[self.mConnection cancel];
	self.mDelegate=nil;
	[mConnection release];
	mConnection = nil;
	[mData release];
	mData = nil;
	[mUrl release];
	mUrl = nil;
	
	[super dealloc];
}
@end
