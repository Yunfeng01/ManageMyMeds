/***************************************************************
 *  File Name: LoginViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng Zhao on 2013-10-25.
 *  Revisions: None
 *  Revision Programmers: None
 *  Known Bugs: None
 ****************************************************************/

/*
 LoginViewController Class: Controls the login process for our Application
 */

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textAccount;    
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)dismissAnyWhere:(id)sender;     //dismiss the keyboard user touches outside keyboard
- (IBAction)dismissReturn:(id)sender;       //dismiss the keyboard after pressing return for account name
- (IBAction)dismissPassword:(id)sender;     //dismiss the keyboard after pressing return for password

@end
