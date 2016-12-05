//
//  FindObituaryPopUPController.h
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import "ModelFindObituary.h"


@protocol SelectedObituaryDelegate <NSObject>

@optional
-(void)selectedObituary:(ModelFindObituary *)objObituary;

@end

@interface FindObituaryPopUPController : ViewControllerBaseClassViewController

@property(nonatomic,strong)NSMutableArray *arrObituary;
@property(nonatomic,weak)id<SelectedObituaryDelegate>delegate;
@end
