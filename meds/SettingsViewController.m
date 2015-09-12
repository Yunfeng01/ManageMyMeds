/***************************************************************
 *  File Name: SettingsViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-08;
 *  Revision Programmers: Teng (Leo) Long, Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    _textPassword.secureTextEntry = YES;
    _textCon.secureTextEntry = YES;
    _familyNum.keyboardType = UIKeyboardTypeNumberPad;
    _doctorNum.keyboardType = UIKeyboardTypeNumberPad;
    //get the user data and show them
    _textName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"accountName"];
    _textPassword.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    _textCon.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    _familyNum.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"familyNum"];
    _doctorNum.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"doctorNum"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Set textFieldReturn conditions
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.textPassword)
        ||(textField == self.textCon)){
        
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)dismissPass:(id)sender {
    [_textPassword resignFirstResponder];
}

- (IBAction)dismissCon:(id)sender {
    [_textCon resignFirstResponder];
}

- (IBAction)setFamNum:(id)sender {
    [_familyNum resignFirstResponder];
}

- (IBAction)setDocNum:(id)sender {
    [_doctorNum resignFirstResponder];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //if the password and confirm are not the same
    if ((![_textPassword.text isEqualToString:_textCon.text])||([_textName.text length]== 0)||[_textPassword.text length]== 0||[_textCon.text length]== 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Your Inputs are not correct." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if (([_familyNum.text length] < 10) || ([_doctorNum.text length] < 10)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Phone Number" message:@"Phone number entered contains less than 10 digits, phone number must consist of exactly 10 digits." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (([_familyNum.text length] > 10)||([_doctorNum.text length] > 10)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Phone Number" message:@"Phone number entered contains more than 10 digits, phone number must consist of exactly 10 digits." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accountName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"familyNum"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"doctorNum"];
        [[NSUserDefaults standardUserDefaults]
         setObject:_textName.text forKey:@"accountName"];
        [[NSUserDefaults standardUserDefaults]
         setObject:_textPassword.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]
         setObject:_familyNum.text forKey:@"familyNum"];
        [[NSUserDefaults standardUserDefaults]
         setObject:_doctorNum.text forKey:@"doctorNum"];
        return YES;
    }
}

@end
