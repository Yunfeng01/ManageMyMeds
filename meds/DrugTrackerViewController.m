/***************************************************************
 *  File Name: DrugTrackerViewController.m
 *  Project Name: ManageMyMeds
 *  Group Name: MLearningG
 *  Created by: Yunfeng Zhao on 2013-11-05.
 *  Revisions: 2013-11-20;
 *  Revision Programmers: Yunfeng (Wilson) Zhao
 *  Known Bugs: None
 ****************************************************************///

#import "DrugTrackerViewController.h"
#import "ReminderDataController.h"
#import "Reminder.h"
#import "PNChart.h"
@interface DrugTrackerViewController ()
//Picker View for picking remaining pills
@property UIPickerView *pillsPicker;
@property int index;
@property NSMutableArray *reminderList;
@end

@implementation DrugTrackerViewController

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
    
    _reminderList = [[NSMutableArray alloc] init];
    
	// get back all the reminder from the NSUserdefault database
    NSArray *totalKeys = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] copy];
    int num_total = [totalKeys count]; //total key number
    int i = 0;
    
    //Restoring user data
    while(i < num_total) {
        NSString *keys = [NSString stringWithFormat:@"reminder%i",i];
        //check if the key is not empty, then save the reminder data back to the local array
        if([[NSUserDefaults standardUserDefaults] objectForKey:keys] != nil){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey:keys];
            if(myEncodedObject!=nil){
                Reminder *rem = (Reminder *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
                
                [_reminderList addObject:rem];
            }
        }
        i++;
    }
    if([_reminderList count] != 0){
        Reminder * tmp = [_reminderList objectAtIndex:0];
        _drugName.text = tmp.name;
    }
    
    //Intialize picker
    _pillsPicker = [[UIPickerView alloc]init];
    
    //set input view of remaining pills to picker
    [_drugName setInputView:_pillsPicker];
    
    //set picker data source and delegate
    [_pillsPicker setDataSource:self];
    [_pillsPicker setDelegate:self];
    
    [_pillsPicker setShowsSelectionIndicator:YES];
    //show the label of bar chart
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    barChartLabel.text = @"Bar Chart";
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
    [self.chartScrollView addSubview:barChartLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//define the picker view
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_reminderList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Reminder * tmp = [_reminderList objectAtIndex:row];
    return tmp.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    Reminder * tmp = [_reminderList objectAtIndex:row];
    _drugName.text = tmp.name;
    _index = row;
}

/*Update textfield when user selects number of pills remaining in picker
 by pressing "set".*/
- (IBAction)draw:(id)sender {
    [_drugName resignFirstResponder];
    //get back the 2 list that store the user medication history
    NSMutableArray *masterTrackingList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"tracklist"]];
    
    NSMutableArray *masterEditCheckList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"checklist"]];
    //if the list is not empty, then draw the bar chart
    if([masterEditCheckList count]!= 0 && [masterTrackingList count]!= 0){
        NSMutableArray *drugTracker = [masterTrackingList objectAtIndex:_index];
        NSMutableArray *drugTime = [masterEditCheckList objectAtIndex:_index];
        
        for (UIView *view in self.chartScrollView.subviews)
        {
            if (![view isKindOfClass:[UIImageView class]])
                [view removeFromSuperview];
        }
        
        int total = [drugTime count];
        NSString *stringDate[total];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mma"]; //set formatt of time to dd
        for(int i=0;i<total;i++){
            NSDate *selectedTime = [drugTime objectAtIndex:i];
            stringDate[i] = [formatter stringFromDate:selectedTime];
        }
        NSString *stringValue[total];
        for(int i=0;i<total;i++){
            stringValue[i] = [drugTracker objectAtIndex:i];            
        }
        //get the x values and y values 
        NSArray *xArray = [NSArray arrayWithObjects:stringDate count:total];
        NSArray *yArray = [NSArray arrayWithObjects:stringValue count:total];
        //draw the diagram
        UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        barChartLabel.text = @"Bar Chart";
        barChartLabel.textColor = PNFreshGreen;
        barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
        barChartLabel.textAlignment = NSTextAlignmentCenter;
        
        PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 40.0, SCREEN_WIDTH, 200.0)];
        barChart.backgroundColor = [UIColor clearColor];
        barChart.type = PNBarType;
        [barChart setXLabels:xArray];
        [barChart setYValues:yArray];
        [barChart strokeChart];
        [self.chartScrollView addSubview:barChartLabel];
        [self.chartScrollView addSubview:barChart];
    }
}
@end
