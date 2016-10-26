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

#define K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD @"IMAGE_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_VIDEO_UPLOAD @"VIDEO_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_ERROR @"ERROR"

@interface ViewControllerBaseClassViewController : UIViewController
{
    @protected
    AppDelegate *appDel;
    NSDateFormatter *dateFormatter;
    NSString *strDateFormat;
}

-(void)displayErrorWithMessage:(NSString*)strMsg;
-(BOOL)isValidEmail:(NSString*)strEmailID;
-(id)getSuperviewOfType:(Class)myClass fromView:(id)myView;
-(NSString *)generateMD5:(NSString *)string;
-(void)displayNetworkActivity;
-(void)hideNetworkActivity;
@end
