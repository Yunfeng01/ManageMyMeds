/***************************************************************
 *  File Name: WeightViewController.h
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-18.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

/*
 WeightViewController class: The page recorded user's body weight, which includes
 The function will record all the user input values and report them though line chart.
 */
#import <UIKit/UIKit.h>
#import "RecordList.h"

@interface WeightViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *weightText;
@property (strong, nonatomic) RecordList *weightList;
//@property (strong, nonatomic) IBOutlet UITextField *monthInput;
@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;
//- (IBAction)setMonth:(id)sender;
- (IBAction)addWeight:(id)sender;
@end
