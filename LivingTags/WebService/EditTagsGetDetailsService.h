//
//  EditTagsGetDetailsService.h
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface EditTagsGetDetailsService : WebServiceBaseClass

+(id)service;

-(void)getTagDetailsWithtKEy:(NSString *)strTkey withCompletionHandler:(WebServiceCompletion)handler;

@end
