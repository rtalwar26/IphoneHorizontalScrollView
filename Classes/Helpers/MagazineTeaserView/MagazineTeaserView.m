//
//  MagazineTeaserView.m
//  CampaignIpad
//
//  Created by rajat talwar on 26/02/11.
//  Copyright 2011 Rajat. All rights reserved.
//

#import "MagazineTeaserView.h"

@implementation MagazineTeaserView

@synthesize mButton,mImage,
mIssueText,mIndex,
mTextView,mImageLoader,mDelegate;

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[self.mDelegate magazineTeaser:self didSelectPageAtIndex:mIndex];

}


- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)pImage width:(CGFloat)pWidth height:(CGFloat)pHeight{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		mWidth  = pWidth;
		mHeight = pHeight;
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//		[center addObserver:self
//				   selector:@selector(remove:)
//					   name:UIApplicationDidReceiveMemoryWarningNotification
//					 object:nil];
		
		
		[self setBackgroundColor:[UIColor clearColor]];
		self.opaque = TRUE;
		self.mImage = pImage;
//		mButton = [[UIButton alloc] initWithFrame:frame];
//		mButton.layer.borderColor = [[UIColor yellowColor] CGColor];
//		mButton.layer.borderWidth =1;
//		mButton.layer.shadowColor = [[UIColor grayColor] CGColor];
//		mButton.layer.shadowOpacity = 1.5;
//		mButton.layer.shadowRadius = 30;
//		mButton.layer.shadowOffset = CGSizeMake(mButton.frame.size.width+10, mButton.frame.size.height+10);
//		mButton.opaque = TRUE;
//		[mButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
		//[mButton setTitle:@"Download" forState:UIControlStateNormal];
//		mIssueText = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*0.5166, frame.size.height/8, frame.size.width/4, 30)];
//		mIssueText.backgroundColor = [UIColor clearColor];
//		mIssueText.text = @"December 2010";
//		mIssueText.font = [UIFont boldSystemFontOfSize:frame.size.width/33.33];
//		mIssueText.textColor = [UIColor whiteColor];
//		mTextView=[[UITextView alloc] initWithFrame:CGRectMake(frame.size.width*0.5166, mIssueText.frame.origin.y+30, frame.size.width/2, frame.size.height - (mIssueText.frame.origin.y+30))];
//		mTextView.font = [UIFont systemFontOfSize:frame.size.width/42.85];
//		[mTextView setTextColor:[UIColor whiteColor]];
//		mTextView.backgroundColor = [UIColor clearColor];
//		mTextView.text = @"The company, which launched the service last week, will stop magazines and newspapers linking out to external websites and insist that all subscription collections go through the App Store.";
//		mTextView.editable = NO;
		
//		NSString *imageUrl = @"http://t0.gstatic.com/images?q=tbn:ANd9GcRE_ij5l_9r411CMlNCLmZP55F9uMIh3Kv4F0b40rUV49SNp_x0Qw";
//		ImageLoader *loader = [[ImageLoader	alloc] initWithUrl:imageUrl andFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
//		loader.mDelegate = self;
//		self.mImageLoader = loader;
//		
//		[loader release];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	
//	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//	imageView.alpha = 0.2;
//	
//	imageView.image =[[UIImage imageNamed:@"background.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
//
//	[self addSubview:imageView];
//	[imageView release];
	//	self.mBackGroundImageView.image = [[UIImage imageNamed:@"background.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	CGContextRef myContext = UIGraphicsGetCurrentContext();
//	CGAffineTransform t0 = CGContextGetCTM(myContext);
//	t0 = CGAffineTransformInvert(t0);
//	CGContextConcatCTM(myContext,t0);
	
	CGContextTranslateCTM(myContext, 0, mHeight);
	CGContextScaleCTM(myContext, 1.0, -1.0);
	
	CGContextDrawImage(myContext, CGRectMake(0, 0, mWidth, mHeight), [mImage CGImage]);
//	[self addSubview:mButton];
//	[self addSubview:mIssueText];
//	[self addSubview:mTextView];
	//[self addSubview:mImageLoader];

}

-(void)imageLoader:(ImageLoader*)imageloader imageLoadedForIndex:(NSInteger)pIndex
{
	[mButton setBackgroundImage:imageloader.image forState:UIControlStateNormal];
	
}

- (void)dealloc {
	self.mDelegate = nil;
	[mButton release];
	[mIssueText release];
	[mTextView release];
	[mImageLoader release];
	[mImage release];
    [super dealloc];
}


@end
