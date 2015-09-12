/***************************************************************
 *  File Name: RecordList.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-20.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 RecordList class: a list of record that used to stores the record of weight and blood pressure.
 The tracker page can handle the list such as drawing the line chart.
 *///

#import <Foundation/Foundation.h>
#import "Record.h"
#import "PNChart.h"

@interface RecordList : NSObject
@property(nonatomic, retain) NSMutableArray *list; //list of record
- (void)initializeDefaultDataList;
- (NSUInteger)countOfList; //Retrieve number of records in recordsList
- (Record *)objectInListAtIndex:(NSUInteger)index; //Retrieve records pointer
- (void)addRecordWithRecord: (Record *) reminder; //Add records to array
- (void)removeObjectFromListAtIndex:(NSUInteger)index;  //Remove records from array
//- (PNChart)drawhart;

@end