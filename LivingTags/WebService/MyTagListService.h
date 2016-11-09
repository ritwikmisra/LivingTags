//
//  MyTagListService.h
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface MyTagListService : WebServiceBaseClass

+(id)service;

-(void)callListServiceWithakey:(NSString *)strAkey  tcKey:(NSString *)strTCKey withCompletionHandler:(WebServiceCompletion)handler;

@end
