/***************************************************************
 *  File Name: Record.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-20.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 Record class: record the weight and blood pressure. It includes value and date attributes.
 *///

#import <Foundation/Foundation.h>

@interface Record : NSObject
@property( nonatomic, copy) NSString *value; //value of record
@property (nonatomic, copy) NSDate *date; //the date of the record

@property (nonatomic, copy) NSString *unit; //the unit of the record

@property (nonatomic, strong) NSString *key; //key used to store in the database



//Initialization method
-(id)initWithName:(NSString *) value date:(NSDate *)date unit:(NSString *)unit;
-(void)print;
@end