//
//  ListingService.h
//  LivingTags
//
//  Created by appsbeetech on 09/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ListingService : WebServiceBaseClass

-(void)callListServiceWithUserID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)handler;

+(id)service;

@end
