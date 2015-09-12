/***************************************************************
 *  File Name: DINDatabase.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Teng (Leo) Long on 2013-11-03.
 *  Revisions: 2013-11-08;
 *  Revision Programmers: Teng (Leo) Long
 *  Known Bugs: None
 ****************************************************************/

#import "DINDatabase.h"

@implementation DINDatabase

@synthesize DINdictionary;

// Initialize a DINDatabase object, load DIN-name dictionary;
-(id) init {
    self = [super init];
    
    if (self) {
        
        DINdictionary = [[NSMutableDictionary alloc] init];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"din_name" ofType:@"txt"];
        NSURL* URL = [NSURL fileURLWithPath:path];
        
        NSString* str = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:nil];
        NSArray* strArray = [str componentsSeparatedByString:@"\n"];
        
        for (int i = 0; i < [strArray count]; i++) {
            NSString* entry = [strArray objectAtIndex:i];
            NSArray* entryArr = [entry componentsSeparatedByString:@","];
            
            [DINdictionary setObject:[entryArr objectAtIndex:1] forKey:[entryArr objectAtIndex:0]];
        }
        
    }
    
    return self;
}

// Check if the given DIN exists in the database;
// return YES if true, return false otherwise.
-(BOOL) isValidDINnumber: (NSString*) DIN {
    if ([DINdictionary objectForKey:DIN]) {
        return YES;
    }
    
    return NO;
}

// Return the corresponding drug name for given DIN;
// assume the given DIN has been fully validated.
-(NSString*) getDrugName: (NSString*) DIN {
    return [DINdictionary objectForKey:DIN];
}

@end
