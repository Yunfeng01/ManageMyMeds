/***************************************************************
 *  File Name: WeightViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-18.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "WeightViewController.h"
#import "PNChart.h"
#import "RecordList.h"

@interface WeightViewController ()
//Picker View for picking remaining pills
//@property (nonatomic, strong) UIPickerView *monthPicker;
//variable to store entered number of remaining pills.
//@property (nonatomic, assign) int pickedMonths;

@end

@implementation WeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _weightText.keyboardType = UIKeyboardTypeNumberPad;
    _weightList = [[RecordList alloc] init];
    NSArray *totalKeys = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] copy];
    int num_total = [totalKeys count]; //total key number
    int i = 0;
    //Restoring user data
    while(i < num_total) {
        NSString *keys = [NSString stringWithFormat:@"weight%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys];
            if(myEncodedObject!=nil){
                Record *rem = (Record *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                
                [self.weightList addRecordWithRecord:rem];
            }
        }
        i++;
    }
    
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    lineChartLabel.text = @"Weight Distribution";
    lineChartLabel.textColor = PNFreshGreen;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    [self.chartScrollView addSubview:lineChartLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addWeight:(id)sender {
    Record * tmp;
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"]; //set formatt of time to MM-dd
    //check if the list is empty
    if([_weightList countOfList] != 0){
    //get the last one of the weight list
    Record * last = [_weightList objectInListAtIndex:([_weightList countOfList]-1)];
        NSString * tmp1 = [formatter stringFromDate:today];
        NSString * tmp2 = [formatter stringFromDate:last.date]; 
    //compare if not the same date
        if([tmp1 isEqualToString:tmp2]){
            int index = [_weightList countOfList]-1;
            [_weightList removeObjectFromListAtIndex:index];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"weight%i",index]];
            tmp = [[Record alloc] initWithName:_weightText.text date:today unit:@"lb"];
             int i = 0;
             for(;;){//check which key is empty, and insert the reminder to it
                 NSString *keys = [NSString stringWithFormat:@"weight%i",i];
                 
                 if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                     tmp.key = keys;
                     NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmp];
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     [defaults setObject:myEncodedObject forKey:keys];
                     [defaults synchronize];
                     break;
                 }
                 i++;
             }
            [_weightList addRecordWithRecord:tmp];
        }
        else{
            tmp = [[Record alloc] initWithName:_weightText.text date:today unit:@"lb"];
            int i = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"weight%i",i];
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    tmp.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmp];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i++;
            }
            [_weightList addRecordWithRecord:tmp];
        }
    }
    else{
        tmp = [[Record alloc] initWithName:_weightText.text date:today unit:@"lb"];
        int i = 0;
        for(;;){//check which key is empty, and insert the reminder to it
            NSString *keys = [NSString stringWithFormat:@"weight%i",i];
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                tmp.key = keys;
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmp];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:myEncodedObject forKey:keys];
                [defaults synchronize];
                break;
            }
            i++;
        }
        [_weightList addRecordWithRecord:tmp];
    }
    
    [_weightText resignFirstResponder];
    for (UIView *view in self.chartScrollView.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]])
            [view removeFromSuperview];
    }
    
    int total = [_weightList countOfList];
    NSString *stringDate[30];
    for(int i=0;i<30;i++){
        stringDate[i] = @"0";
    }
    
    for(int i=total,j=29;i>0&&j>=0;i--,j--){
        Record *tmp = [_weightList objectInListAtIndex:i-1];
        NSDate *selectedTime = tmp.date;
        stringDate[j] = [formatter stringFromDate:selectedTime];
    }
    NSString *stringValue[30];
    for(int i=0;i<30;i++){
        stringValue[i] = @"60";
    }
    for(int i=total,j=29;i>0&&j>=0;i--,j--){
        Record *tmp = [_weightList objectInListAtIndex:i-1];
        stringValue[j] = tmp.value;
    }

    //get the x values and y values
    NSArray *xArray = [NSArray arrayWithObjects:stringDate count:30];
    NSArray *yArray = [NSArray arrayWithObjects:stringValue count:30];
    //draw the diagram
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
     lineChartLabel.text = @"Weight Distribution";
     lineChartLabel.textColor = PNFreshGreen;
     lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
     lineChartLabel.textAlignment = NSTextAlignmentCenter;
     
     PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 40.0, SCREEN_WIDTH, 200.0)];
     lineChart.backgroundColor = PNWhite;
     
     [lineChart setXLabels:xArray];
     [lineChart setYValues:yArray];
     [lineChart strokeChart];
     [self.chartScrollView addSubview:lineChartLabel];
     [self.chartScrollView addSubview:lineChart];
}
@end