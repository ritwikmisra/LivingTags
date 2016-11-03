//
//  CustomdatePickerViewController.m
//  i700
//
//  Created by Kaustav Shee on 3/18/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import "CustomdatePickerViewController.h"

@interface CustomdatePickerViewController ()
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *btnSet;
    IBOutlet UIButton *btnCancel;

}

@end

@implementation CustomdatePickerViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Delegate:(id)myDelegate
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        delegate=myDelegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [datePicker setMaximumDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnSetPressed:(id)sender
{
    NSLog(@"selected date%@",[datePicker date]);
    if (delegate && [delegate respondsToSelector:@selector(didSelectedDate:)])
    {
        [delegate didSelectedDate:[datePicker date]];
    }
}
-(IBAction)btnCancelPressed:(id)sender
{
   /* if (delegate && [delegate respondsToSelector:@selector(didCancel)])
    {
        [delegate didCancel];
    }*/
    [self.view removeFromSuperview];
}


@end
