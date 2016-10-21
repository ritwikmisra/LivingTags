//
//  NetworkActivityViewController.m
//  CARLiFESTYLEExchange
//
//  Created by appsbeetech on 29/01/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "NetworkActivityViewController.h"

@interface NetworkActivityViewController ()
{
    @private
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIImageView *img;
}

@end

@implementation NetworkActivityViewController
@synthesize animating=_animating;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NetworkActivityViewController*)sharedInstance
{
    static NetworkActivityViewController *networkActivity=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkActivity=[[NetworkActivityViewController alloc] initWithNibName:@"NetworkActivityViewController" bundle:nil];
    });
    return networkActivity;
}

-(void)changeAnimatingStatusTo:(BOOL)animate
{
    if (animate)
    {
        [activityIndicator startAnimating];
        
    }
    else
    {
        [activityIndicator stopAnimating];
    }
   /* [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [img setTransform:CGAffineTransformRotate(img.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished)
        {
            if (animate)
            {
                [self changeAnimatingStatusTo:animate];
            }
            else
            {
                NSLog(@"Stop");
            }
        }
    }];*/
    _animating=animate;
}
@end
