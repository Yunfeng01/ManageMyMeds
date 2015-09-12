/***************************************************************
 *  File Name: NewUserViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-08;
 *  Revision Programmers: Teng (Leo) Long, Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 NewUserViewController class: Control the Create New Account process
 for our application, store the created
 new account name and password for user
 login.
 */

#import <UIKit/UIKit.h>

@interface NewUserViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textConfirm;
@property (strong, nonatomic) IBOutlet UITextField *familyNum;
@property (strong, nonatomic) IBOutlet UITextField *doctorNum;

- (IBAction)dismissAccount:(id)sender;
- (IBAction)dismissPass:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)setFamNum:(id)sender;
- (IBAction)setDocNum:(id)sender;

@end
