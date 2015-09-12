/***************************************************************
 *  File Name: ReminderDataController.h
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions: None
 *  Revision Programmers: None
 *  Known Bugs: None
 ****************************************************************/

/*
 ReminderDataController Class: Controller for data model. Instaniates
 a mutable array to hold Reminder objects
 and controls all access to this array
 (adding, deleting, referencing, and
 counting Reminders) - Encapsulates
 reminderList data.
 */


#import <Foundation/Foundation.h>

@class Reminder;

@interface ReminderDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterReminderList;//Contains reminder objects
@property (nonatomic, copy) NSMutableArray *masterTrackingList;//Contains integer number of misses for each reminder time for each drug
@property (nonatomic, copy) NSMutableArray *masterEditCheckList;//Used to check for edited reminders in the reminder list



- (NSUInteger)countOfList; //Retrieve number of reminders in reminderList
- (Reminder *)objectInListAtIndex:(NSUInteger)index; //Retrieve reminder pointer
- (void)addReminderWithReminder: (Reminder *) reminder; //Add reminder to array
- (void)removeObjectFromListAtIndex:(NSUInteger)index;  //Remove reminder from array
- (void)disableReminderInListAtIndex:(NSUInteger)index; //Turn off notfications for reminder object
- (void)updateReminderNotifications; //Schedule all reminder notifications
- (void)updateTrackingList; //Update masterTrackingList of missed doses fore each drug
- (void)scheduleNotificationWithTime:(NSDate *)time drugName:(NSString *)drugName days:(int)days ringer:(BOOL)ringer remIndex:(int)remIndex timeIndex:(int)timeIndex; //Schedule an Individual notification
- (void)restoreReminderList:(NSMutableArray*)newList; //set masterReminderList with reminders from NSUserDefaults



@end
