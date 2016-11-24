//
//  GroupPopupController.h
//  LivingTags
//
//  Created by appsbeetech on 31/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import "ModelViewLocalTags.h"


@protocol RemovePopUpDelegate <NSObject>

@optional
-(void)removePopup;
-(void)removePopupWithRow:(ModelViewLocalTags *)objSelect;
@end

@interface GroupPopupController : ViewControllerBaseClassViewController

@property(nonatomic,strong)IBOutlet UILabel *lblHeader;
@property(nonatomic,strong)NSMutableArray *arrGroupPopup;
@property(nonatomic,weak)id<RemovePopUpDelegate>delegate;

+(id)instance;

@end
