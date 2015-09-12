/***************************************************************
 *  File Name: BPViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng(Wilson) Zhao on 2013-11-18.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng(Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************/

#import "BPViewController.h"
#import "PNChart.h"
#import "RecordList.h"
@interface BPViewController ()

@end

@implementation BPViewController

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
    
    _sText.keyboardType = UIKeyboardTypeNumberPad;
    _dText.keyboardType = UIKeyboardTypeNumberPad;
    _systolicList = [[RecordList alloc] init];
    _diastolicList = [[RecordList alloc] init];
    
    NSArray *totalKeys = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] copy];
    int num_total = [totalKeys count]; //total key number
    int i = 0;
    //Restoring user data
    while(i < num_total) {
        NSString *keys1 = [NSString stringWithFormat:@"BPH%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys1] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys1];
            if(myEncodedObject!=nil){
                Record *rem = (Record *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                [self.systolicList addRecordWithRecord:rem];
            }
        }
        NSString *keys2 = [NSString stringWithFormat:@"BPL%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys2] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys2];
            if(myEncodedObject!=nil){
                Record *rem = (Record *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                
                [self.diastolicList addRecordWithRecord:rem];
            }
        }
        i++;
    }
    
    UILabel * lineChartLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    lineChartLabel1.text = @"Blood Pressure Distribution";
    lineChartLabel1.textColor = PNFreshGreen;
    lineChartLabel1.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel1.textAlignment = NSTextAlignmentCenter;
    [self.chartScrollView addSubview:lineChartLabel1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addWeight:(id)sender {
    Record * tmpS;
    Record * tmpD;
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"]; //set formatt of time to MM-dd
    //check if the list is empty
    if([_systolicList countOfList] != 0){
        //get the last one of the weight list
        Record * last = [_systolicList objectInListAtIndex:([_systolicList countOfList]-1)];
        NSString * tmp1 = [formatter stringFromDate:today];
        NSString * tmp2 = [formatter stringFromDate:last.date];

        //compare if not the same date
        if([tmp1 isEqualToString:tmp2]){
            int index = [_systolicList countOfList]-1;
            [_systolicList removeObjectFromListAtIndex:index];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"BPH%i",index]];
            tmpS = [[Record alloc] initWithName:_sText.text date:today unit:@"mmHg"];
            int i1 = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"BPH%i",i1];
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    tmpS.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpS];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i1++;
            }
            [_systolicList addRecordWithRecord:tmpS];
        }
        else{
            tmpS = [[Record alloc] initWithName:_sText.text date:today unit:@"mmHg"];
            int i1 = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"BPH%i",i1];
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    tmpS.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpS];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i1++;
            }
            [_systolicList addRecordWithRecord:tmpS];
        }
    }
    else{
        tmpS = [[Record alloc] initWithName:_sText.text date:today unit:@"mmHg"];
        int i1 = 0;
        for(;;){//check which key is empty, and insert the reminder to it
            NSString *keys = [NSString stringWithFormat:@"BPH%i",i1];
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                tmpS.key = keys;
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpS];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:myEncodedObject forKey:keys];
                [defaults synchronize];
                break;
            }
            i1++;
        }
        [_systolicList addRecordWithRecord:tmpS];
    }

    if([_diastolicList countOfList] != 0){
        //get the last one of the weight list
        Record * last = [_systolicList objectInListAtIndex:([_diastolicList countOfList]-1)];
        NSString * tmp1 = [formatter stringFromDate:today]; 
        NSString * tmp2 = [formatter stringFromDate:last.date]; 
        //compare if not the same date
        if([tmp1 isEqualToString:tmp2]){
            int index = [_diastolicList countOfList]-1;
            [_diastolicList removeObjectFromListAtIndex:index];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"BPL%i",index]];
            tmpD = [[Record alloc] initWithName:_dText.text date:today unit:@"mmHg"];
            int i2 = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"BPL%i",i2];
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    tmpD.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpD];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i2++;
            }
            [_diastolicList addRecordWithRecord:tmpD];
        }
        else{
            tmpD = [[Record alloc] initWithName:_dText.text date:today unit:@"mmHg"];
            int i2 = 0;
            for(;;){//check which key is empty, and insert the reminder to it
                NSString *keys = [NSString stringWithFormat:@"BPL%i",i2];
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                    tmpD.key = keys;
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpD];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:myEncodedObject forKey:keys];
                    [defaults synchronize];
                    break;
                }
                i2++;
            }
            [_diastolicList addRecordWithRecord:tmpD];
        }
    }
    else{
        tmpD = [[Record alloc] initWithName:_dText.text date:today unit:@"mmHg"];
        int i2 = 0;
        for(;;){//check which key is empty, and insert the reminder to it
            NSString *keys = [NSString stringWithFormat:@"BPL%i",i2];
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:keys] == nil){
                tmpD.key = keys;
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tmpD];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:myEncodedObject forKey:keys];
                [defaults synchronize];
                break;
            }
            i2++;
        }
        [_diastolicList addRecordWithRecord:tmpD];
    }
    
    [_sText resignFirstResponder];
    [_dText resignFirstResponder];
    for (UIView *view in self.chartScrollView.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]])
            [view removeFromSuperview];
    }
    
    int total = [_systolicList countOfList];
    NSString *stringDate[30];
    for(int i=0;i<30;i++){
        stringDate[i] = @"0";
    }
    for(int i=total,j=29;i>0&&j>=0;i--,j--){
        Record *tmp = [_systolicList objectInListAtIndex:i-1];
        NSDate *selectedTime = tmp.date;
        stringDate[j] = [formatter stringFromDate:selectedTime];
    }
    
    NSString *stringValue1[30];
    for(int i=0;i<30;i++){
        stringValue1[i] = @"120";
    }
    for(int i=total,j=29;i>0&&j>=0;i--,j--){
        Record *tmp1 = [_systolicList objectInListAtIndex:i-1];
        stringValue1[j] = tmp1.value;
    }
    
    NSString *stringValue2[30];
    for(int i=0;i<30;i++){
        stringValue2[i] = @"80";
    }
    for(int i=total,j=29;i>0&&j>=0;i--,j--){
        Record *tmp = [_diastolicList objectInListAtIndex:i-1];
        stringValue2[j] = tmp.value;
    }
    //get the x values and y values
    NSArray *xArray = [NSArray arrayWithObjects:stringDate count:30];
    NSArray *yArray = [NSArray arrayWithObjects:stringValue1 count:30];
    NSArray *zArray = [NSArray arrayWithObjects:stringValue2 count:30];
    //draw the diagram
    UILabel * lineChartLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
     lineChartLabel1.text = @"Weight Distribution";
     lineChartLabel1.textColor = PNFreshGreen;
     lineChartLabel1.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
     lineChartLabel1.textAlignment = NSTextAlignmentCenter;
     
     PNChart * lineChart1 = [[PNChart alloc] initWithFrame:CGRectMake(0, 40.0, SCREEN_WIDTH, 120.0)];
     lineChart1.backgroundColor = PNWhite;
     
     [lineChart1 setXLabels:xArray];
     [lineChart1 setYValues:yArray];
     [lineChart1 strokeChart];
     [self.chartScrollView addSubview:lineChartLabel1];
     [self.chartScrollView addSubview:lineChart1];
    
    PNChart * lineChart2 = [[PNChart alloc] initWithFrame:CGRectMake(0, 150.0, SCREEN_WIDTH, 120.0)];
    lineChart2.backgroundColor = PNWhite;
    [lineChart2 setStrokeColor:PNBlue];
    [lineChart2 setXLabels:xArray];//@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
    [lineChart2 setYValues:zArray];//@[@1,@24,@12,@18,@30,@10,@21]];
    [lineChart2 strokeChart];
    [self.chartScrollView addSubview:lineChart2];
    
}
@end