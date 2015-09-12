/***************************************************************
 *  File Name: MasterViewController.m
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: deleted intervalLabel as it is no longer used
 *             Added data restoration
 *             Added reminder detail editing functionality
 *  Revision Programmers: Philip Stead
 *  Known Bugs: None
 ****************************************************************/

#import "MasterViewController.h"
#import "ReminderDataController.h"
#import "Reminder.h"
#import "AddReminderViewController.h"



@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    //Initialize Data Model
    self.dataController = [[ReminderDataController alloc] init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    //self.tableView.backgroundView = nil;
    //self.tableView.backgroundColor = [UIColor colorWithRed:176.0f/255.0f   green:196.0f/255.0f  blue:222.0f/255.0f  alpha:1.0f ];
    
   
    
    NSArray *totalKeys = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] copy];
    
    [self.navigationController.toolbar setHidden: NO];
    
    int num_total = [totalKeys count]; //total key number
    int i = 0;
    
    //Restoring user data
    while(i < num_total) {
        NSString *keys = [NSString stringWithFormat:@"reminder%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys];
            if(myEncodedObject!=nil){
                Reminder *rem = (Reminder *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                
                [self.dataController addReminderWithReminder:rem];
            }
        }
        i++;
    }
    [[self tableView] reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppActivation) name:@"app_active" object:nil];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

- (void) handleAppActivation{
    [_dataController updateReminderNotifications];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//One row in Table per Reminder in Reminder List
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}


//Set up Table cells and titles (Drug Name)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReminderCell"; //Reusable identifier
    
    //Date Formatter for subtitle (Reminder Time) string
    static NSDateFormatter *formatter = nil;
    if (formatter == nil){
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setDateFormat:@"hh:mma"];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Get pointer to reminder for this row.
    Reminder *reminderAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    
    //Set Cell title = drug name
    [[cell textLabel] setText:reminderAtIndex.name];
    
    
    
    return cell;
    
    
}

//Allow for deletion of reminder cells from the table.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//Specify What happens when the edit, then delete buttons are pressed (Note: Add/Edit reminder details functionality is implemented outside commitEditingStyle method)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Reminder *rem = [self.dataController objectInListAtIndex:indexPath.row];
    //delete the reminder from database
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:rem.key];
    
    [self.dataController removeObjectFromListAtIndex:indexPath.row];
    //Remove row marked for deletion from Table by user
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
}

//restore reminders to reminderList in the dataController
-(void)restoreReminders{
    
    NSArray *totalKeys = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] copy];
    
    [self.navigationController.toolbar setHidden: NO];
    
    int num_total = [totalKeys count]; //total key number
    int i = 0;
    NSMutableArray *newRemList = [[NSMutableArray alloc]init];
    
    //Restoring user data
    while(i < num_total) {
        NSString *keys = [NSString stringWithFormat:@"reminder%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys];
            if(myEncodedObject!=nil){
                Reminder *rem = (Reminder *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                
                [newRemList addObject:rem];
            }
        }
        i++;
    }
    
    [self.dataController restoreReminderList:newRemList];
    

    
}


//Specify what happens when a user presses done in the Add Reminder View
- (IBAction)done: (UIStoryboardSegue *)segue{
    
    /*if reminder creation conditions in AddReminderViewController class
     have been met */
    if ([[segue identifier] isEqualToString:@"ReturnInput"]){
        AddReminderViewController *addController = [segue sourceViewController];
        if(!addController.edit){
            if (addController.reminder){
                int i = 0;
                for(;;){//check which key is empty, and insert the reminder to it
                    NSString *keys = [NSString stringWithFormat:@"reminder%i",i];
                    
                    if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                        addController.reminder.key = keys;
                        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:addController.reminder];
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:myEncodedObject forKey:keys];
                        [defaults synchronize];
                        break;
                    }
                    i++;
                }
                //Add reminder generated in Add Reminder View from user input.
                [self.dataController addReminderWithReminder:addController.reminder];
                //Refresh TableView
                [[self tableView] reloadData];
            }
        }
        
        /*if reminder editing conditions in AddReminderViewController class have been met */
        else if (addController.edit){
            AddReminderViewController *addController = [segue sourceViewController];
            //delete the reminder from database
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:addController.reminder.key];
            int i = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"reminder%i",i];
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    addController.reminder.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:addController.reminder];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i++;
            }
            //Add reminder generated in Add Reminder View from user input.
            //[self.dataController addReminderWithReminder:addController.reminder];
            //Refresh TableView
            [[self tableView] reloadData];
            [self restoreReminders];
            [_dataController updateReminderNotifications];
            [_dataController updateTrackingList];
        }
    }
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

//Specify what happens if user presses cancel during reminder creation
- (IBAction)cancel:(UIStoryboardSegue *)segue{
    // if cancel button pressed => dismiss Add Reminder View.
    if ([[segue identifier] isEqualToString:@"CancelInput"]){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


//Handle Segue to AddReminderViewController for editing a reminder.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"editReminder"]) {
        
        
        AddReminderViewController *addReminderController = [[[segue destinationViewController] viewControllers]objectAtIndex:0];
        
        addReminderController.reminder = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        
        
        
    }
}

@end
