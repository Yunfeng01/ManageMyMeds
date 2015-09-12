/***************************************************************
 *  File Name: DrugTrackerViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng Zhao on 2013-11-05.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************///
/*
 DrugTrackerViewController class: Keep track the user medication history and draw the bar chart for the data.
 */

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "ReminderDataController.h"
@interface DrugTrackerViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *chartScrollView;
@property (strong, nonatomic) IBOutlet UITextField *drugName;

- (IBAction)draw:(id)sender;
@end
