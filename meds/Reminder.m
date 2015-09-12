/***************************************************************
 *  File Name: Reminder.m
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

#import "Reminder.h"

@implementation Reminder

//Initialization method implementation
-(id)initWithName:(NSString *)name din:(NSString *)din times:(NSMutableArray *)times remainingPills:(int)remainingPills enabled:(BOOL)enabled ring:(BOOL)ring

{
    self = [super init];
    if (self){
        _name = name;
        _din = din;
        _times = times;
        _remainingPills = remainingPills;
        _enabled = enabled;
        _ring = ring;
        return self;
    }
    return nil;
}
/* This code has been added to support encoding and decoding my objecst */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.din forKey: @"din"];
    [encoder encodeObject:self.times forKey:@"times"];
    [encoder encodeInt:self.remainingPills forKey:@"remainingPills"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
    [encoder encodeBool:self.ring forKey:@"ring"];
    [encoder encodeObject:self.key forKey:@"key"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.name = [decoder decodeObjectForKey:@"name"];
        self.din = [decoder decodeObjectForKey:@"din"];
        self.times = [decoder decodeObjectForKey:@"times"];
        self.remainingPills = [decoder decodeIntForKey:@"remainingPills"];
        self.enabled = [decoder decodeBoolForKey:@"enabled"];
        self.ring = [decoder decodeBoolForKey:@"ring"];
        self.key = [decoder decodeObjectForKey:@"key"];
    }
    return self;
}


@end
