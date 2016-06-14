//
//  LandingViewController.m
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LandingViewController.h"

@interface LandingViewController ()
{
    IBOutlet UILabel *lblLifeCelebrated;
}

@end

@implementation LandingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *string =@"Life...Celebrated";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:string forKey:@"string"];
    [dict setObject:@0 forKey:@"currentCount"];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(typingLabel:) userInfo:dict repeats:YES];
    [timer fire];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark
#pragma mark segue login
#pragma mark

-(void)didMoveToLogin
{
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        [lblLifeCelebrated setFont:boldFont];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSString *strUserID=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
            if (strUserID.length>0)
            {
                //segueProfile
                [self performSegueWithIdentifier:@"segueProfile" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"segueToLogin" sender:self];
            }
        });
    }];
}

#pragma mark
#pragma mark label animation
#pragma mark

-(void)typingLabel:(NSTimer*)theTimer
{
    NSString *theString = [theTimer.userInfo objectForKey:@"string"];
    int currentCount = [[theTimer.userInfo objectForKey:@"currentCount"] intValue];
    currentCount ++;
    [theTimer.userInfo setObject:[NSNumber numberWithInt:currentCount] forKey:@"currentCount"];
    if (currentCount > theString.length-1)
    {
        [theTimer invalidate];
    }
    [lblLifeCelebrated setText:[theString substringToIndex:currentCount]];
    if (currentCount==17)
    {
        [self performSelector:@selector(didMoveToLogin) withObject:nil afterDelay:2.0f];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
