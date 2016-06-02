//
//  NetworkActivityViewController.h
//  CARLiFESTYLEExchange
//
//  Created by appsbeetech on 29/01/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkActivityViewController : UIViewController
{
    @private
    BOOL _animating;
}

@property(assign,nonatomic,readonly,getter=isAnimating) BOOL animating;

+(NetworkActivityViewController*)sharedInstance;

-(void)changeAnimatingStatusTo:(BOOL)animate;

@end
