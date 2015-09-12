/***************************************************************
 *  File Name: AppDelegate.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: None
 *  Revision Programmers: None
 *  Known Bugs: None
 ****************************************************************/

#import "AppDelegate.h"

#import "MasterViewController.h"


@implementation AppDelegate


NSMutableArray *stack; //stack for storing notification data



//Added - for when notification received when App is not running
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    stack = [[NSMutableArray alloc] init];
    
    // Override point for customization after application launch.
    
    
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.jpg"]]];
    
    // Handle launching from a notification
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        [stack addObject:[notification.userInfo mutableCopy]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reminder" message:notification.alertBody delegate:nil cancelButtonTitle:@"Missed Dose" otherButtonTitles:@"Took Dose", nil];
        [alertView show];
        
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"app_active" object:nil]];
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //Push notification data on to stack
    
    [stack addObject:[notification.userInfo mutableCopy]];
    
    //Issue Reminder and dose tracking prompt.
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                    message:notification.alertBody
                                                   delegate:self cancelButtonTitle:@"Missed Dose"
                                          otherButtonTitles:@"Took Dose", nil];
    [alert show];
    
    
    // Request to reload table view data
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    
    
    
    
}

//Respond to Missed/Took button press
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    //Missed pressed
    if (buttonIndex == 0){
        [self updateTracker:1];
        
    }
    else
    {   //Took pressed
        [self updateTracker:0];
    }
    
}

//Post notification for updating the drugTracker in the datacontroller
-(void) updateTracker: (int)doseTaken{    
   
    //Get most recent notification data
    NSMutableDictionary *postData = [stack lastObject];

    //add missed dosed data
    [postData setObject:@(doseTaken) forKey: @"doseTaken"];    
    
    
    //Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"trackStat" object:self userInfo:postData];
    
    //Remove object from stack
    [stack removeLastObject];
    
    
}


@end
