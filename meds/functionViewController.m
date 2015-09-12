/***************************************************************
 *  File Name: functionViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng Zhao on 2013-11-05.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************///

#import "functionViewController.h"

@interface functionViewController ()

@end

@implementation functionViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchButton:(id)sender {
    //link to the drug product government server
    NSString* google = @"webprod5.hc-sc.gc.ca/dpd-bdpp/index-eng.jsp";
    
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://%@", google]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
