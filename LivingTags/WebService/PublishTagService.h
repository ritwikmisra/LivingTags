//
//  PublishTagService.h
//  LivingTags
//
//  Created by appsbeetech on 01/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface PublishTagService : WebServiceBaseClass

+(id)service;

-(void)publishTagServiceWithKey:(NSString *)strTkey tName:(NSString *)strTName aFolder:(NSString *)strAFolder tFolder:(NSString *)strTFolder withCompletionHandler:(WebServiceCompletion)handler;

@end
