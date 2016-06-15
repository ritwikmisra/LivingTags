//
//  SlideMenuController.h
//  LivingTags
//
//  Created by appsbeetech on 12/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol sideBarDelegate <NSObject>

@optional

-(void)selectedRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SlideMenuController : ViewControllerBaseClassViewController

+(id)getSlideMenuInstance;

@property(assign,nonatomic) BOOL isSlideMenuVisible;


@property(nonatomic,weak)id<sideBarDelegate>delegate;


@end
