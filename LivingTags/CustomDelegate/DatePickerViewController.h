//
//  DatePickerViewController.h
//  LivingTags
//
//  Created by appsbeetech on 22/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol SelectedDateDelegate <NSObject>

@optional
-(void)selectedDateWithValue:(NSString *)strDate withTag:(NSInteger)i;

@end
@interface DatePickerViewController : ViewControllerBaseClassViewController

@property(weak,nonatomic)id<SelectedDateDelegate> delegate;
@property(nonatomic,assign)NSInteger textfieldTag;
@end
