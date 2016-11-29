//
//  CommentListingService.h
//  LivingTags
//
//  Created by appsbeetech on 29/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CommentListingService : WebServiceBaseClass

+(id)service;

-(void)callChatListingServiceWithAKey:(NSString *)strAkey page:(int)page published:(NSString *)strPublished withCompletionHandler:(WebServiceCompletion)handler;

@end
