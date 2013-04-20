//
//  TFPicker.h
//  HardRock
//
//  Created by Rajat Talwar on 30/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PICKER_HIDE_ANIMATION_DURATION 0.3
#define HEIGHT_TOOLBAR 44
#define FRAME_PICKER CGRectMake(0, 200,320 ,200 )

@protocol TFPickerDelegate;



@interface TFPicker : UIPickerView <UIPickerViewDelegate>{

	id<TFPickerDelegate> mDelegate;
	NSMutableArray *mTitleArray;
	UITextField  *mTextField;
	UIToolbar *mToolBar;
	CGPoint mOriginalCenterPicker,mOriginalCenterToolBar;
	BOOL isVisible;
}
@property(nonatomic,readonly) 	BOOL isVisible;

@property(assign)	id<TFPickerDelegate> mDelegate;
@property(nonatomic,retain)	NSMutableArray *mTitleArray;
@property(nonatomic,retain) UITextField  *mTextField;
@property(nonatomic,retain)	UIToolbar *mToolBar;

/*!
  Initializes and returns a newly allocated picker object with the specified frame rectangle and row title array
  @param CGRect			frame 
 .@param NSMutableArray pArray
 .@param id				pDelegate
  */
-(id)initWithFrame:(CGRect)frame titleArray:(NSMutableArray*)pArray delegate:(id)pDelegate;

/*!
  Makes the picker visible by adding it as a subview to the passed view and sets the default row title to the passed title
  @param UIView			pView 
 .@param NSString		pTitle
  */
-(void)showInView:(UIView*)pView forTitle:(NSString*)pTitle;

/*!
  Hides the picker by setting its hidden property to true and releasing the reference to the textfield associated with the picker
  */
-(void)hide;

/*!
  Creates a new toolbar with a done button used to dissmiss the picker and positioning is calculated on the basis of the frame of the picker 
 passed as an argument .pTarget is the target and pSelector is the selector for the action when done button is pressed.
 @param CGRect frame
 @param id	   pTarget
 @param SEL	   pSelector

  */
+(UIToolbar*)newToolBarForPickerFrame:(CGRect)pFrame target:(id)pTarget selector:(SEL)pSelector;


/*!
  Resets the picker's superview to pView and sets it hidden property to FALSE .
 @param UIView pView
 
  */
-(void)resetThePickerViewForSuperView:(UIView*)pView;

/*!
  Resets the toolbar's superview to pView and sets it hidden property to FALSE
 @param UIView pView
 
  */
-(void)resetTheToolBarViewForSuperView:(UIView*)pView;

/*!
  Scrolls the picker row according to the title string passed as argument.If argument is not matched then zeroth row is selected by default.
 @param NSString pTitle
 
  */

-(void)done;

-(void)selectRowForTitle:(NSString*)pTitle;
@end


//TFPickerDelegate definition
@protocol TFPickerDelegate

@optional

-(void)tfpicker:(TFPicker*)tfpicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(void)tfpickerWillBecomeVisible:(TFPicker*)tfpicker;
-(void)tfpickerWillHide:(TFPicker*)tfpicker;
-(void)tfpickerDoneButtonPressed:(TFPicker*)tfpicker;

@end


