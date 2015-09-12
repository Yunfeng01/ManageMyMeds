/***************************************************************
 *  File Name: TimePicker.h
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-11-7.
 *  Revisions: None
 *  Known Bugs: None
 ****************************************************************/
#import <UIKit/UIKit.h>

/*
 TimePicker Class: Adds a "select" button in a navigation bar
                   attached to the top of a (time) datePicker View.
 */

@interface TimePicker : UIView {
}

@property (nonatomic, assign, readonly) UIDatePicker *picker;

- (void) setMode: (UIDatePickerMode) mode;
- (void) addTargetForDoneButton: (id) target action: (SEL) action;

@end
