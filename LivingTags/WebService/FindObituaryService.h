//
//  FindObituaryService.h
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface FindObituaryService : WebServiceBaseClass

+(id)service;

-(void)callFindObituaryServiceWIthTkey:(NSString *)strTKey withCompletionHandler:(WebServiceCompletion)handler;

@end
