//
//  ImageHoverController.m
//  LivingTags
//
//  Created by appsbeetech on 07/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ImageHoverController.h"

@interface ImageHoverController ()
{
    IBOutlet UIImageView *imgBackground;
}

@end

@implementation ImageHoverController


+(id)getSlideMenuInstance
{
    static ImageHoverController *master=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        master=[[ImageHoverController alloc]init];
    });
    return master;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)btnPressed:(id)sender
{
    NSLog(@"button pressed");
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGesturePressed)])
    {
        [self.delegate tapGesturePressed];
    }
}


@end
