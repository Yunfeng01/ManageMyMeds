/***************************************************************
 *  File Name: TimePicker.m 
 *  Project Name: ManageMyMeds
 *  Groupt Name: MLearningG
 *  Created by: Philip Stead on 2013-11-7.
 *  Revisions: None
 *  Known Bugs: None
 ****************************************************************/

#import "TimePicker.h"

#define MyDateTimePickerToolbarHeight 40

@interface TimePicker()


@property (nonatomic, assign, readwrite) UIDatePicker *picker;

//"select" button id and selector
@property (nonatomic, assign) id doneTarget;
@property (nonatomic, assign) SEL doneSelector;

- (void) donePressed;

@end


@implementation TimePicker

@synthesize picker = _picker;

@synthesize doneTarget = _doneTarget;
@synthesize doneSelector = _doneSelector;

/*Create the picker view inside a fram with a toolbar at the top and a "select" button for when the user
is done choosing a time on the picker*/
- (id) initWithFrame: (CGRect) frame {
    if ((self = [super initWithFrame: frame])) {
        self.backgroundColor = [UIColor clearColor];
        
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, MyDateTimePickerToolbarHeight, frame.size.width, frame.size.height - MyDateTimePickerToolbarHeight)];
        [self addSubview: picker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, MyDateTimePickerToolbarHeight)];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Select" style: UIBarButtonItemStyleDone target: self action: @selector(donePressed)];
        UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
        
        [self addSubview: toolbar];
        
        self.picker = picker;
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (void) setMode: (UIDatePickerMode) mode {
    self.picker.datePickerMode = mode;
}

//"Select" button is pressed, user done with picker
- (void) donePressed {
    if (self.doneTarget) {
        [self.doneTarget performSelector:self.doneSelector withObject:nil afterDelay:0];
    }
}

//Target for "select button"
- (void) addTargetForDoneButton: (id) target action: (SEL) action {
    self.doneTarget = target;
    self.doneSelector = action;
}

@end
