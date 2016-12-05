//
//  UpdateObituaryService.h
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface UpdateObituaryService : WebServiceBaseClass

+(id)service;

-(void)callUpdateObituaryServiceWithTKey:(NSString *)strTKey obituaryID:(NSString *)strObituaryID withCompletionHandler:(WebServiceCompletion)handler;

@end
