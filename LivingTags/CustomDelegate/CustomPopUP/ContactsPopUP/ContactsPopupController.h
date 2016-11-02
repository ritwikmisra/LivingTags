//
//  ContactsPopupController.h
//  LivingTags
//
//  Created by appsbeetech on 02/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import "ModelFolders.h"

@protocol CallContactsServiceDelegate <NSObject>

-(void)callWebServiceWithDict:(NSMutableDictionary *)dict;

@end
@interface ContactsPopupController : ViewControllerBaseClassViewController

@property(nonatomic,strong) ModelFolders *objFolders;
@property(nonatomic,weak)id<CallContactsServiceDelegate>delegate;

@end
