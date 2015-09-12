/***************************************************************
 *  File Name: SettingsViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-08;
 *  Revision Programmers: Teng (Leo) Long, Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 SettingsViewController class: Edit the User Account information and store them.
 */

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *textName;

@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textCon;
@property (strong, nonatomic) IBOutlet UITextField *familyNum;
@property (strong, nonatomic) IBOutlet UITextField *doctorNum;

- (IBAction)dismissPass:(id)sender;
- (IBAction)dismissCon:(id)sender;
- (IBAction)setFamNum:(id)sender;
- (IBAction)setDocNum:(id)sender;

@end
