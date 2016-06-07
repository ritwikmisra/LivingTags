//
//  ImageHoverController.h
//  LivingTags
//
//  Created by appsbeetech on 07/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol ImageTapDelegate <NSObject>

@optional
-(void)tapGesturePressed;
@end

@interface ImageHoverController : ViewControllerBaseClassViewController
+(id)getSlideMenuInstance;

@property(nonatomic,weak)id<ImageTapDelegate>delegate;

@end


