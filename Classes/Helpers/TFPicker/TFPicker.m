//
//  TFPicker.m
//  HardRock
//
//  Created by Rajat Talwar on 30/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TFPicker.h"


@implementation TFPicker
@synthesize mDelegate,mTitleArray,mTextField,mToolBar,isVisible;

-(id)initWithFrame:(CGRect)frame titleArray:(NSMutableArray*)pArray delegate:(id)pDelegate
{
	if (self=[super initWithFrame:frame]) {
		self.mDelegate=pDelegate;
		self.delegate = self;
		self.mTitleArray = pArray;
		[self setShowsSelectionIndicator:YES];
		mOriginalCenterPicker = self.center;
		mOriginalCenterToolBar = self.center;
		mOriginalCenterToolBar.y=frame.origin.y- (HEIGHT_TOOLBAR)/2;
		
		[self hide];
	}
	return self;
	
}

#pragma mark PickerView
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {

	return [mTitleArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
	if ([(id)mDelegate respondsToSelector:@selector(tfpicker:didSelectRow:inComponent:)]) {
		[self.mDelegate tfpicker:self didSelectRow:row inComponent:component];
	}
	
if ((mTextField!=nil) && (row<[mTitleArray count] ) && (row>=0)) {
	mTextField.text = [mTitleArray objectAtIndex:row];
}
	
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (row<[mTitleArray count] && row>=0) {
		
	return	[mTitleArray objectAtIndex:row];
	}
	else {
		return @"";
	}

	
	
}

-(void)showInView:(UIView*)pView forTitle:(NSString*)pTitle
{	isVisible = TRUE;

	if ([(id)mDelegate respondsToSelector:@selector(tfpickerWillBecomeVisible:)]) {
		
		[self.mDelegate tfpickerWillBecomeVisible:self];
	}
	
	[self resetThePickerViewForSuperView:pView];
	[self resetTheToolBarViewForSuperView:pView];
	[self selectRowForTitle:pTitle];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:PICKER_HIDE_ANIMATION_DURATION]; 

	[self setCenter:mOriginalCenterPicker];
	[mToolBar setCenter:mOriginalCenterToolBar];
	[UIView commitAnimations];


 	


}

-(void)resetThePickerViewForSuperView:(UIView*)pView
{
	
	// remove the picker from its superview first
	if (self.superview) {
		[self removeFromSuperview];
	}
	
	
	//Adding the tfpickerview to the passed view and refreshing its content and sething its hidden property to false so th
	//that it is visible.
	
	[pView addSubview:self];
	[self reloadComponent:0];
	[self setHidden:FALSE];
	
}

-(void)done
{
	if ([(id)mDelegate respondsToSelector:@selector(tfpickerDoneButtonPressed:)]) {
		
		[(id)mDelegate tfpickerDoneButtonPressed:self];
	}
	[self hide];
}
-(void)resetTheToolBarViewForSuperView:(UIView*)pView
{

	
	if (mToolBar==nil) {
		mToolBar = [TFPicker newToolBarForPickerFrame:self.frame target:self selector:@selector(done)];
	}
	
	if (mToolBar.superview) {
		[mToolBar removeFromSuperview];
	}
	[pView addSubview:mToolBar];
	[mToolBar setHidden:FALSE];
	
}

-(void)selectRowForTitle:(NSString*)pTitle
{
	// for loop to match the title passed as argument and show the picker row with matched title
	for (int i = 0; i<[mTitleArray count]; i++) { 
		
		
		NSString *title = [mTitleArray objectAtIndex:i];
		
		if ([title isEqualToString:pTitle]) {
			
			if (i>=0 && i < [self numberOfRowsInComponent:0]) {
				
				
				[self selectRow:i inComponent:0 animated:YES]; // scrolling picker to the matched item.
				
				return;
			}
		}
		
	}
	
	//If nothing matched the passed title then select the zeroth row
	if ([self numberOfRowsInComponent:0] > 0) {
		
		[self selectRow:0 inComponent:0 animated:NO];
		
		if ([(id)mDelegate respondsToSelector:@selector(tfpicker:didSelectRow:inComponent:)]) {
			
			[(id)mDelegate tfpicker:self didSelectRow:0 inComponent:0];
		}
		
		if ((mTextField!=nil) && (0<[mTitleArray count] ) ) {
			mTextField.text = [mTitleArray objectAtIndex:0];
		}
	}
	

}

-(void)hide
{
	isVisible = FALSE;

	if ([(id)mDelegate respondsToSelector:@selector(tfpickerWillHide:)]) {
		
		[self.mDelegate tfpickerWillHide:self];
	}
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:PICKER_HIDE_ANIMATION_DURATION]; 
	
	CGPoint toolbarCenter = mOriginalCenterToolBar;
	toolbarCenter.y+=self.frame.size.height+HEIGHT_TOOLBAR;
	CGPoint pickerCenter = mOriginalCenterPicker;
	pickerCenter.y+=self.frame.size.height+HEIGHT_TOOLBAR;

//	[self setHidden:TRUE];
	[mToolBar setCenter:toolbarCenter];
	[self setCenter:pickerCenter];
	
	[UIView commitAnimations];

//	[mToolBar setHidden:YES];
//	[self setHidden:YES];
	
//	[UIView commitAnimations];

	[mTextField release];
	mTextField = nil;
}


+(UIToolbar*)newToolBarForPickerFrame:(CGRect)pFrame target:(id)pTarget selector:(SEL)pSelector
{
	
	CGRect toolBarFrame = pFrame;
	toolBarFrame.origin.y-=HEIGHT_TOOLBAR;
	toolBarFrame.size.height = HEIGHT_TOOLBAR;
	UIToolbar *newToolBar = [[UIToolbar alloc] initWithFrame:toolBarFrame];
	[newToolBar setBarStyle:UIBarStyleBlackOpaque];
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:pTarget action:pSelector];
	[newToolBar setItems:[NSArray arrayWithObjects:flexibleSpace,item,nil]];
	
	[flexibleSpace release];
	flexibleSpace = nil;
	[item release];
	item = nil;
	
	return newToolBar;
	
}

-(void)dealloc
{
	if (self.superview) {
		[self removeFromSuperview];
	}
	self.mDelegate = nil;
	[mTitleArray release];
	mTitleArray=nil;
	[mTextField release];
	mTextField = nil;
	
	[mToolBar release];
	mToolBar = nil;
	[super dealloc];
}
@end
