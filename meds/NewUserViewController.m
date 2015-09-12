/***************************************************************
 *  File Name: NewUserViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-08;
 *  Revision Programmers: Teng (Leo) Long, Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "NewUserViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

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
    _textConfirm.secureTextEntry = YES;
    _familyNum.keyboardType = UIKeyboardTypeNumberPad;
    _doctorNum.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Set textFieldReturn conditions
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.textName)
        || (textField == self.textPassword)
        ||(textField == self.textConfirm)){
        
        [textField resignFirstResponder];
    }
    
    return YES;
}


- (IBAction)dismissAccount:(id)sender {
    [_textName resignFirstResponder];
}

- (IBAction)dismissPass:(id)sender {
    [_textPassword resignFirstResponder];
}

- (IBAction)dismiss:(id)sender {
    [_textConfirm resignFirstResponder];
}

- (IBAction)setFamNum:(id)sender {
    [_familyNum resignFirstResponder];
}

- (IBAction)setDocNum:(id)sender {
    [_doctorNum resignFirstResponder];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //if the password and confirm are not the same
    if ((![_textPassword.text isEqualToString:_textConfirm.text])||([_textName.text length]== 0)||[_textPassword.text length]== 0||[_textConfirm.text length]== 0) {
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
