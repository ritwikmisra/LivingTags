//
//  DeleteTagService.h
//  LivingTags
//
//  Created by appsbeetech on 09/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface DeleteTagService : WebServiceBaseClass

+(id)service;

-(void)deleteTagWithTKey:(NSString *)strTKey aKey:(NSString *)strAKey withCompletionHandler:(WebServiceCompletion)handler;

@end
