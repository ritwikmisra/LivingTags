//
//  CustomPopUpViewController.h
//  LivingTags
//
//  Created by appsbeetech on 16/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol CustomPopUPDelegate <NSObject>

@optional
-(void)takePictureFromCamera;
-(void)takePictureFromGallery;

@end

@interface CustomPopUpViewController : ViewControllerBaseClassViewController

@property(weak,nonatomic)id<CustomPopUPDelegate>delegate;

@end
