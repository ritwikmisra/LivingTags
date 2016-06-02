//
//  LoggingViewController.h
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoggingViewController : ViewControllerBaseClassViewController

@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;


@end
