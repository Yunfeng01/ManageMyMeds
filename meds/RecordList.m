/***************************************************************
 *  File Name: RecordList.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-20.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "RecordList.h"
#import "PNChart.h"

@implementation RecordList
//Initializes a reminderList
- (void)initializeDefaultDataList {
    NSMutableArray *recordList = [[NSMutableArray alloc] init];
    self.list = recordList;
    
}

//setter for reminderList
- (void)setMasterReminderList:(NSMutableArray *)newList{
    if(_list != newList){
        _list = [newList mutableCopy];
    }
}

//Intializes a ReminderDataController object;
-(id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

/* This code has been added to support encoding and decoding my objecst */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.list forKey:@"list"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.list = [decoder decodeObjectForKey:@"list"];
    }
    return self;
}


//Returns the number of reminders in reminder list
- (NSUInteger) countOfList {
    return [self.list count];
    
}

//Returns pointer to reminder at given index in reminder list(array)
- (Record *)objectInListAtIndex:(NSUInteger)index {
    return [self.list objectAtIndex:index];
}


//Adds a reminder object to the reminder list(array) and updates notifications
- (void)addRecordWithRecord:(Record *)record {
    [_list addObject:record];
}

//Removes a reminder object at a given index in the reminder list(array) and updates notifications
- (void)removeObjectFromListAtIndex:(NSUInteger)index {
    [self.list removeObjectAtIndex:index];
}

@end

