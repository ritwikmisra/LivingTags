//
//  DashboardMyTagsListingService.h
//  LivingTags
//
//  Created by appsbeetech on 12/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface DashboardMyTagsListingService : WebServiceBaseClass

+(id)service;

-(void)callDashboardMyTagsListServiceWithAkey:(NSString *)strAKey page:(int)page withCompletionHandler:(WebServiceCompletion)handler;

@end
