/***************************************************************
 *  File Name: CallViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Teng (Leo) Long
 *  Known Bugs: None
 ****************************************************************/

/*
 CallViewController class: call the family, doctor and 911
 *///


#import <UIKit/UIKit.h>

@interface CallViewController : UIViewController

- (IBAction)emergencyCallFamily:(id)sender;
- (IBAction)emergencyCallDoctor:(id)sender;
- (IBAction)emergencyCallExtreme:(id)sender;

@end

