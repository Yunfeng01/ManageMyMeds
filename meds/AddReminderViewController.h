/***************************************************************
 *  File Name: AddReminderViewController.h
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: Added textfield "set" button IBActions
 *             Added IBOutlets for textfield "set" buttons
               Reorganized code and added edit flag.
 *  Revision Programmers: Yunfeng (Wilson) Zhao, Teng (Leo) Long, Philip Stead
 *  Known Bugs: None
 ****************************************************************/

/*
 AddReminderViewController Class: Controls the reminder
                                  creation process (solicits,
                                  facilitates, and ensures
                                  the validity of user input
                                  and then instantiates a 
                                  reminder object if conditions
                                  are met). Also controls the 
                                  reminder editing process -
                                  edits reminder attributes if
                                  conditions are met.
 */


#import <UIKit/UIKit.h>
#import "DINDatabase.h"
@class Reminder;

@interface AddReminderViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


//Input textfields/labels
@property (weak, nonatomic) IBOutlet UITextField *DINInput; 
@property (weak, nonatomic) IBOutlet UITextField *remainingPillsInput;
@property (strong, nonatomic) IBOutlet UILabel *showName;



//Add reminder button label
@property (weak, nonatomic) IBOutlet UIButton *addReminderTimeLabel;

//Delete Reminder time button labels
@property (weak, nonatomic) IBOutlet UIButton *deleteReminderLabel1;
@property (weak, nonatomic) IBOutlet UIButton *deleteReminderLabel2;
@property (weak, nonatomic) IBOutlet UIButton *deleteReminderLabel3;
@property (weak, nonatomic) IBOutlet UIButton *deleteReminderLabel4;
@property (weak, nonatomic) IBOutlet UIButton *deleteReminderLabel5;

//Reminder time labels
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel1;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel2;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel3;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel4;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel5;

//remaining pills label
@property (strong, nonatomic) IBOutlet UILabel *pillsLabel;

//switch for the ringer
@property (strong, nonatomic) IBOutlet UISwitch *ringer;


@property (strong, nonatomic) Reminder *reminder;
@property(nonatomic, assign) BOOL edit; //flag for determining if user is editing/adding


//IBActions for add/delete reminder buttons
- (IBAction)addReminderTime:(id)sender;
- (IBAction)deleteReminderTime1:(id)sender;
- (IBAction)deleteReminderTime2:(id)sender;
- (IBAction)deleteReminderTime3:(id)sender;
- (IBAction)deleteReminderTime4:(id)sender;
- (IBAction)deleteReminderTime5:(id)sender;

//Action for DIN addn adn set button
- (IBAction)addDin:(id)sender;
- (IBAction)setDIN:(id)sender;


//Action for pills remaining set.
- (IBAction)setPillsRemaining:(id)sender;



@end
