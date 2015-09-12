/***************************************************************
 *  File Name: Record.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-20.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "Record.h"

@implementation Record

//Initialization method implementation
-(id)initWithName:(NSString *) value date:(NSDate *)date unit:(NSString *)unit
{
    self = [super init];
    if (self){
        _value = value;
        _date = date;
        _unit = unit;
        return self;
    }
    return nil;
}
/* This code has been added to support encoding and decoding my objecst */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.value forKey:@"value"];
    [encoder encodeObject:self.date forKey: @"date"];
    [encoder encodeObject:self.unit forKey:@"unit"];
    [encoder encodeObject:self.key forKey:@"recordkey"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.value = [decoder decodeObjectForKey:@"value"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.unit = [decoder decodeObjectForKey:@"unit"];
        self.key = [decoder decodeObjectForKey:@"recordkey"];
    }
    return self;
}
-(void)print{
    NSLog(@"%@ %@ %@",_date,_value,_unit);
}

@end

