/***************************************************************
 *  File Name: Reminder.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25 (with help from Yunfeng Zhao).
 *  Revisions: Changed t1, start, and end parameters from NSString to NSDate objects
 *             Deleted interval parameter as it was not used in this version
 *             Changed ring parameter's type to BOOL
 *             Changed t1 to time array, removed end and start date, added NSUSerdefaults
 *
 *  Revision Programmers: Philip Stead
 *  Known Bugs: None
 ****************************************************************/

/*
 Reminder Class: Most fundamental unit in the data model. Each
                 Reminder object contains data regarding the
                 name of the drug, the desired reminder time
                 the start and end dates for the reminder,
                 the remaining number of doses/pills for 
                 the medication and whether or not th user
                 wants a audible (ring) to accompany a
                 reminder alert.
 */

#import <Foundation/Foundation.h>

@interface Reminder : NSObject

@property( nonatomic, copy) NSString *name; //medication ID
@property (nonatomic, copy) NSString *din;

@property (nonatomic, copy) NSMutableArray *times;
@property (nonatomic, assign) int remainingPills;
@property (nonatomic, assign) BOOL enabled; //reminder is set
@property (nonatomic, assign) BOOL ring; //audible alert flag

@property (nonatomic, strong) NSString *key; //key used to store in the database



//Initialization method
-(id)initWithName:(NSString *) name din:(NSString *)din times:(NSMutableArray *)times remainingPills:(int)remainingPills enabled:(BOOL)enabled ring:(BOOL)ring;



@end
