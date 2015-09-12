/***************************************************************
 *  File Name: LoginViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng Zhao on 2013-10-25.
 *  Revisions: None
 *  Revision Programmers: None
 *  Known Bugs: None
 ****************************************************************/

#import "LoginViewController.h"

@interface LoginViewController ()
@property NSString *accountName;
@property NSString *password;
@property BOOL newUser; //used to decide whether it is a new user
@end

@implementation LoginViewController

@synthesize textAccount;
@synthesize textPassword;
//Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization (Not currently implemented)
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _accountName = [[NSUserDefaults standardUserDefaults] stringForKey:@"accountName"];
    _password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    if(!([_accountName length] == 0)){
        textAccount.text = _accountName;
        textPassword.text = _password;
        _userButton.hidden = YES;
        _loginButton.hidden = NO;
        _newUser = NO;
    }
    else{
        _loginButton.hidden = YES;
        _newUser = YES;
    }
    textPassword.secureTextEntry = YES;
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//dismiss the keyboard when touching outside the keyboard frame
- (IBAction)dismissAnyWhere:(id)sender {
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
}

//dismiss the keyboard after pressing the return for accout name
- (IBAction)dismissReturn:(id)sender {
    [textAccount resignFirstResponder];
}

//dismiss the keyboard after pressing the return for password
- (IBAction)dismissPassword:(id)sender {
    [textPassword resignFirstResponder];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //if the account name is wrong and not a new user
    if (![textAccount.text isEqualToString:_accountName]&&(!_newUser)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Your account name is not correct" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //if the password is wrong and not a new user
    else if (![textPassword.text isEqualToString:_password]&&(!_newUser)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Your password is not correct" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else{
        return YES;
    }
}
@end
