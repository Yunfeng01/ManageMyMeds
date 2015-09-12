/***************************************************************
 *  File Name: AddReminderViewController.m
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-10-25.
 *  Revisions:  Added date pickers for input view to time/date fields:
 *              (t1, start, end).
 *              Added picker view for remaining pills input field
 *              Added behaviour for field "set" buttons
 *              Changed ReturnInput conditions so incomplete reminders
 *              are not generated.
 *              Changed t1 to array of times to match new reminder attribute
 *              Added TimePicker for selecting reminder times
 *              Removed start and end date input as they served no real purpose
 *                  nearly all drugs are taken long term (user would have needed
 *                   to arbitrarilty pick an end date)
 *              Integrated DINDatabase class for selection of medication via DIN
 *              Added "edit" functionality when reminder is pressed in master view
 *              Added input validation and helpful alerts for users.
 *
 *  Revision Programmers: Yunfeng (Wilson) Zhao, Philip Stead, Teng (Leo) Long
 *  Known Bugs: None
 ****************************************************************/

#import "AddReminderViewController.h"
#import "Reminder.h"
#import "TimePicker.h"

@interface AddReminderViewController ()

// Time picker for reminder times@property UIDatePicker *picker;
@property TimePicker *tPicker;

//Picker View for picking remaining pills
@property UIPickerView *pillsPicker;

//Array to store reminder time picker selections
@property (nonatomic, strong) NSMutableArray *reminderTimes;

//Arrays to store and access time labels and delete time labels
@property (nonatomic, strong) NSMutableArray *reminderTimeLabels;
@property (nonatomic, strong) NSMutableArray *deleteReminderLabels;


//variable to store entered number of remaining pills.
@property (nonatomic, assign) int pickedPills;

//variable to track number of reminder times added by the user
@property(nonatomic, assign) int remTimeCount;

//Flag to track whether a reminder time can be added. (must be between 1 and 5 reminder times)
@property(nonatomic, assign) BOOL addTime;


//max number of reminder times per reminder/medication
#define REM_TIME_MAX 5;


@end


@implementation AddReminderViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    //self.tableView.backgroundView = nil;
    //self.tableView.backgroundColor = [UIColor colorWithRed:176.0f/255.0f   green:196.0f/255.0f  blue:222.0f/255.0f  alpha:1.0f ];
    
    //Numberpad for DIN entry 
    _DINInput.keyboardType = UIKeyboardTypeNumberPad;
    
    
  
  //Time picker instantiation for choosing reminder times.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    _tPicker = [[TimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
    [_tPicker addTargetForDoneButton:self action:@selector(donePressed)];
   
    //Hide time picker and set it's mode to time only
    _tPicker.hidden = YES;
    [_tPicker setMode:UIDatePickerModeTime];
    
    
    //Initialize array of reminder times
    _reminderTimes = [[NSMutableArray alloc]init];
    
    //Initialize array of reminder time labels and delete reminder button labels
    _reminderTimeLabels = [NSMutableArray arrayWithObjects: _reminderLabel1, _reminderLabel2, _reminderLabel3, _reminderLabel4, _reminderLabel5, nil];    
     _deleteReminderLabels = [NSMutableArray arrayWithObjects: _deleteReminderLabel1, _deleteReminderLabel2, _deleteReminderLabel3, _deleteReminderLabel4, _deleteReminderLabel5, nil];
    
    //set reminder time count to zero
    _remTimeCount = 0;
    
    //set add reminder time flag to true
    _addTime = YES;    
    
  
    //Intialize picker
    _pillsPicker = [[UIPickerView alloc]init];
    
    //set input view of remaining pills to picker
    [_remainingPillsInput setInputView:_pillsPicker];
    
    //set picker data source and delegate
    [_pillsPicker setDataSource:self];
    [_pillsPicker setDelegate:self];
    
    
    [_pillsPicker setShowsSelectionIndicator:YES];
    
    _pickedPills = 1; //set to one to account for row:0 component = 1 in picker
    
    //IF editing a reminder: Initialize input fields with all reminder data
    if(_reminder != nil){
        
        
        _DINInput.text = _reminder.din;
        _showName.text = _reminder.name;
        _showName.hidden = NO;
        
        _pickedPills = _reminder.remainingPills;
        
        
        NSString *pillString = [[NSString alloc] initWithFormat:@"%d", _pickedPills];
        _remainingPillsInput.text = pillString;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mma"]; //set formatt of time to HH:MM AM/PM
        
        
        for (NSDate *j in _reminder.times){[_reminderTimes addObject:j];}
        
        int counter = 0;
        for(NSDate *i in _reminderTimes){
            NSString *textTime = [formatter stringFromDate:i];
            NSString *textT = [[NSString alloc] initWithFormat:@"%@",textTime];
            UILabel *reminderLabeli = _reminderTimeLabels[counter];
            UIButton *deleteReminderLabeli = _deleteReminderLabels[counter];
            reminderLabeli.text = textT;
            reminderLabeli.hidden = NO;
            deleteReminderLabeli.hidden = NO;
            counter++;
            
            
        }
        _ringer.on = _reminder.ring;
        _remTimeCount = counter;
        _edit = YES;
        
    } // end of if statement

 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


/*Validating input to the DIN field and setting/displaying the drug name if DIN input valid*/
- (IBAction)setDIN:(id)sender {
    DINDatabase* dinDictionary = [[DINDatabase alloc] init];
    
    if ([_DINInput.text length] < 8) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid DIN Number" message:@"DIN entered contains less than 8 digits, DIN must consist of exactly 8 digits." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([_DINInput.text length] > 8) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid DIN Number" message:@"DIN entered contains more than 8 digits, DIN must consist of exactly 8 digits." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        if ([dinDictionary isValidDINnumber:_DINInput.text]) {
            _showName.text = [dinDictionary getDrugName:_DINInput.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid DIN Number" message:@"DIN entered cannot be found in the database." delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

//Actions for when a user presses "Select" on the time picker when adding a reminder time
-(void)donePressed{
    //unhide the picker and store the selected time in a temporary variable
    _tPicker.hidden = YES;
    NSDate *selectedTime = [_tPicker.picker date];
    
    //add new reminder time to reminderTimes input array
    [self.reminderTimes addObject:selectedTime];
    
    //Set the text label up for displaying the time.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mma"]; //set formatt of time to HH:MM AM/PM
    NSString *textTime = [formatter stringFromDate:selectedTime];
    NSString *textT = [[NSString alloc] initWithFormat:@"%@",textTime];
    
    [self.reminderTimeLabels[_remTimeCount] setText:textT];
    
    //set the labels and unhide them
    UILabel *remLabel = self.reminderTimeLabels[_remTimeCount];
    UIButton *delButton = self.deleteReminderLabels[_remTimeCount];
    remLabel.hidden = NO;
    delButton.hidden = NO;
    
    _remTimeCount++;   
   
}


/*When add a reminder button is pressed. If there are less than five current reminder times
the add the subview and unhide the picker, else display an alert*/
- (IBAction)addReminderTime:(id)sender{
    
    if (_remTimeCount < 5){        
        
        [self.view addSubview:_tPicker];
        _tPicker.hidden = NO;
        
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Maximum Number of Reminder Times Exceeded"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
        
}


//Actions for when each of the delete reminder time buttons are pressed
-(IBAction)deleteReminderTime1:(id)sender{
    [self deleteTimes:0];
}

-(IBAction)deleteReminderTime2:(id)sender{
    [self deleteTimes:1];
}

-(IBAction)deleteReminderTime3:(id)sender{
    [self deleteTimes:2];
}

-(IBAction)deleteReminderTime4:(id)sender{
    [self deleteTimes:3];
}

-(IBAction)deleteReminderTime5:(id)sender{
    [self deleteTimes:4];
}

- (IBAction)addDin:(id)sender {
    [_DINInput resignFirstResponder];
}


//For deletion of a reminder
-(void)deleteTimes:(int)index{
    int i = index;
    [_reminderTimes removeObjectAtIndex:index];
    while (i + 1 < _remTimeCount){
        UILabel *remLabeli = _reminderTimeLabels[i];
        UILabel *remLabelj = _reminderTimeLabels[i + 1];
        remLabeli.text = remLabelj.text;
        i++;
        
    }
    //Hide deleted reminder's time and delete labels, decrement remidner count
    UILabel *remLabelToHide = _reminderTimeLabels[i];
    UIButton *delButtonToHide = self.deleteReminderLabels[i];
    remLabelToHide.hidden = YES;
    delButtonToHide.hidden = YES;
    _remTimeCount--;
    
}



//set limits on remaining pills number to be selected
#define PICKER_MIN 1
#define PICKER_MAX 250


/*Following four methods used to specify a picker to select between
1 and 250 for remaining pills and store the currently selected number in
 pickedPills integer variable*/
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return (PICKER_MAX-PICKER_MIN+1);
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d", (row+PICKER_MIN)];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _pickedPills = row +1;
}

/*Update textfield when user selects number of pills remaining in picker
 by pressing "set".*/
- (IBAction)setPillsRemaining:(id)sender{
    NSString *pillString = [[NSString alloc] initWithFormat:@"%d", _pickedPills];
    self.remainingPillsInput.text = pillString;
    [_remainingPillsInput resignFirstResponder];
    
}






#pragma mark - Table view data source

//Set textFieldReturn conditions
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.DINInput)
        || (textField == self.remainingPillsInput)){
        
        [textField resignFirstResponder];
    }
    
    return YES;
}


/*Handle Segue back to MasterView - assess if conditions
for reminder creation/editing are met when the done button is pressed
- if they are met and the user is editing a reminder then the old reminder
 object is edited, if the user is adding a reminder the new reminder is
 created*/
- (void)prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender{
    
    //If user presses done button
    if([[segue identifier] isEqualToString:@"ReturnInput"]){
        
        if ([self.DINInput.text length]
            && (self.remTimeCount > 0)
            && [self.remainingPillsInput.text length])
            
       
            
        {
            if(_edit){
                _reminder.name = _showName.text;
                _reminder.din = _DINInput.text;
                _reminder.times = _reminderTimes;
                _reminder.remainingPills = _pickedPills;
                _reminder.ring = _ringer.on;
                
            
                
            }
            
            else {
                //Create Reminder object using input and store it in self.reminder
                Reminder *reminder;
                reminder = [[Reminder alloc] initWithName:self.showName.text din:self.DINInput.text times:self.reminderTimes remainingPills:self.pickedPills enabled:YES ring:self.ringer.on];
                self.reminder = reminder;
                
               
                
                
            }
        }
    }
}

/*Input validation on when the user presses the done button. Issues alerts to the user when needed input
has not been provided */
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"ReturnInput"]){
        if (([_showName.text length]== 0)||([_DINInput.text length]== 0)) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Please enter a valid DIN for your medication" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
        
        else if ([_remainingPillsInput.text length]== 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Please enter the number of remaining pills" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
        
        else if (_remTimeCount == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Please schedule at least one reminder time" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }  
    


    return YES;
}


@end
