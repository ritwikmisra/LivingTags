//
//  SidePanelController.h
//  LivingTags
//
//  Created by appsbeetech on 25/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"


@protocol SidePanelSwipeDelegate <NSObject>

@optional
-(void)swipeToCloseSidePanel;
@end

@interface SidePanelController : ViewControllerBaseClassViewController




+(id)getInstance;

@property(nonatomic,assign) BOOL isSlideMenuVisible;

@property(nonatomic,strong) IBOutlet UIImageView*imgBackGround;
@property(nonatomic,weak)id<SidePanelSwipeDelegate>delegate;
@property(nonatomic,strong) IBOutlet UITableView *tblSidePanel;


@end
