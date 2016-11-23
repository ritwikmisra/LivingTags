//
//  DeleteVoiceService.h
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface DeleteVoiceService : WebServiceBaseClass

+(id)service;

-(void)deleteVoiceServiceWithTKey:(NSString *)strTkey aKey:(NSString *)strAkey withCompletionHandler:(WebServiceCompletion)handler;

@end
