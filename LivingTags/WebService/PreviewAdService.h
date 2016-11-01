//
//  PreviewAdService.h
//  LivingTags
//
//  Created by appsbeetech on 01/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface PreviewAdService : WebServiceBaseClass

+(id)service;

-(void)previewAdServiceWithKey:(NSString *)strtkey withCompletionHandler:(WebServiceCompletion)handler;

@end
