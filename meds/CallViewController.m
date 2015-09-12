/***************************************************************
 *  File Name: CallViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-05.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Teng (Leo) Long
 *  Known Bugs: None
 ****************************************************************/

#import "CallViewController.h"

@interface CallViewController ()
@property NSString * familyNumber;
@property NSString * doctorNumber;
@end

@implementation CallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _familyNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"familyNum"];
    _doctorNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"doctorNum"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emergencyCallFamily:(id)sender {
    // Get pre-set family number from NSUserDefault;
    //NSString* familyNumber = @"";
    
    // Call!!!
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", _familyNumber]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)emergencyCallDoctor:(id)sender {
    // Get pre-set doctor number from NSUserDefault;
    //NSString* doctorNumber = @"";
    
    // Call!!!
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", _doctorNumber]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)emergencyCallExtreme:(id)sender {
    // Don't try this number, you'll be responsible for the outcome!
    NSString* policeNumber = @"911";
    
    // Don't Call!!!
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", policeNumber]];
    [[UIApplication sharedApplication] openURL:url];
}
@end