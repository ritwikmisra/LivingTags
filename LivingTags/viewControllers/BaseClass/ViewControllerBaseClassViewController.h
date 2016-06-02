//
//  ViewControllerBaseClassViewController.h
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"
#import "AppDelegate.h"


@interface ViewControllerBaseClassViewController : UIViewController
{
    @protected
    AppDelegate *appDel;
}

@property(nonatomic,strong)    IBOutlet UIImageView *imgBackground;


-(void)displayErrorWithMessage:(NSString*)strMsg;
-(BOOL)isValidEmail:(NSString*)strEmailID;
-(id)getSuperviewOfType:(Class)myClass fromView:(id)myView;
-(NSString *)generateMD5:(NSString *)string;

@end
