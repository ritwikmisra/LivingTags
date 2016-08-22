//
//  DatePickerViewController.m
//  LivingTags
//
//  Created by appsbeetech on 22/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *btnDone;
    NSString *strDate;
}

@end

@implementation DatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnDone.layer.cornerRadius=5.0f;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-70];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker setMaximumDate:[NSDate date]];
    datePicker.minimumDate=minDate;
    [datePicker addTarget:self
                        action:@selector(SetDatePickerTime:)
              forControlEvents:UIControlEventValueChanged];
    NSLog(@"%d",self.textfieldTag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnDoneSelected:(id)sender
{
    if (strDate.length>0)
    {
        [self.view removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedDateWithValue:withTag:)])
        {
            [self.delegate selectedDateWithValue:strDate withTag:self.textfieldTag];
        }
    }
    else
    {
        [self displayErrorWithMessage:@"Please select a date first"];
    }
}

-(void)SetDatePickerTime:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
   // [outputFormatter setDateFormat:@"dd/MM/yyy"];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    strDate = [outputFormatter stringFromDate:datePicker.date];
}
@end
