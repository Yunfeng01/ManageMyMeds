/***************************************************************
 *  File Name: DINDatabase.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-03.
 *  Revisions: 2013-11-06;
 *  Revision Programmers: Teng (Leo) Long
 *  Known Bugs: None
 ****************************************************************/

/*
 DINDatabase class: Initialize a dictionary that holds the key-value
                    pairs of DIN numbers and drug names, DINs as the
                    key, corresponding drug names as the associated
                    value. Provided with functions to check if the
                    DIN entered exists in the database, and also to
                    the corresponding drug name for given DIN number.
 */

#import <Foundation/Foundation.h>

@interface DINDatabase : NSObject

@property (strong) NSMutableDictionary* DINdictionary;

-(id) init; // Load din_name information, initialize dictionary;

-(BOOL) isValidDINnumber: (NSString*) DIN; // Check if the DIN entered exists;
-(NSString*) getDrugName: (NSString*) DIN; // Return the corresponding drug name for given DIN;

@end
