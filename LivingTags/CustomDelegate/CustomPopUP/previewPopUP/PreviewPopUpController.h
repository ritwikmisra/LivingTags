//
//  PreviewPopUpController.h
//  LivingTags
//
//  Created by appsbeetech on 18/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol PreviewPopupDelegate <NSObject>

@optional
-(void)previewButtonPressed;
-(void)publishButtonPressed;

@end

@interface PreviewPopUpController : ViewControllerBaseClassViewController

@property(nonatomic,weak) id<PreviewPopupDelegate>myDelegate;
@end
