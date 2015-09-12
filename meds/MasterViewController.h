/***************************************************************
 *  File Name: MasterViewController.h
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: None
 *  Revision Programmers: None
 *  Known Bugs: None
 ****************************************************************/

/*
 MasterViewController Class: Controls the Main View in the App
                             (Displays the list of medication
                             reminders and allows users to  
                             delete/add a reminder.
 */

#import <UIKit/UIKit.h>

@class ReminderDataController;

@interface MasterViewController : UITableViewController

//Data Model Controller
@property (strong, nonatomic) ReminderDataController *dataController;

//Handle Segue when user is done adding a reminder (presses done)
- (IBAction)done:(UIStoryboardSegue *)segue;

//Handle Segue when user cancels the reminder creation partway through (presses cancel)
- (IBAction)cancel:(UIStoryboardSegue *) segue;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
