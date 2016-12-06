//
//  CommentDetailsService.h
//  LivingTags
//
//  Created by appsbeetech on 06/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CommentDetailsService : WebServiceBaseClass

+(id)service;

-(void)callCommentDetailsServiceWithAKey:(NSString *)strAkey tcKey:(NSString *)strTCKey withCompletionHandler:(WebServiceCompletion)handler;


@end
