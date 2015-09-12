/***************************************************************
 *  File Name: BPViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-18.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 BPViewController class: The page recorded user's blood pressure, which includes
 systolic value and diastolic value. The function will record all the user input values and report them though 2 separate line chart.
 */

#import <UIKit/UIKit.h>
#import "RecordList.h"

@interface BPViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *sText;
@property (strong, nonatomic) IBOutlet UITextField *dText;
@property (strong, nonatomic) RecordList *systolicList;
@property (strong, nonatomic) RecordList *diastolicList;
//@property (strong, nonatomic) IBOutlet UITextField *monthInput;
@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;
//- (IBAction)setMonth:(id)sender;
- (IBAction)addWeight:(id)sender;
@end
