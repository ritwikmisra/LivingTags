//
//  CustomdatePickerViewController.h
//  i700
//
//  Created by Kaustav Shee on 3/18/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomdatePickerViewControllerDelegate <NSObject>

@optional

-(void)didSelectedDate:(NSDate*)selectedDate;
-(void)didCancel;

@end

@interface CustomdatePickerViewController : UIViewController
{
    __weak id <CustomdatePickerViewControllerDelegate> delegate;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Delegate:(id)myDelegate;

@end
