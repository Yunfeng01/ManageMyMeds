/***************************************************************
 *  File Name: ReminderDataController.m
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: Removed initialized placeholder reminder object
 *             inside initialized reminderList that was used
 *             for development purposes.
 *             Added local notification scheduling/updating
 *             Added drug tracking
 *
 *  Revision Programmers: Philip Stead
 *  Known Bugs: None
 ****************************************************************/

#import "ReminderDataController.h"
#import "Reminder.h"

@interface ReminderDataController ()
- (void)initializeDefaultDataList;

@property (nonatomic, assign) int notificationCount; //tracks number of scheduled local notifications
@end


@implementation ReminderDataController



//Initializes the data lists
- (void)initializeDefaultDataList {
    NSMutableArray *reminderList = [[NSMutableArray alloc] init];
    self.masterReminderList = reminderList;
    
    NSMutableArray *trackingList = [[NSMutableArray alloc] init];
    self.masterTrackingList = trackingList;
    
    NSMutableArray *editCheckList = [[NSMutableArray alloc] init];
    self.masterEditCheckList = editCheckList;
    
    
    
    //React to pop-up reminder message presses
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTrackingStat:) name:@"trackStat" object:nil];
    
    
}

//setter for data lists
- (void)setMasterReminderList:(NSMutableArray *)newList{
    if(_masterReminderList != newList){
        _masterReminderList = [newList mutableCopy];
    }
}

- (void)setMasterTrackingList:(NSMutableArray *)newList{
    if(_masterTrackingList != newList){
        _masterTrackingList = [newList mutableCopy];
    }
}

- (void)setMasterEditCheckList:(NSMutableArray *)newList{
    if(_masterEditCheckList != newList){
        _masterEditCheckList = [newList mutableCopy];
    }
}




//Intializes a ReminderDataController object;
-(id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        _notificationCount = 0;
        return self;
    }
    return nil;
}




//Returns the number of reminders in reminder list
- (NSUInteger) countOfList {
    return [self.masterReminderList count];
    
}

//Returns pointer to reminder at given index in reminder list(array)
- (Reminder *)objectInListAtIndex:(NSUInteger)index {
    return [self.masterReminderList objectAtIndex:index];
    
}


/*Adds a reminder object to the reminder list(array)
adds corresponding reminder times array to the master
edit check list and creates an integer array of miss counts
for each reminder time for the drug and updates notifications*/
- (void)addReminderWithReminder:(Reminder *)reminder {
    
    [self.masterReminderList addObject:reminder];
    
    
    [self.masterEditCheckList addObject:reminder.times];
    
    
    NSMutableArray *trackStats = [[NSMutableArray alloc] init];
    int count = [reminder.times count];
    for(int i = 0; i < count; i++){[trackStats addObject: @(0)];}
    
    [_masterTrackingList addObject:trackStats];
    
    
    [self updateReminderNotifications];
    
    
}

/*Removes a reminder object at a given index in the data list
 arrays and updates notifications*/
- (void)removeObjectFromListAtIndex:(NSUInteger)index {
    [self.masterReminderList removeObjectAtIndex:index];
    [self.masterTrackingList removeObjectAtIndex:index];
    [self.masterEditCheckList removeObjectAtIndex:index];
    [self updateReminderNotifications];
    
}

//Turns off notfications for reminder object and updates notifications
- (void)disableReminderInListAtIndex:(NSUInteger)index {
    
    Reminder *reminder = [self objectInListAtIndex:index];
    reminder.enabled = NO;
    [self updateReminderNotifications];
}

//Used to restore reminders from NSUserDefaults in the masterViewController class.
- (void)restoreReminderList:(NSMutableArray*)newList{
    _masterReminderList = newList;
}

//Updates the missed dose statistics. Called whenever a reminder object is edited.
- (void)updateTrackingList{
    
    
    //Update data lists from NSUserDefaults.
    NSMutableArray *tmp1 = [[NSMutableArray alloc] init];
    tmp1 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"tracklist"]];
    NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
    tmp2 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"checklist"]];
    
    if(([tmp1 count] != 0) && ([tmp2 count] != 0)){
        _masterTrackingList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"tracklist"]];
        
        _masterEditCheckList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"checklist"]];
    }
   
    /*For each reminder, check if entries in the masterEditList correspond,
    if they do then copy the corresponding miss count from the masterTrackingList into the
     newStats array.*/
    int counter = 0;
    NSMutableArray *newEditList = [[NSMutableArray alloc] init];
    
    for (Reminder *reminder in _masterReminderList){
        [newEditList addObject:reminder.times];
        NSMutableArray *newStats = [[NSMutableArray alloc] init];
        for(NSDate *dateNew in reminder.times){
            int k = 0;
            for(NSDate *dateOld in [_masterEditCheckList objectAtIndex:counter]){
                if([dateOld isEqualToDate:dateNew]){[newStats addObject:[[_masterTrackingList objectAtIndex:counter] objectAtIndex:k]];}
                k++;
            }
            
        }
        
        int test1 = [reminder.times count];
        int test2 = [newStats count];
        int diff = test1 - test2;
        
        
        /*Add new 0 entries to the newStats array for newly added reminder times*/
        for(int i = 0; i < (diff); i++){[newStats addObject:@(0)];}
        
        /*Replace array in masterTrackingList*/
        [_masterTrackingList replaceObjectAtIndex:counter withObject:newStats];
        counter++;
    }
    
    
    
    /*Update masterEditCheckList*/
    _masterEditCheckList = newEditList;
    
   /*Update NSUserDefaults*/
    [[NSUserDefaults standardUserDefaults] setObject:_masterTrackingList forKey:@"tracklist"];
    [[NSUserDefaults standardUserDefaults] setObject:_masterEditCheckList forKey:@"checklist"];
}



//Handle missed dose data from reminder pop-ups
-(void)handleTrackingStat:(NSNotification *)notification{
    
    
    /*Get index of the reminder in the reminder list and the time in the reminder times
    array of that reminder, and the missed dose value from the notification */
    NSDictionary *dict = [notification userInfo];
    NSInteger remIndex =  [[dict objectForKey:@"remIndex"] integerValue];
    NSInteger timeIndex = [[dict objectForKey:@"timeIndex"] integerValue];
    NSInteger missedDose = [[dict objectForKey:@"doseTaken"] integerValue];
    
    
    /*if dose was not missed then decrement remaining pills for that drug
     and issue a warning pop-up if 10 or less pills remain*/
    if(missedDose == 0){
        Reminder *reminder = [_masterReminderList objectAtIndex:remIndex];
        if(reminder.remainingPills > 0 ){
            
            reminder.remainingPills--;
            
            if(reminder.remainingPills < 11){
                
                NSString *alertBody = [NSString stringWithFormat:@"Only %d doses of %@ remaining!", reminder.remainingPills, reminder.name];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remaining Pills Warning"
                                                                message:alertBody
                                                               delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
        }
    }
    
    else{
        
        /*Increment the missed dose value for the correct reminder time*/
        
        NSMutableArray *drugTracker = [_masterTrackingList objectAtIndex:remIndex];
  
        
        NSInteger missedDoses = [[drugTracker objectAtIndex:timeIndex] integerValue] + missedDose;
        NSNumber *newMissedDoses = [NSNumber numberWithInt:missedDoses];
        [drugTracker replaceObjectAtIndex:timeIndex withObject: newMissedDoses];
        
        [_masterTrackingList replaceObjectAtIndex:remIndex withObject: drugTracker];
    }
    
   /*save to NSUserDefaults*/
    [[NSUserDefaults standardUserDefaults] setObject:_masterTrackingList forKey:@"tracklist"];
    [[NSUserDefaults standardUserDefaults] setObject:_masterEditCheckList forKey:@"checklist"];
    
    
    
}


#define MAX_NOTIFICATIONS 64


//Reschedule all reminder notifications.
- (void)updateReminderNotifications {
    
    
    
    
    //Cancel all existing notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    /*Iterate through reminders and reminder times to schedule each until
     maximum number reached*/
    if(self.countOfList > 0){
        _notificationCount = 0;
        int days = 0;
        while (_notificationCount < MAX_NOTIFICATIONS){
            int i = 0;
            for(Reminder *reminder in _masterReminderList){
                if(_notificationCount >= MAX_NOTIFICATIONS){break;}
                if(reminder.enabled){
                    int j = 0;
                    for (NSDate *reminderTime in reminder.times){
                        if(_notificationCount >= MAX_NOTIFICATIONS){break;}
                        [self scheduleNotificationWithTime:reminderTime drugName:reminder.name days:days ringer:reminder.ring remIndex:i timeIndex:j];
                        j++;
                        
                        
                    }
                }
                i++;
            }
            
            days++;
        }
    }
}


//Schedules an individuale notification
- (void)scheduleNotificationWithTime:(NSDate *)time drugName:(NSString *)drugName days:(int)days ringer:(BOOL)ringer remIndex:(int)remIndex timeIndex:(int)timeIndex{
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(remIndex), @"remIndex", @(timeIndex), @"timeIndex", nil];
    
    //Date formatter
    static NSDateFormatter *dateformatter = nil;
    if (dateformatter == nil){
        dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateStyle:NSDateFormatterMediumStyle];
        [dateformatter setDateFormat:@"yyyy-MM-dd 'at' hh:mma"];
    }
    
    //Current time and date
    NSDate *now = [NSDate date];
    int daysToAdd = days;
    //Time in (days) time from now
    NSDate *setDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    //Calendars for composing firing date and condition
    NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *timeComps = [calendar1 components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:time];
    NSInteger hours = [timeComps hour];
    NSInteger minutes = [timeComps minute];
    
    NSCalendar *calendar2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [calendar2 components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:setDate];
    NSInteger day = [dateComps day];
    NSInteger month = [dateComps month];
    NSInteger year = [dateComps year];
    
    
    NSCalendar *calendar3 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *reminderComps = [[NSDateComponents alloc] init];
    [reminderComps setDay:day];
    [reminderComps setMonth:month];
    [reminderComps setYear:year];
    [reminderComps setHour:hours];
    [reminderComps setMinute:minutes];
    
    //Compose reminder date
    NSDate * reminderDate = [calendar3 dateFromComponents:reminderComps];
    
    //String reminder date
    NSString *remString = [dateformatter stringFromDate:(NSDate *)reminderDate];
    
    
    //Compose alert message
    NSString *alertMessage = [NSString stringWithFormat: @"Take %@ %@", drugName,remString];
    
    
    //Compose and schedule notifications
    if ([[reminderDate laterDate:now] isEqualToDate:reminderDate]){
        UILocalNotification* reminderNotification = [[UILocalNotification alloc] init];
        reminderNotification.fireDate = reminderDate;
        reminderNotification.alertBody = alertMessage;
        reminderNotification.userInfo = dataDict;
        reminderNotification.timeZone = [NSTimeZone defaultTimeZone];
        if(ringer){reminderNotification.soundName = UILocalNotificationDefaultSoundName;
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:reminderNotification];
        _notificationCount++;
        
        
    }
    
}








@end
